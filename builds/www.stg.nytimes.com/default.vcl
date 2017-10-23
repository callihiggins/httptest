include "acl-internal";
include "acl-vpc-gateway";
include "acl-external-staging-access";
include "acl-crawlers";
include "acl-blacklist";
include "error-pages";
include "surrogate-key";
include "sanitize-url";
include "normalize-url";
include "initialize-vars";
include "geoip-timezone-map-table";
include "geoip-location-consolidation-map-table";
include "geoip-service";
include "frame-buster";
include "health-check";
include "ipauth";
include "www-redirect";
include "tips";
include "article-allocation";

# the following files define the backends themselves
include "backends-dev";
include "backends-stg";
include "backends-prd";
include "backends-deadend";
# end defining backends

# this adds vcl_fetch logic for logging purposes
include "backend-init-vars";

# this backend route logic needs to come before all others
include "backends-glogin-healthcheck";

# the following files contain routes for the backends defined above
include "backend-health-service"; # service that reports health of defined backends
include "backends-main";
include "backend-well";
include "backend-elections";
include "backend-newsdev-gke";
include "backend-newsdev-gcs";
include "backend-intl";
include "backend-watching";
include "backend-games";
include "backend-programs";
include "backend-weddings-api";
include "backend-subscription";
include "backend-content-api";
include "backend-times-journeys";
include "backend-video";
include "backend-tbooks";
include "backend-adx-static";



