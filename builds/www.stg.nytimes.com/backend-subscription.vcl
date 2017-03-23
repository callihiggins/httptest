include "subscription-currency-map-table";

sub vcl_recv {
    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (    req.url == "/subscription"
            ||  req.url ~ "^/subscription/"
            ) {

            if (req.http.x-environment == "stg") {
                set req.http.X-NYT-Currency = table.lookup(subscription_currency_map, geoip.country_code, "USD");
            }

            set req.http.X-PageType = "subscription";
            call set_subscription_backend;
            set req.grace = 24h;
            set req.http.x-skip-glogin = "1";
            unset req.http.x-nyt-edition;
            unset req.http.x-nyt-s;
            unset req.http.x-nyt-wpab;
            set req.url = querystring.remove(req.url);
            return(lookup);
        }
    }
}

sub vcl_hash {
    if (req.http.X-PageType == "subscription") {
        unset req.http.X-Cookie;
        unset req.http.Cookie;
    }
}

sub vcl_fetch {
    if (req.http.X-PageType == "subscription") {

        if (req.http.x-environment == "stg") {
            /* handle 5XX (or any other unwanted status code) */
            if (beresp.status >= 500 && beresp.status < 600) {

                /* deliver stale if the object is available */
                if (stale.exists) {
                  return(deliver_stale);
                }

                if (req.restarts < 1 && (req.request == "GET" || req.request == "HEAD")) {
                  restart;
                }

            }

            if (beresp.status < 500) {
                /* set stale_if_error and stale_while_revalidate (customize these values) */
                set beresp.stale_if_error = 86400s;
                set beresp.stale_while_revalidate = 60s;
            }
        }

        // use very short cache TTL for HTTP 4XXs
        if (beresp.status >= 400 && beresp.status < 500) {
            set beresp.ttl = 3s;
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "subscription") {

        set resp.http.X-API-Version = "WCM";

        if(resp.status == 301 || resp.status == 302) {
            set resp.http.Location = resp.http.Location + req.http.x-orig-querystring;
        }
    }
}


sub set_subscription_backend {
    if (req.http.host ~ "\.dev\.") {
        //set req.backend = ???;
    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = subscription_stg;
    } else {
        set req.backend = subscription_prd;
    }
}
