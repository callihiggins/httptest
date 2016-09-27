backend newsdev_instance_prd_use1_1 {
    .host = "23.21.133.252";
    .port = "80";
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/healthchecke";
        .timeout = 1s;
        .interval = 4s;
        .window = 10;
        .threshold = 9;
    }
}

director newsdev_elections round-robin {
    { .backend = newsdev_instance_prd_use1_1; }
}

sub vcl_recv {
    # Condensed this down to one pcre. Let me know if it's not correct --stephen
    if (req.url ~ "^/elections?(?:/|\?|$)") {
        set req.http.X-PageType = "elections";
        set req.backend = newsdev_elections;
        set req.grace = 24h;
        # XXX -- Consider unsetting this header at the top of recv so the client can't set it and bypass your auth -- stephen
        set req.http.x-skip-glogin = "1";
        unset req.http.Cookie;
        unset req.http.X-Cookie;
        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-wpab;
    }

    if (req.http.magicmarker-elections == "fake") {
        unset req.http.magicmarker-elections;
        set req.backend = deadend;
        return(lookup);
    }
}

sub vcl_fetch {
    if (req.http.X-PageType == "elections") {
        // use very short cache TTL for HTTP 4XXs
        if (beresp.status >= 400 && beresp.status < 500) {
            set beresp.ttl = 3s;
        }

        // use saint mode for HTTP 5XXs
        if (beresp.status >= 500) {
            set beresp.saintmode = 60s;
            return(restart);
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "elections") {
        set resp.http.X-API-Version = "5-I";
    }
}

sub vcl_error {
    if (obj.status >= 500 && obj.status < 600) {
        set req.http.magicmarker-elections = "fake";
        restart;
    }
}
