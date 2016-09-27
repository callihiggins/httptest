backend beta_instance_prd_use1_1 {
    .host = "well-proxy-0.prd.np.newsdev.net";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/api/health";
        .timeout = 1s;
        .interval = 4s;
        .window = 10;
        .threshold = 9;
    }
}

backend beta_instance_prd_use1_2 {
    .host = "well-proxy-1.prd.np.newsdev.net";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/api/health";
        .timeout = 1s;
        .interval = 4s;
        .window = 10;
        .threshold = 9;
    }
}

director beta_well round-robin {
    { .backend = beta_instance_prd_use1_1; }
    { .backend = beta_instance_prd_use1_2; }
}

backend beta_deadend {
    .host = "localhost";
    .port = "8080";
    .dynamic = true;
    .probe = {
        .url = "/.status";
        .initial = 0;
        .interval = 1d;
    }
}

sub vcl_recv {
    if (req.url ~ "^/well/") {
        set req.http.X-PageType = "well";
        set req.backend = beta_well;
        set req.grace = 24h;
        # XXX -- Consider unsetting this header at the top of recv so the client can't set it and bypass your auth -- stephen
        set req.http.x-skip-glogin = "1";
        unset req.http.Cookie;
        unset req.http.X-Cookie;
        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-wpab;
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
        set resp.http.X-API-Version = "5-W";
    }
}

sub vcl_error {
    if (req.http.X-PageType == "well" && obj.status >= 500 && obj.status < 600) {
        set req.http.magicmarker-well = "fake";
        restart;
    }
}
