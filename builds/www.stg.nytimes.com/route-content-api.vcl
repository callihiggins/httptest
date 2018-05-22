sub recv_route_content_api {
    if (   req.url.path ~ "^/svc/bitly/"
        || req.url.path ~ "^/svc/dining/"
        || req.url.path ~ "^/svc/location/"
        || req.url.path ~ "^/svc/mostpopular/"
        || req.url.path ~ "^/svc/topics/"
        || req.url.path ~ "^/svc/news/"
        || req.url.path ~ "^/svc/weather/"
    ) {
        set req.http.x-nyt-route = "content-api";
        set req.http.x-nyt-backend = "content_api";

        set req.http.var-nyt-force-pass = "true";
    }

    if (req.url.path ~ "^/svc/oembed/"){
        set req.http.x-nyt-route = "content-api-gae";
        set req.http.x-nyt-backend = "gae_oembed_content_api";
    }
}

sub miss_pass_route_content_api {

    # host header for gae route
    if (req.http.x-nyt-route == "content-api-gae") {
        if (req.http.var-nyt-env == "prd") {
            set bereq.http.host = "nyt-du-prd.appspot.com";
        } else {
            set bereq.http.host = "nyt-du-dev.appspot.com";
        }
    }

    if (req.http.x-nyt-route == "content-api" || req.http.x-nyt-route == "content-api-gae") {
        unset bereq.http.cookie;
    }
}

sub deliver_content_api_version {
    if (req.http.x-nyt-route == "content-api") {
        set resp.http.X-API-Version = "CA";
    }
}
