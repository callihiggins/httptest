include "acl-internal";
include "initialize-vars";
include "geoip-timezone-map-table";
include "geoip";
include "backends";
include "device-detect";

sub vcl_recv {
#FASTLY recv

  if (client.ip !~ internal) {
  	error 403 "Forbidden";
  }

  // preview doesn't support https, so don't redirect
  if (req.http.host ~ "\.preview\.") {
    set req.backend = alpha_fe_preview;
    return(pass);
  }

  // redirect to https always
  if (!req.http.Fastly-SSL) {
    set req.http.X-Redirect-URL = "https://" + req.http.host + req.url;
    error 443 req.http.X-Redirect-Url;
  }

  // home team has a test backend
  if (req.http.host == "alpha-home.stg.nytimes.com") {
    set req.backend = alpha_home_branch;
    return(pass);
  }

  if (req.http.X-Deadend) {
    set req.backend = deadend;
  } else if (req.http.host ~ "\.dev\.") {
    set req.backend = alpha_fe_dev;
  } else if (req.http.host ~ "\.stg\.") {
    set req.backend = alpha_fe_dev;
  } else {
    set req.backend = alpha_fe_prd;
  }

  # use a test backend for alpha.test, targeted briefings needs this
  if (req.http.host == "alpha-test.stg.nytimes.com"){
    set req.backend = alpha_fe_test;
    set req.url = querystring.remove(req.url);
  }

  if (req.request != "HEAD" && req.request != "GET" && req.request != "FASTLYPURGE") {
    return(pass);
  }

  return(lookup);
}


sub vcl_hash {
#FASTLY hash
    set req.hash += req.url;
    set req.hash += req.http.host;

    # create new hashes based on geo if rendering home
    # alpha.test.nytimes.com FEATURE FLAG FOR NOW
    if(req.http.x-nyt-geo-hash
        && req.url.path ~ "^/$"
        && req.http.host == "alpha-test.stg.nytimes.com"){
        set req.hash += req.http.x-nyt-geo-hash;
    }

    return(hash);
}


sub vcl_fetch {

  // if a server error code
  if (beresp.status >= 500 && beresp.status < 600) {

    // serve stale if present
    if (stale.exists) {
      return(deliver_stale);
    }

    // if no stale exists, we should try again
    if (req.restarts < 1 && (req.request == "GET" || req.request == "HEAD")) {
      restart;
    }

    // if error after retry, serve a synthetic page b/c we're out of options
    error 503;
  }

  // equivalent to setting grace mode
  set beresp.stale_if_error = 86400s; // 1 day
  // allow serving stale while latest content is being generated
  set beresp.stale_while_revalidate = 30s;

#FASTLY fetch

  set req.http.X-NYT-Backend = beresp.backend.name;

  if ((beresp.status == 500 || beresp.status == 503) && req.restarts < 1 && (req.request == "GET" || req.request == "HEAD")) {
    restart;
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

  if (beresp.http.Expires || beresp.http.Surrogate-Control ~ "max-age" || beresp.http.Cache-Control ~ "(s-maxage|max-age)") {
    # keep the ttl here
  } else {
    # apply the default ttl
    set beresp.ttl = 3600s;
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
  if (resp.status >= 500 && resp.status < 600) {
    // restart if the stale object is available
    if (stale.exists) {
      restart;
    }
  }

  if (fastly_info.state ~ "HIT-STALE") {
    set resp.http.X-NYT-Served = "stale";
  }
  set resp.http.X-NYT-Backend = req.http.X-NYT-Backend;
  set resp.http.device_type = req.http.device_type;
  set resp.http.X-NYT-Device-Type = req.http.X-NYT-Device-Type;
  set resp.http.Device-Type = req.http.Device-Type;
  set resp.http.DeviceType = req.http.DeviceType;

  if (req.http.host == "alpha-test.stg.nytimes.com") {
    set resp.http.x-nyt-continent = req.http.x-nyt-continent;
    set resp.http.x-nyt-country = req.http.x-nyt-country;
    set resp.http.x-nyt-region = req.http.x-nyt-region;
    set resp.http.x-nyt-timezone = req.http.x-nyt-timezone;
  }

#FASTLY deliver

  return(deliver);
}

sub vcl_error {
#FASTLY error
    
  if (obj.status == 443) {
    set obj.http.Location = obj.response;
    set obj.status = 301;
    set obj.response = "Moved Permanently";
    return(deliver);
  }

  if (obj.status == 503) {

    /* deliver stale object if it is available */
    if (stale.exists) {
      return(deliver_stale);
    }

    /* otherwise, return a synthetic */
    synthetic {"<!DOCTYPE html><html>Backend is unhealthy and no stale content to serve.</html>"};
    return(deliver);
  }
}

sub vcl_pass {
#FASTLY pass
}
