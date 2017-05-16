sub vcl_recv {
    if (   req.url.path ~ "^/svc/bitly/"
        || (req.url.path ~ "^/svc/dining/" && req.http.x-environment == "stg")
        || req.url.path ~ "^/svc/location/"
        || req.url.path ~ "^/svc/mostpopular/"
        || req.url.path ~ "^/svc/news/"
        || req.url.path ~ "^/svc/weather/"
    ) {
        set req.http.X-PageType = "content-api";
        call set_content_api_backend;
        set req.grace = 24h;

        unset req.http.X-Cookie;
        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-wpab;

        return(pass);
    }
}

sub vcl_fetch {
    if (req.http.X-PageType == "content-api") {
        // use very short cache TTL for HTTP 4XXs
        if (beresp.status >= 400 && beresp.status < 500) {
            set beresp.ttl = 3s;
        }

        if (beresp.status >= 500) {
            /* deliver stale if the object is available */
            if (stale.exists) {
                return(deliver_stale);
            }
            return(restart);
        }

        # set beresp.grace = 86400s; # equivalent to next line
        set beresp.stale_if_error = 86400s;
        set beresp.stale_while_revalidate = 30s;
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "content-api") {
        set resp.http.X-API-Version = "CA";
    }
}

sub set_content_api_backend {
    if (req.http.host ~ "\.dev\.") {

    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = content_api_stg;
    } else {
        set req.backend = content_api_prd;
    }
}