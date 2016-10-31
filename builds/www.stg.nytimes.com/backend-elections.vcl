sub vcl_recv {
    if (req.url ~ "^/elections?(?:/|\?|$)") {
        set req.http.X-PageType = "elections";
        call set_newsdev_elections_backend;
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

        if (beresp.status >= 500) {
            /* deliver stale if the object is available */
            if (stale.exists) {
                return(deliver_stale);
            }
            return(restart);
        }
        
        # set beresp.grace = 86400s; # equivalent to next line
        set beresp.stale_if_error = 86400s;
        set beresp.stale_while_revalidate = 60s;
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "elections") {
        set resp.http.X-API-Version = "F-I";
    }
}

sub vcl_error {
    if (req.http.X-PageType == "elections" && obj.status >= 500 && obj.status < 600) {
        set req.http.magicmarker-elections = "fake";
        restart;
    }
}

sub set_newsdev_elections_backend {
    if (req.http.host ~ "\.dev\.") {
        set req.backend = newsdev_elections_dev;
    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = newsdev_elections_stg;
    } else {
        set req.backend = newsdev_elections_prd;
    }
}