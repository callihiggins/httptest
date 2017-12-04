sub vcl_recv {
    if (   req.url.path ~ "^/svc/bitly/"
        || req.url.path ~ "^/svc/dining/"
        || req.url.path ~ "^/svc/location/"
        || req.url.path ~ "^/svc/mostpopular/"
        || req.url.path ~ "^/svc/topics/"
        || req.url.path ~ "^/svc/news/"
        || req.url.path ~ "^/svc/weather/"
    ) {
        set req.http.X-PageType = "content-api";
        set req.http.x-nyt-backend = "content_api";
        call set_content_api_backend;
        set req.grace = 24h;

        unset req.http.X-Cookie;
        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-wpab;

        return(pass);
    } 
    if (req.url.path ~ "^/svc/oembed/"){
        set req.http.X-PageType = "content-api-gae";
        set req.http.x-nyt-backend = "gae_oembed_content_api";
        set req.grace = 24h;

        unset req.http.X-Cookie;
        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-wpab;
        return(lookup);
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
    set req.backend = F_content_api;
}

sub vcl_pass {
    call set_gae_content_api_backend;
}

sub vcl_miss {
    call set_gae_content_api_backend;
}

sub set_gae_content_api_backend {
    if (req.http.X-PageType == "content-api-gae") {
        set req.backend = F_gae_oembed_content_api;

        if (req.http.x-environment == "prd") {
            set bereq.http.host = "nyt-du-prd.appspot.com";
        } else {
            set bereq.http.host = "nyt-du-dev.appspot.com";
        }
    }
}
