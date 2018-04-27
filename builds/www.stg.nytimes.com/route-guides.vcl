sub recv_route_guides {

    if (   req.url ~ "^/well/"
        || req.url ~ "^/guides/"
        || req.url.path == "/guides"
    ) {
        set req.http.x-nyt-route = "guides";
        set req.http.x-nyt-backend = "beta_guides";
        set req.http.var-nyt-send-gdpr = "true";
        set req.backend = F_beta_guides;
    }

}
