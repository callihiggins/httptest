include "acl-internal";
include "sanitize-url";
include "normalize-url";
include "response-headers";
include "frame-buster";
include "health-check";
#include "ipauth";
include "www-redirect";
include "backends-main";
include "backend-well";
include "backend-elections";
include "https-redirect";
include "device-detect";
#include "nyt-a-aballoc";
include "cookie";
#include "userinfo.vcl";
include "querystring";
include "mobile-redirect";
include "homepage-redirect";
#include "realestate-config";
#include "glogin-redirect";
include "uuid";
#include "rmid";
#include "abtest-config";
#include "interim-config";
#include "homepage-abtest";
#include "internal-https";

sub vcl_recv {
#FASTLY recv

  # Set the edge req header
  set req.http.X-NYT-Edge-CDN = "Fastly";

  if (req.request != "HEAD" && req.request != "GET" && req.request != "FASTLYPURGE") {
    return(pass);
  }

  if (!client.ip ~ internal && !req.http.X-NYT-PST) {
      # XXX -- we should change this to Fastly syslog -- stephen
      # log "Unauthorized request from " + client.ip + " for " + req.url;
      error 405 "Method not allowed";
  }

  if (req.backend == www_dev || req.backend == www_stg || req.backend == www_prd) {
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

  # Fastly is now controlling nyt-a, if anyone else tries to set it, stop them
  # any other cookie being set will just cause this to not be cacheable
  if(setcookie.get_value_by_name(beresp,"nyt-a") != ""){
    remove beresp.http.Set-Cookie;
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
    #set beresp.ttl = std.atoi(beresp.http.X-VarnishCacheDuration);
    set beresp.ttl = 60s;
  } else {
    # apply the default ttl
    set beresp.ttl = 60s;
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
  return(fetch);
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