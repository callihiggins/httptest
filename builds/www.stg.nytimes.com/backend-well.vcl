sub vcl_recv {

    if (   req.url ~ "^/well/"
        || req.url ~ "^/guides/"
        || req.url.path == "/guides"
    ) {
        set req.http.X-PageType = "well";
        call set_beta_well_backend;
        set req.grace = 24h;
        # XXX -- Consider unsetting this header at the top of recv so the client can't set it and bypass your auth -- stephen
        set req.http.x-skip-glogin = "1";
    }

    if (req.http.magicmarker-well == "fake") {
        unset req.http.magicmarker-well;
        set req.backend = beta_deadend;
        return(lookup);
    }
}

sub vcl_fetch {
    if (req.http.X-PageType == "well") {
        // use very short cache TTL for HTTP 4XXs
        if (beresp.status >= 400 && beresp.status < 500) {
            set beresp.ttl = 3s;
        }

        // use saint mode for HTTP 5XXs
        if (beresp.status >= 500) {
            set beresp.saintmode = 60s;
            restart;
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "well") {
        set resp.http.X-API-Version = "W";
    }
}

sub vcl_error {
    if (req.http.X-PageType == "well" && obj.status >= 500 && obj.status < 600) {
        set req.http.magicmarker-well = "fake";
        restart;
    }
}

sub set_beta_well_backend {
    if (req.http.x-environment == "dev") {
        set req.backend = beta_guides_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = beta_guides_stg;
    } else {
        set req.backend = beta_guides_prd;
    }
}
