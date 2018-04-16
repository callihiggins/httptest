sub recv_route_guides {

    if (   req.url ~ "^/well/"
        || req.url ~ "^/guides/"
        || req.url.path == "/guides"
    ) {
        set req.http.X-PageType = "guides";
        set req.http.x-nyt-backend = "beta_guides";
        set req.backend = F_beta_guides;
    }

}
