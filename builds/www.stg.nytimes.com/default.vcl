include "acl-internal";
include "acl-external-staging-access"
include "sanitize-url";
include "normalize-url";
include "initialize-vars";
include "frame-buster";
include "health-check";
include "ipauth";
include "www-redirect";
include "backends-main";
include "backend-well";
include "backend-elections";
include "backend-watching";
include "backend-games";
include "backend-weddings-api";
include "community-esi";
include "https-redirect";
include "device-detect";
include "cookie";
include "userinfo";
include "querystring";
include "mobile-redirect";
include "homepage-redirect";
include "glogin-redirect";
include "uuid";
include "response-headers";

sub vcl_recv {
#FASTLY recv

  # Set the edge req header
  set req.http.X-NYT-Edge-CDN = "Fastly";

  if (req.request != "HEAD" && req.request != "GET" && req.request != "FASTLYPURGE") {
    return(pass);
  }

  // block everyone but the internal ACL to dev service
  if ( client.ip !~ internal && req.http.host ~ "\.dev\.") {
      error 403 "Forbidden";
  }

  // block everyone but internal acl and staging access acl to staging service
  if ( client.ip !~ internal && client.ip !~ external_staging_access && req.http.host ~ "\.stg\.") {
      error 403 "Forbidden";
  }


  if ( req.backend == www_dev
    || req.backend == www_stg
    || req.backend == www_prd
    || req.backend == www_https_dev
    || req.backend == www_https_stg
    || req.backend == www_https_prd
    ) {
    return(pass);
  }

  // URIs not accessible via Varnish VIPs
  if (   req.url ~ "^/svc/web-shell/"
      || req.url ~ "^/svc/web-products/shell/"
      || req.url ~ "^/apc-stats/"
      || req.url ~ "^/phpinfo/"
  ) {
      set req.url = "/404.html";
  }

  if (req.backend.healthy) {
      set req.grace = 15s;
  } else {
      set req.grace = 24h;
  }

  // remove the Authorization header for video-api calls
  // it is diabled and we will implement it in Fastly soon
  if(req.http.X-PageType == "video-api"){
    unset req.http.Authorization;
  }

  if (req.http.Authorization || req.http.Cookie) {
    /* Not cacheable by default */
    return(pass);
  }

  // removing because Symfony2 Request object will use this for getUri() if present
  if (req.http.X-Original-Url) {
      remove req.http.X-Original-Url;
  }

  return(lookup);
}

sub vcl_fetch {
#FASTLY fetch

  # setting this for debugging
  set req.http.X-NYT-Backend = beresp.backend.name;

  # Vary on this header for HTTPS version, so we can purge both versions at the same time
  if (beresp.http.Vary) {
    set beresp.http.Vary = beresp.http.Vary ", req.http.Fastly-SSL";
  } else {
    set beresp.http.Vary = "req.http.Fastly-SSL";
  }

  # unset headers for cacheable community requests
  if (req.http.X-PageType == "community-svc-cacheable") {
    esi;
    unset beresp.http.Cache-Control;
    unset beresp.http.Pragma;
  }

  # legacy cacheable content should not be private
  if(req.http.X-PageType == "legacy-cacheable"){
    unset beresp.http.Cache-Control;
  }

  set beresp.http.X-Origin-Time = strftime({"%F %T EDT"}, time.sub(now,4h));

  # Fastly is now controlling nyt-a, if anyone else tries to set it, stop them
  # we're also going to remove set-cookie if RMID is there, no one is using it anymore
  # unfortunately this is greedy, we shouldn't be setting cookies in a cacheable request
  if(req.url !~ "^/adx") {
    if(setcookie.get_value_by_name(beresp,"nyt-a") || setcookie.get_value_by_name(beresp,"RMID")){
      remove beresp.http.Set-Cookie;
    }
  }

  if ((beresp.status == 500 || beresp.status == 503) && req.restarts < 1 && (req.request == "GET" || req.request == "HEAD")) {
    restart;
  }

  if (beresp.http.X-Is-NYT4) {
    set req.http.X-Is-NYT4 = "1";
    return(restart);
  }

  if (req.restarts > 0) {
    set beresp.http.Fastly-Restarts = req.restarts;
  }

  if (beresp.http.Set-Cookie) {
    set req.http.Fastly-Cachetype = "SETCOOKIE";
    return(pass);
  }

  if (beresp.http.Cache-Control ~ "private") {
    set req.http.Fastly-Cachetype = "PRIVATE";
    return(pass);
  }

  if (beresp.status == 500 || beresp.status == 503) {
    set req.http.Fastly-Cachetype = "ERROR";
    set beresp.ttl = 1s;
    set beresp.grace = 5s;
    return(deliver);
  }

  set beresp.grace = 24h;

  if (beresp.http.X-VarnishCacheDuration) {
    set beresp.ttl = std.atoi(beresp.http.X-VarnishCacheDuration);
  } else {
    # apply the default ttl
    # TODO: remove this condition when the services
    # implement setting X-VarnishCacheDuration
    if(req.http.X-PageType == "video-api"){
      set beresp.ttl = 30s;
    } else if (req.http.X-PageType == "messaging-api") {
      set beresp.ttl = 5s;
    } else if (req.http.X-PageType == "elections") {
      set beresp.ttl = 10s;
    } else {
      set beresp.ttl = 60s;
    }

  }

  return(deliver);
}

sub vcl_hit {
#FASTLY hit

  if (!obj.cacheable) {
    return(pass);
  }
  return(deliver);
}

sub vcl_miss {
#FASTLY miss

  // remove headers we set for processing cookie stuff
  // backend definitely doesn't need these
  remove bereq.http.x-nyt-edition;
  remove bereq.http.x-nyt-a;
  remove bereq.http.x-nyt-wpab;
  remove bereq.http.x-nyt-s;
  remove bereq.http.x-nyt-d;
  remove bereq.http.x-bcet-secret-key;

  // this should be removed already, but lets be sure
  // since this was a lookup we weren't pass
  remove bereq.http.Cookie;

  // cacheable community svc requests are ESI jsonp
  // we can't compress these... yet...
  if(req.http.X-PageType == "community-svc-cacheable"){
    unset bereq.http.Accept-Encoding;
    unset req.http.Accept-Encoding;
  }

  return(fetch);
}

sub vcl_hash {
#FASTLY hash
  set req.hash += req.url;
  set req.hash += req.http.host;

  // video library needs to pivot on device type
  if(req.http.X-PageType == "video-library"){
    set req.hash += req.http.device_type;
  }

  return(hash);
}

sub vcl_deliver {
#FASTLY deliver
  return(deliver);
}

sub vcl_error {
#FASTLY error
}

sub vcl_pass {
#FASTLY pass
}