# begin other logic
include "vi-allocation";
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

  # Set the edge req header
  set req.http.X-NYT-Edge-CDN = "Fastly";

  if (req.request != "HEAD" && req.request != "GET" && req.request != "FASTLYPURGE") {
    return(pass);
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

sub vcl_hash {
#FASTLY hash
  set req.hash += req.url;
  set req.hash += req.http.host;

  // video library needs to pivot on device type
  if(req.http.X-PageType == "video-library"){
    set req.hash += req.http.device_type;
  }

  # create new hashes based on geo if rendering project vi home
  if(req.http.x--fastly-project-vi && req.url.path == "/"){
    set req.hash += req.http.x-nyt-geo-hash;
    set req.hash += req.http.device_type;
  }


  return(hash);
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

  call unset_extraneous_bereq_headers;

  // this should be removed already, but lets be sure
  // since this was a lookup we were not pass
  remove bereq.http.Cookie;

  // cookie removing for collection
  if(req.http.X-PageType == "collection"){
    unset bereq.http.X-Cookie;
  }

  // cookie removing for article
  if(req.http.X-PageType == "article"){
    unset bereq.http.X-Cookie;
  }  

  // cacheable community svc requests are ESI jsonp
  // we can not compress these... yet...
  if(req.http.X-PageType == "community-svc-cacheable"){
    unset bereq.http.Accept-Encoding;
    unset req.http.Accept-Encoding;
  }

  return(fetch);
}

sub vcl_pass {
#FASTLY pass
  call unset_extraneous_bereq_headers;

  // cookie removing for collection
  if(req.http.X-PageType == "collection"){
    unset bereq.http.Cookie;
    unset bereq.http.X-Cookie;
  }
  // cookie removing for article
  if(req.http.X-PageType == "article"){
    unset bereq.http.Cookie;
    unset bereq.http.X-Cookie;
  }    

}

sub vcl_fetch {

  # This logic will handle serving stale content if we got an error from the backend
  if (beresp.status >= 500 && beresp.status < 600) {

      # Deliver stale if the object is avilable
      if (stale.exists) {
        return(deliver_stale);
      }

      # if the object was not in cache and we have not restarted, try one more time
      if (req.restarts < 1 && (req.request == "GET" || req.request == "HEAD")) {
        restart;
      }

      set req.http.Fastly-Cachetype = "ERROR";

      /*
        we got an error and we already restarted at least once, time to bail
        return a pretty error page if the requested page was an html page
        assuming ending in .html or "/" is good enough here.
        otherwise lets just return the default Fastly page
        Doing this to limit what gets a large error page download
      */

      if ( (req.url.path ~ ".html$" || req.url.path ~ "/$")
           && (req.url.path !~ "^/svc" && req.url.path !~ "^/adx")
          ) {
        error 503;
      }

  }

  # if we did not get an error from the backend, set stale content handling headers
  # per https://tools.ietf.org/html/rfc5861
  if (beresp.status < 500) {
      if (beresp.http.Cache-Control !~ "stale-if-error") {
        set beresp.stale_if_error = 86400s;
      }
      if (beresp.http.Cache-Control !~ "stale-while-revalidate") {
        set beresp.stale_while_revalidate = 60s;
      }
  }

  # DO NOT REMOVE THE NEXT LINE - FASTY SPECIFIC MACRO
#FASTLY fetch

  # moved the next two blocks up the chain
  # these running earlier is faster
  if (beresp.http.X-Is-NYT4) {
    set req.http.X-Is-NYT4 = "1";
    return(restart);
  }

  if (beresp.http.X-Vi-Cluster) {
    set req.http.X-Vi-Cluster = beresp.http.X-Vi-Cluster;

    if (req.http.X-RelevantBackendStatus != "unchanged") {
      return (restart);
    }
  }

  # Vary on this header for HTTPS version, so we can purge both versions at the same time
  if (beresp.http.Vary) {
    set beresp.http.Vary = beresp.http.Vary ", Fastly-SSL";
  } else {
    set beresp.http.Vary = "Fastly-SSL";
  }

  # hacky, TODO: fix the backends
  # unset headers for cacheable community requests
  if (req.http.X-PageType == "community-svc-cacheable") {
    esi;
    unset beresp.http.Cache-Control;
    unset beresp.http.Pragma;
  }

  # hacky, TODO: fix the backends
  # legacy cacheable content should not be private
  if(req.http.X-PageType == "legacy-cacheable"){
    unset beresp.http.Cache-Control;
  }

  set beresp.http.X-Origin-Time = strftime({"%F %T EDT"}, time.sub(now,4h));

  # Fastly is now controlling nyt-a, if anyone else tries to set it, stop them
  # we are also going to remove set-cookie if RMID is there, no one is using it anymore
  # unfortunately this is sloppy but we do not have much choice
  # TODO: Backends stop setting nyt-a and RMID cookies
  if(req.url !~ "^/adx") {
    if(setcookie.get_value_by_name(beresp,"nyt-a") || setcookie.get_value_by_name(beresp,"RMID")){
      remove beresp.http.Set-Cookie;
    }
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

  set beresp.grace = 24h;

  if (beresp.http.X-VarnishCacheDuration) {
    # NYT custom header
    # TODO: DEPRECATED - DO NOT USE THIS FOR NEW IMPLEMENTATIONS
    set beresp.ttl = std.atoi(beresp.http.X-VarnishCacheDuration);
  } else if (beresp.http.Expires || beresp.http.Surrogate-Control ~ "max-age" || beresp.http.Cache-Control ~ "(s-maxage|max-age)") {
    #    These are the OFFICIAL STANDARD
    #    Fastly honors these in the following priority order
    # 1. Surrogate-Control header max-age (this will be removed from client response)
    # 2. Cache-Control header s-maxage (Only Fastly honors, is not removed from client response)
    # 3. Cache-Control header max-age (Browser and downstream cache will also honor this)
    # 4. Expires header
  } else {
    # pagetype defaults
    # TODO: remove these conditionals when origins implement one of the above OFFICIAL standrds
    if(req.http.X-PageType == "video-api"){
      set beresp.ttl = 30s;
    } else if (req.http.X-PageType == "messaging-api") {
      set beresp.ttl = 5s;
    } else {

      # this is the catch-all default TTL if the object is cacheable and does none of the above
      set beresp.ttl = 60s;
    }
  }

  return(deliver);
}

sub vcl_deliver {
#FASTLY deliver
  return(deliver);
}

sub vcl_error {
#FASTLY error

  # handle 50x errors if the error handler was called
  # with a 500-599 code
  if (obj.status >= 500 && obj.status < 600) {

    # deliver stale object if it is available
    if (stale.exists) {
      return(deliver_stale);
    }

    call render_50x_page;

    return(deliver);
  }


}

sub vcl_log {
#FASTLY log

    # sumologic log
    # do not log services and adx requests unless they are a 5xx response, also always log in staging
    if ( (req.url !~ "^/svc/" && req.url !~ "^/adx/") || resp.status >= 500 || req.http.x-environment != "prd") {
      log {"syslog "} + req.service_id + {" "} + req.http.x-nyt-logger-name + {" :: "}
      req.http.Fastly-Client-IP
      {" "-" "-" "}
      {"["} strftime({"%d/%b/%Y:%H:%M:%S %z"}, time.start) {"]"}
      {" "} cstr_escape(req.http.host)
      {" ""} cstr_escape(req.request) " " cstr_escape(req.url) " " cstr_escape(req.proto) {"""}
      {" "} resp.status
      {" "} regsub(resp.body_bytes_written, "^0$", {""-""})
      {" ""} cstr_escape(req.http.referer) {"""}
      {"" ""} cstr_escape(req.http.user-agent) {"""}
      {" backend=["} if(req.http.X-NYT-Backend,req.http.X-NYT-Backend,"-") {"]"}
      {" pagetype=["} if(resp.http.X-PageType,resp.http.X-PageType,"-") {"]"}
      {" apiversion=["} if(resp.http.X-API-Version,resp.http.X-API-Version,"-") {"]"}
      {" cachetype=["} if(fastly_info.state,fastly_info.state,"-") {"]"}
      {" reqtime=["} time.elapsed {"]"}
      {" reqsize=["} req.bytes_read {"]"}
      {" protocol=["} if(req.http.Fastly-SSL,"https","http") {"]"}
      {" behealth=["} if(req.http.x-nyt-backend-health,req.http.x-nyt-backend-health,"-") {"]"}
      {" vialloc=["} if(req.http.x--fastly-project-vi,"1","0") {"]"}
      {" restarts=["} req.restarts {"]"}
      if(req.http.x-redirect-reason, {" "} + req.http.x-redirect-reason, "")
      if(req.http.x-vi-health, {" "} + req.http.x-vi-health, "");
    }
  }

sub unset_extraneous_bereq_headers {
  // remove headers used as variables for logic
  // backend definitely does not need these
  unset bereq.http.x-nyt-edition;
  unset bereq.http.x-nyt-a;
  unset bereq.http.x-nyt-wpab;
  unset bereq.http.x-nyt-s;
  unset bereq.http.x-nyt-d;
  unset bereq.http.x-bcet-secret-key;
  unset bereq.http.x-nyt-glogin-error-skip-key;
}