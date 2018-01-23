sub vcl_recv {

    if (   req.url ~ "^/well/"
        || req.url ~ "^/guides/"
        || req.url.path == "/guides"
    ) {
        set req.http.X-PageType = "well";
        set req.http.x-nyt-backend = "beta_guides";
        set req.backend = F_beta_guides;
        set req.grace = 24h;
    }

}

sub vcl_fetch {
    if (req.http.X-PageType == "well") {
        // use very short cache TTL for HTTP 4XXs
        if (beresp.status >= 400 && beresp.status < 500) {
            set beresp.ttl = 3s;
        }

        if (beresp.status >= 500) {
            /* deliver stale if the object is available */
            if (stale.exists) {
                return(deliver_stale);
            }

            # if the object was not in cache and we have not restarted, try one more time
            if (req.restarts < 1 && (req.request == "GET" || req.request == "HEAD")) {
                restart;
            }

            set req.http.Fastly-Cachetype = "ERROR";
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "well") {
        set resp.http.X-API-Version = "W";
    }
}
