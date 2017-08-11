sub vcl_recv {

    if (req.http.host ~ "^(www|paidpost)([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        // The order of these two checks is important since the second one is a sub path of the first one
        if (req.url ~ "^/video-media") {
            set req.http.X-PageType = "video-media";

            set req.url = regsub(req.url, "^/video-media", "/video");
            set req.grace = 24h;
            call set_video_backend;

            unset req.http.x-nyt-edition;
            unset req.http.x-nyt-s;
            unset req.http.x-nyt-wpab;
            unset req.http.Cookie;
            unset req.http.X-Cookie;

            return(lookup);
        }
    }
}

sub vcl_fetch {
    if (req.http.X-PageType == "video-media") {
        // use very short cache TTL for HTTP 4XXs
        if (beresp.status >= 400 && beresp.status < 500) {
            set beresp.ttl = 3s;
        }

        // use saint mode for HTTP 5XXs
        if (beresp.status >= 500) {
            /* deliver stale if the object is available */
            if (stale.exists) {
                return(deliver_stale);
            }
            return(restart);
        }

        set beresp.stale_if_error = 86400s;
        set beresp.stale_while_revalidate = 60s;
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "video-media") {
        set resp.http.X-API-Version = "VM";
    }
}

sub set_video_backend {
    if (req.http.x-environment == "stg") {
        set req.backend = vp_stg;
        set req.http.host = "video.stg.nyt.com";
    } else {
        set req.backend = vp_prd;
        set req.http.host = "video.nyt.com";
    }
}
