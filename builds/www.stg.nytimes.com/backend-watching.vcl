sub vcl_recv {

    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (   req.url ~ "^/watching$"
            || req.url ~ "^/watching\?"
            || req.url ~ "^/watching/"
            || req.url ~ "^\/\d{4}\/\d{2}\/\d{2}\/watching\/"
        ) {
            if (req.url ~ "^/watching/api/users/") {
                set req.http.X-PageType = "watching-nocache";
            } else {
                set req.http.X-PageType = "watching";
            }
            set req.backend = F_beta_watching;
            set req.http.x-nyt-backend = "beta_watching";
            set req.grace = 24h;
            unset req.http.x-nyt-edition;
            unset req.http.x-nyt-s;
            unset req.http.x-nyt-wpab;

            if (req.http.X-PageType == "watching-nocache") {
                return(pass);
            }
        }
    }
}

sub vcl_hash {
    if (req.http.X-PageType == "watching-nocache") {
        if (! req.http.Cookie && req.http.X-Cookie) {
            set req.http.Cookie = req.http.X-Cookie;
            unset req.http.X-Cookie;
        }
    }
}

sub vcl_fetch {
    if (req.http.X-PageType == "watching") {
        // use very short cache TTL for HTTP 4XXs
        if (beresp.status >= 400 && beresp.status < 500) {
            set beresp.ttl = 3s;
        }

        if (beresp.status >= 500) {
            /* deliver stale if the object is available */
            if (stale.exists) {
                return(deliver_stale);
            }

            # if the object was not in cache and we have not restarted, try one more time
            if (req.restarts < 1 && (req.request == "GET" || req.request == "HEAD")) {
                restart;
            }

            set req.http.Fastly-Cachetype = "ERROR";
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType ~ "^watching") {
        set resp.http.X-API-Version = "W2";
    }
}
