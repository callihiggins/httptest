sub vcl_recv {

    if (   req.url ~ "^/well/"
        || req.url ~ "^/guides/"
        || req.url.path == "/guides"
    ) {
        set req.http.X-PageType = "well";
        set req.http.x-nyt-backend = "beta_guides";
        set req.backend = F_beta_guides;
    }

}

sub vcl_deliver {
    if (req.http.X-PageType == "well") {
        set resp.http.X-API-Version = "W";
    }
}
