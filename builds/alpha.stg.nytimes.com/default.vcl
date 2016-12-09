include "acl-internal";
include "backends";

sub vcl_recv {
#FASTLY recv

  if (client.ip !~ internal) {
  	error 403 "Forbidden";
  }

  // redirect to https always
  if (!req.http.Fastly-SSL) {
    set req.http.X-Redirect-URL = "https://" + req.http.host + req.url;
    error 443 req.http.X-Redirect-Url;
  }

  if (req.http.host ~ "\.dev\.") {
    set req.backend = alpha_fe_dev;
  } else if (req.http.host ~ "\.stg\.") {
    set req.backend = alpha_fe_dev;
  } else {
    set req.backend = alpha_fe_prd;
  }

  if (req.request != "HEAD" && req.request != "GET" && req.request != "FASTLYPURGE") {
    return(pass);
  }

  return(lookup);
}

sub vcl_fetch {
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

  if (beresp.status == 500 || beresp.status == 503) {
    set req.http.Fastly-Cachetype = "ERROR";
    set beresp.ttl = 1s;
    set beresp.grace = 5s;
    return(deliver);
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
#FASTLY deliver

  if (client.ip ~ internal) {
    set resp.http.X-NYT-Backend = req.http.X-NYT-Backend;
  }

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
}

sub vcl_pass {
#FASTLY pass
}