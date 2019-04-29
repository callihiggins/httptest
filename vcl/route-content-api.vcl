sub recv_route_content_api {
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

    if (req.http.x-nyt-route == "content-api-gae") {
        unset bereq.http.cookie;
    }
}
