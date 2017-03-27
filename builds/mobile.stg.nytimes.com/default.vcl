# put vcl_recv fastly macro first for consistent timings:
sub vcl_recv {
#FASTLY recv
}

# put vcl_deliver fastly macro first for consistent timings:
sub vcl_deliver {
#FASTLY deliver
}

sub vcl_pass {
#FASTLY pass
}

include "acl-internal";
include "acl-external-staging-access";
include "acl-crawlers";
include "acl-vpc-gateway";
include "initialize-vars";
include "geoip-timezone-map-table";
include "geoip";
include "backends-main";
include "backend-vp";
include "frame-buster";
include "www-redirect";
include "mw-redirect";
include "https-redirect";
include "device-detect";
include "cookie";
include "uuid";
include "vi-allocation";

sub vcl_recv {
    # Set the edge req header
    set req.http.X-NYT-Edge-CDN = "Fastly";

    # From mobileweb config, combined with Fastly boilerplate
    if (req.request != "GET" && req.request != "HEAD" && req.request != "FASTLYPURGE") {

        # For Project Vi graphql requests.
        #  TODO: requests from Relay will need cookies to go to Vi backend properly
        if (req.url ~ "^/graphql") {
            set req.backend = projectvi_fe_prd;
            return(pass);
        }


        # We only deal with GET and HEAD but there is one path that we forward to realestate that needs POST
        #  and another path for subscription reminder emails

        if (req.request != "POST") {
            error 405 "Method not allowed";
        }
        if (req.url !~ "^/iphone/re/login|^/svc/subscription-reminder-email$") {
            error 405 "Method not allowed";
        }
    }

    // block everyone but the internal ACL to dev service
    if ( client.ip !~ internal && req.http.host ~ "\.dev\.") {
        error 403 "Forbidden";
    }

    // block everyone but internal acl and staging access acl to staging service
    if ( client.ip !~ internal && client.ip !~ external_staging_access && req.http.host ~ "\.stg\.") {
        error 403 "Forbidden";
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

    # Handle spanish edition redirect
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

        set req.url = querystring.remove(req.url);
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
        if (client.ip ~ internal || client.ip ~ vpc_nat_gateway) {
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
        if (client.ip ~ googlebot || client.ip ~ internal || client.ip ~ vpc_nat_gateway) {
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
#FASTLY hash
    set req.hash += req.url;
    set req.hash += req.http.host;

    set req.hash += req.http.NYT-chromeless;
    set req.hash += req.http.NYT-disable-for-perf-key;
    set req.hash += req.http.x--fastly-project-vi;

    # create new hashes based on geo if rendering project vi home
    # STAGING FEATURE FLAG FOR NOW
    if(req.http.x-nyt-geo-hash
        && req.http.x--fastly-project-vi
        && req.url.path ~ "^/$"
        && req.http.x-environment == "stg"){
        set req.hash += req.http.x-nyt-geo-hash;
    }

    return(hash);
}

sub vcl_fetch {
#FASTLY fetch

    # Set backend name for debugging
    set beresp.http.X-NYT-Backend = beresp.backend.name;

    # Vi fetch behavior
    if (req.http.x--fastly-project-vi == "1") {

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

    # mobileweb fetch behavior
    } else {

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

        # Fastly is now controlling nyt-a, if anyone else tries to set it, stop them
        # any other cookie being set will just cause this to not be cacheable
        if (setcookie.get_value_by_name(beresp,"nyt-a")){
            remove beresp.http.Set-Cookie;
        }

        # Copied from www config and adapted
        if (beresp.http.X-VarnishCacheDuration) {
            set beresp.ttl = std.atoi(beresp.http.X-VarnishCacheDuration);
        } else {
            # If we haven't set a server cache value, use default for now
            set beresp.ttl = 180s;
        }
    }



  # Adapted Fastly boilerplate
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

  # Ignore "cache-control: private" from backend
  #if (beresp.http.Cache-Control ~ "private") {
  #  set req.http.Fastly-Cachetype = "PRIVATE";
  #  return(pass);
  #}

  # Vi has saint mode, so only apply this for mobileweb
  if (req.http.x--fastly-project-vi != "1") {
    if (beresp.status == 500 || beresp.status == 503) {
      set req.http.Fastly-Cachetype = "ERROR";
      set beresp.ttl = 1s;
      set beresp.grace = 5s;
      return(deliver);
    }
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

  // this should be removed already, but lets be sure
  // since this was a lookup we weren't pass
  remove bereq.http.Cookie;

  return(fetch);
}

sub vcl_deliver {
    if (client.ip ~ internal && req.http.x-nyt-debug ~ ".") {
        # geo debug headers
        set resp.http.x-nyt-continent = req.http.x-nyt-continent;
        set resp.http.x-nyt-country = req.http.x-nyt-country;
        set resp.http.x-nyt-region = req.http.x-nyt-region;
        set resp.http.x-nyt-timezone = req.http.x-nyt-timezone;
        set resp.http.x-nyt-geo-hash = req.http.x-nyt-geo-hash;

    # Don't pass these headers to external client IPs
    } else {
        remove resp.http.X-NYT-Backend;
        remove resp.http.x-origin-server;
        remove resp.http.X-VarnishCacheDuration;
        remove resp.http.via;
        remove resp.http.x-age;
        remove resp.http.X-Powered-By;
        remove resp.http.nnCoection;
        remove resp.http.X-Backend;
        remove resp.http.X-DetectedRuntimeConfigFlag;
        remove resp.http.X-ESI-Status;
        remove resp.http.X-Hash;
        remove resp.http.X-Varnish;

    }


    # Project Vi saint mode
    if (req.http.x--fastly-project-vi == "1" ) {
        if (resp.status >= 500 && resp.status < 600) {
            // restart if the stale object is available
            if (stale.exists) {
                restart;
            }
        }

        if (fastly_info.state ~ "HIT-STALE" && client.ip ~ internal) {
            set resp.http.X-NYT-Served = "stale";
        }

    # MW specific response logic
    } else {
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
                else if (req.http.X-GeoIP-Country ~ "(CA)") {
                    set resp.http.X-Currency = "CAD";
                }
                else if (req.http.X-GeoIP-Country ~ "(AU)") {
                    set resp.http.X-Currency = "AUD";
                }
                else if (req.http.X-GeoIP-Country ~ "(IN)") {
                    set resp.http.X-Currency = "INR";
                }

                add resp.http.Set-Cookie = "NYT-Loc=i|" + resp.http.X-Currency + "|" + req.http.X-GeoIP-Country + ";path=/;domain=.nytimes.com;expires=" + strftime({"%a, %d-%b-%Y %T GMT"}, time.add(now, 7d));
                unset resp.http.X-Currency;
            } else {
                add resp.http.Set-Cookie = "NYT-Loc=d;path=/;domain=.nytimes.com;expires=" +
                strftime({"%a, %d-%b-%Y %T GMT"}, time.add(now, 7d));
            }
        }

        # echo the perf-key along to the frontend if set
        if (req.http.NYT-disable-for-perf-key ~ ".") {
          set resp.http.NYT-disable-for-perf-key = req.http.NYT-disable-for-perf-key;
        }

        // remove deprecated internal https cookie
        if (client.ip ~ internal && req.http.Cookie:nyt.np.https-everywhere) {
            add resp.http.Set-Cookie =
                "nyt.np.https-everywhere=; " +
                "Expires=" + time.sub(now, 365d) + "; "+
                "Path=/ ;" +
                "Domain=.nytimes.com";
        }
    }

    // Content Security Policy for HTTPS
    if (req.http.Fastly-SSL && resp.http.Content-Type ~ "^text/html") {
        declare local var.csp STRING;
        declare local var.report-uri STRING;

        set var.csp = "default-src data: 'unsafe-inline' 'unsafe-eval' https:; script-src data: 'unsafe-inline' 'unsafe-eval' https: blob:; style-src data: 'unsafe-inline' https:; img-src data: https: blob:; font-src data: https:; connect-src https: wss:; media-src https: blob:; object-src https:; child-src https: data: blob:; form-action https:; block-all-mixed-content;";
        set var.report-uri = "report-uri https://nytimes.report-uri.io/r/default/csp/enforce;";

        if (req.http.x-environment == "prd") {
            // all internal traffic, and 1% of external traffic should report CSP violations
            if (client.ip ~ internal || randombool(1, 100)) {
                set resp.http.Content-Security-Policy = var.csp + " " + var.report-uri;
            } else {
                set resp.http.Content-Security-Policy = var.csp;
            }
        } else {
            set resp.http.Content-Security-Policy = var.csp;
        }
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
    if (obj.status == 754) {
        set obj.http.Location = "http://www.nytimes.com/es/";
        set obj.status = 302;
        return(deliver);
    }

    # CNAME redirects
    if (obj.status == 751 || obj.status == 752) {
        if (obj.status == 752 && req.url == "/") {
            set obj.http.Location = "http://mobile.nytimes.com";
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

    # Project Vi saint mode
    if (obj.status == 503) {

        /* deliver stale object if it is available */
        if (stale.exists) {
            return(deliver_stale);
        }

        /* otherwise, return a synthetic */
        synthetic {"<!DOCTYPE html><html>Backend is unhealthy and no stale content to serve.</html>"};
        return(deliver);
    }

#FASTLY error
}
