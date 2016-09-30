include "acl-internal.vcl";
include "backends.vcl";
include "cache-reset.vcl";
include "frame-buster.vcl";
include "www-redirect.vcl";
include "mw-redirect.vcl";
include "https-redirect.vcl";
include "csp.vcl";

sub vcl_recv {
#FASTLY recv

    # Set the edge req header
    set req.http.X-NYT-Edge-CDN = "Fastly";

    # From mobileweb config
    set req.backend = default;

    # From mobileweb config, combined with Fastly boilerplate
    if (req.request != "GET" && req.request != "HEAD" && req.request != "FASTLYPURGE") {
        # We only deal with GET and HEAD but there is one path that we forward to realestate that needs POST
        #  and another path for subscription reminder emails

        if (req.request != "POST") {
            error 405 "Method not allowed";
        }
        if (req.url !~ "^/iphone/re/login|^/svc/subscription-reminder-email$") {
            error 405 "Method not allowed";
        }
    }

    # Copied from www config
    if (!client.ip ~ internal) {
        # XXX -- we should change this to Fastly syslog -- stephen
        # log "Unauthorized request from " + client.ip + " for " + req.url;
        error 405 "Method not allowed";
    }

    # Let's save the cookie header so we can inspect it later.
    set req.http.X-Cookie = req.http.Cookie;

    # Handle cname redirects
    if (
        req.http.host == "m.nytimes.com" ||
        req.http.host == "wap.nytimes.com" ||
        req.http.host == "m.nyt.com"
    ) {
        error 751 req.url;
    } else if (
        req.http.host == "m.iht.com" ||
        req.http.host == "mobile.iht.com" ||
        req.http.host == "wap.iht.com" ||
        req.http.host == "m.iht.com"
    ) {
        error 752 req.url;
    }


    # We don't ever want to cache the user details page in Varnish. So we make
    #  an early exit with 'pass', to say that we don't want it to run a lookup
    if (   req.url ~ "^/user/details"
        || req.url ~ "^/recommendations/svc/personalized.json"
        || req.url ~ "^/svc/"
        || (req.url ~ "\?showjson$" && client.ip ~ internal)
    ) {
        return (pass);
    }

    # Redirect to Desktop (www) if nyt-mobile=0 and user is not requesting a blog, a blog-slideshow or an article
    set req.http.url = regsub(req.url, "(\?&?)$", "");
    if (req.http.Cookie ~ "(?:^|;)\s*nyt-mobile=0" && req.http.url ~ "^/(\S+/)?(\S+/)?$" &&
        !req.url ~ "^/slideshow/(\d+)/([\w/-]+)/$" &&
        !req.url ~ "(saved|resetmobile|redirect|.html|^/(comments/)?blogs/(.*)?/(\d{4})/(\d{2})/(\d{2})/([\w\d-]+)(/)?$)") {

        error 753 "Moved Temporarily";
    }

    # Handle geoip lookup
    if ((!req.http.Cookie ~ "(?:^|;)\s*NYT-Loc=") || (req.url == "/" && !req.http.Cookie ~ "(?:^|;)\s*NYT-Edition=")) {
        set req.http.X-GeoIP-Country = geoip.country_code;
    }

    # Handle redirects based on geoip lookup
    if (req.url == "/" && !req.http.Cookie ~ "(?:^|;)\s*NYT-Edition=") {
        if (req.http.X-GeoIP-Country && req.http.X-GeoIP-Country != "Unknown" && req.http.X-GeoIP-Country != "US" && req.http.X-GeoIP-Country != "CA"){
            error 750 "Moved Temporarily";
        }
    }
    if (req.url == "/" && req.http.Cookie ~ "(?:^|;)\s*NYT-Edition=edition.GLOBAL") {
        error 750 "Moved Temporarily";
    }
    if (req.url == "/" && req.http.Cookie ~ "(?:^|;)\s*NYT-Edition=edition.SPANISH") {
        error 754 "Moved Temporarily";
    }

    # Remove Query String
    if (   req.url !~ "^/switch-edition"
        && req.url !~ "^/search"
        && req.url !~ "^/redirect"
        && req.url !~ "^/timeswire"
        && req.url !~ "^/business/markets/quote"
        && req.url !~ "^/svc/"
        && req.url !~ "^/json/nav"
        && req.url !~ "^/html/trending\.html"
        && req.url !~ "^/free-trial") {
        
        set req.url = regsub(req.url, "\?.*", "");
    }

    # From mobileweb config
    if (req.backend.healthy) {
        set req.grace = 1m;
    } else {
        set req.grace = 6h;
    }

    # If request is facebook instant article (.native), return 404
    if (req.url ~ "\.native$") {
        error 404 "Not Found"; #Audit should this be a 403?#
    }

    # If request for a native optimized article (.samizdat), return 404 unless request originates from nyt
    if (req.url ~ "\.samizdat$" || req.url ~ "^\/hybrid\/") {
        if (client.ip ~ internal) {
            # avoid serving cached 404s to samizdat
            # always serve from backend and don't cache
            return (pass);
        } else {
            error 404 "Not Found"; #Audit should this be a 403?#
        }
    }

    # The favicon is hosted elsewhere
    if (req.url == "/favicon.ico") {
        error 752 "Moved Permanently";
    }

    # AMP
    if (req.url ~ "\.amp\.html" && !(req.url ~ "^\/redirect")) {
        if (req.http.User-Agent ~ "googlebot" || client.ip ~ internal) {
            # avoid serving cached 403s to googlebot
            # always serve from backend and don't cache
            return (pass);
        } else {
            error 753 "Moved Temporarily";
        }
    }

    # All Varnish requests must have the cookie values removed in order to cache correctly.
    unset req.http.Cookie;

    # From mobileweb config
    if (req.http.NYT-App-Type) {
        set req.http.NYT-chromeless = "1";
    }

    # Check for 3rd party lib disable flags
    set req.http.NYT-disable-for-perf-key = ""; # set to some default value for hash

    if (req.http.NYT-disable-for-perf-test ~ "all") {
        set req.http.NYT-disable-for-perf-key = "all";
    }
    if (req.http.NYT-disable-for-perf-key != "all" && req.http.NYT-disable-for-perf-test ~ "amz") {
        set req.http.NYT-disable-for-perf-key = req.http.NYT-disable-for-perf-key + "amz|";
    }
    if (req.http.NYT-disable-for-perf-key != "all" && req.http.NYT-disable-for-perf-test ~ "gpt") {
        set req.http.NYT-disable-for-perf-key = req.http.NYT-disable-for-perf-key + "gpt|";
    }
    if (req.http.NYT-disable-for-perf-key != "all" && req.http.NYT-disable-for-perf-test ~ "krx") {
        set req.http.NYT-disable-for-perf-key = req.http.NYT-disable-for-perf-key + "krx|";
    }
    if (req.http.NYT-disable-for-perf-key != "all" && req.http.NYT-disable-for-perf-test ~ "mdotn") {
        set req.http.NYT-disable-for-perf-key = req.http.NYT-disable-for-perf-key + "mdotn|";
    }
    if (req.http.NYT-disable-for-perf-key != "all" && req.http.NYT-disable-for-perf-test ~ "tagx") {
        set req.http.NYT-disable-for-perf-key = req.http.NYT-disable-for-perf-key + "tagx|";
    }

    unset req.http.NYT-disable-for-perf-test;



    # Go Varnish, go!
    return(lookup);
}

