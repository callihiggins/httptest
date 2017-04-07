sub vcl_recv {

    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        // Doing this only in staging and internal for now
        // https://jira.nyt.net/browse/DV-273
        if (req.http.x-environment == "stg" && client.ip ~ internal) {
            if (req.url ~ "^/tbooks") {
                set req.http.X-PageType = "tbooks";

                set req.url = regsub(req.url, "^/tbooks", "/");
                set req.backend = tbooks_prd;
                set req.http.host = "nytinsider.wordpress.com";

                set req.grace = 24h;
                set req.http.x-skip-glogin = "1";
                unset req.http.x-nyt-edition;
                unset req.http.x-nyt-s;
                unset req.http.x-nyt-wpab;

                // We want to pass the NYT-S cookie only to the tbooks backend
                // becasue of the 8k headers size limit
                set req.http.Cookie = "NYT-S=" req.http.Cookie:NYT-S ";";

                unset req.http.X-Cookie;

                return(pass);
            }
        }
    }
}

sub vcl_fetch {
    if (req.http.X-PageType == "tbooks") {
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
    if (req.http.X-PageType == "tbooks") {
        set resp.http.X-API-Version = "TB";
    }
}
