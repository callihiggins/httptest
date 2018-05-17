sub vcl_deliver {
    // redirect HP based on edition
    if (   (req.http.x-nyt-route == "homepage" || req.http.x-nyt-route == "vi-homepage")
        && req.http.var-nyt-canonical-www-host == "true"
        && req.http.x-nyt-edition == "edition|SPANISH"
    ) {
        set resp.http.Location =  "http://" + req.http.host + "/es" + req.http.X-OriginalUri;
        set resp.status = 302;
        set resp.response = "Found";
        return(deliver);
    }
}
