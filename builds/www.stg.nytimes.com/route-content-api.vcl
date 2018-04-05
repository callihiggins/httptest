sub recv_route_content_api {
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

sub miss_pass_route_content_api {
    if (req.http.x-nyt-backend == "gae_oembed_content_api") {
        if (req.http.x-environment == "prd") {
            set bereq.http.host = "nyt-du-prd.appspot.com";
        } else {
            set bereq.http.host = "nyt-du-dev.appspot.com";
        }
    }
}

sub fetch_route_content_api {
    if (req.http.X-PageType == "content-api") {
        # stale-while-revalidate override
        set beresp.http.x-nyt-stale-while-revalidate = "30";
    }
}

sub deliver_content_api_version {
    if (req.http.X-PageType == "content-api") {
        set resp.http.X-API-Version = "CA";
    }
}
