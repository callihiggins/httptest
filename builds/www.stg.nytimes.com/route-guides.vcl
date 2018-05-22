sub recv_route_guides {
    if (   req.url ~ "^/well/"
        || req.url ~ "^/guides/"
        || req.url.path == "/guides"
    ) {
        set req.http.x-nyt-route = "guides";
        set req.http.x-nyt-backend = "beta_guides";
        set req.http.var-nyt-send-gdpr = "true";
    }
}

sub miss_pass_route_guides {

    unset bereq.http.cookie;

    if (req.http.x-nyt-route == "guides") {
        call set_guides_frontend_host;
    }
}

sub set_guides_frontend_host {
    if (req.http.var-nyt-env == "dev") {
        set bereq.http.host = "frontend.guides.stg.nyt.net";
    } else if (req.http.var-nyt-env == "stg") {
        set bereq.http.host = "frontend.guides.stg.nyt.net";
    } else {
        set bereq.http.host = "frontend.guides.prd.nyt.net";
    }
}