sub vcl_hash {
    set req.hash += req.http.NYT-chromeless;   
    set req.hash += req.http.NYT-disable-for-perf-key;
}

sub vcl_fetch {
#FASTLY fetch

    if (beresp.http.content-type ~ "text"
        || beresp.http.content-type ~ "application/json"
        || beresp.http.content-type ~ "application/x-javascript"
        || beresp.http.content-type ~ "application/javascript") {
        set beresp.gzip = true;
    }

    # From mobileweb config
    if (req.url ~ "^/html/trending\.html") {
        if (beresp.status != 200 && beresp.status != 304) {
            set beresp.ttl = 1m;
            error 990;
        }
    }
    # Cache 404's and 500's for 1 minute to prevent a stampede on our node boxes
    if (beresp.status == 404 || beresp.status == 500) {
        set beresp.ttl = 1m;
        return (deliver);
    }

    # Copied from www config and adapted
    if (beresp.http.X-VarnishCacheDuration) {
        #set beresp.ttl = std.atoi(beresp.http.X-VarnishCacheDuration);
        set beresp.ttl = 60s;
        set beresp.grace = 6h;
        return (deliver);
    } else {
        # If we haven't set a server cache value, don't.
        return(pass);
    }

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

    # create NYT-Loc cookie if it doesn't already exist
    if (!req.http.X-Cookie ~ "(?:^|;)\s*NYT-Loc=") {
        if (req.http.X-GeoIP-Country && req.http.X-GeoIP-Country != "Unknown" && req.http.X-GeoIP-Country != "US"){
            set resp.http.X-Currency = "";
            if (req.http.X-GeoIP-Country ~ "(AT|BE|BG|CH|CY|CZ|DE|DK|EE|ES|FI|FR|GR|HR|HU|IE|IT|LT|LU|LV|MT|NL|PL|PT|RO|SE|SI|SK)") {
                set resp.http.X-Currency = "EUR";
            }
            else if (req.http.X-GeoIP-Country ~ "(GB)") {
                set resp.http.X-Currency = "GBP";
            }

            add resp.http.Set-Cookie = "NYT-Loc=i|" + resp.http.X-Currency + "|" + req.http.X-GeoIP-Country + ";path=/;domain=.nytimes.com;expires=" + strftime({"%a, %d-%b-%Y %T GMT"}, time.add(now, 7d));
            unset resp.http.X-Currency;
        } else {
            add resp.http.Set-Cookie = "NYT-Loc=d;path=/;domain=.nytimes.com;expires=" + 
            strftime({"%a, %d-%b-%Y %T GMT"}, time.add(now, 7d));
        }
    }

    # echo the perf-key along to the frontend if set
    if (req.http.NYT-disable-for-perf-key) {
      set resp.http.NYT-disable-for-perf-key = req.http.NYT-disable-for-perf-key;
    }

  return(deliver);
}

sub vcl_error {
    # restricted resources
    if (obj.status == 403) {
        set obj.status = 403;
        synthetic "";
        return(deliver);
    }

    # edition redirects
    if (obj.status == 750) {
        set obj.http.Location = "/international";
        set obj.status = 302;
        return(deliver);
    }
    if (obj.status == 754) {
        set obj.http.Location = "http://www.nytimes.com/es/";
        set obj.status = 302;
        return(deliver);
    }

    # CNAME redirects
    if (obj.status == 751 || obj.status == 752) {
        if (obj.status == 752 && req.url == "/") {
            set obj.http.Location = "http://mobile.nytimes.com/international";
        } elsif (obj.status == 752 && req.url == "/favicon.ico") {
            set obj.http.Location = "https://static01.nyt.com/images/icons/nyt.ico";
        } else {
            set obj.http.Location = "http://mobile.nytimes.com" + req.url;
        }
        set obj.status = 301;
        return(deliver);
    }

    # Mobileweb redirector
    if (obj.status == 753) {
        set obj.http.Location = "/redirect?to-www=" + req.url;
        set obj.status = 302;
        return(deliver);
    }

#FASTLY error
}

sub vcl_pass {
#FASTLY pass
}