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

        unset req.http.X-Cookie;
        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-wpab;

        set req.http.x-nyt-force-pass = "true";
        #return(pass);
    }

    if (req.url.path ~ "^/svc/oembed/"){
        set req.http.X-PageType = "content-api-gae";
        set req.http.x-nyt-backend = "gae_oembed_content_api";

        unset req.http.X-Cookie;
        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-wpab;
        #return(lookup);
    }
}

sub vcl_fetch {
    if (req.http.X-PageType == "content-api") {

        # stale-while-revalidate override
        set beresp.http.x-nyt-stale-while-revalidate = "30";
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
