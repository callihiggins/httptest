sub vcl_deliver {
    // redirect HP based on edition
    if (   req.http.X-PageType == "homepage"
        && req.http.host == "www.nytimes.com"
        && req.http.x-nyt-edition == "edition|GLOBAL"
    ) {
        set resp.http.Location = "http://international.nytimes.com" + req.http.X-OriginalUri;
        set resp.status = 302;
        set resp.response = "Found";
        return(deliver);
    } else if (   req.http.X-PageType == "homepage"
        && req.http.host == "www.nytimes.com"
        && req.http.x-nyt-edition == "edition|SPANISH"
    ) {
        set resp.http.Location = "http://www.nytimes.com/es" + req.http.X-OriginalUri;
        set resp.status = 302;
        set resp.response = "Found";
        return(deliver);
    }
}
