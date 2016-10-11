sub vcl_deliver {
    // redirect HP based on edition
    if (   req.http.X-PageType == "homepage"
        && req.http.host ~ "^www\.(dev\.|stg\.)?nytimes.com$"
        && req.http.x-nyt-edition == "edition|SPANISH"
    ) {
        set resp.http.Location =  "http://" + req.http.host + "/es" + req.http.X-OriginalUri;
        set resp.status = 302;
        set resp.response = "Found";
        return(deliver);
    }
}
