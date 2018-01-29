sub vcl_recv {
    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        // Doing this only in staging and internal for now
        // https://jira.nyt.net/browse/DV-273
        if (req.url ~ "^/tbooks") {
            set req.http.X-PageType = "tbooks";
            set req.http.x-nyt-backend = "tbooks";

            // If it's a request to the tbooks homepage we need to leave the / at the end so that
            // the path "exists". Otherwise, we should remove the whole /tbooks from the path.
            // Removing the whole path is causing errors on the wordpress side where they state 
            // they could not read the request
            if (req.url.path == "/tbooks") {
                set req.url = regsub(req.url, "^/tbooks", "/");
            } else {
                set req.url = regsub(req.url, "^/tbooks", "");
            }
            set req.backend = F_tbooks;
            set req.http.host = "nytinsider.wordpress.com";

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

sub vcl_deliver {
    if (req.http.X-PageType == "tbooks") {
        set resp.http.X-API-Version = "TB";
    }
}
