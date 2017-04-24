sub vcl_deliver {
    # check to see if we got an nyt-a cookie in the request
    if (!req.http.x-nyt-a) {
        # we didn't get a uuid, generate and set one
        set req.http.x-nyt-a = digest.hash_sha256(
            now.sec+
            randomstr(64)+
            req.http.host+
            req.url+
            client.ip+
            client.port+
            server.identity);
    }

    # set the header
    # this will either set a new cookie
    # or extend the existing one to a year
    # we will only do this for content pages

    if (req.http.X-PageType == "article"
        || req.http.X-PageType == "vi-story"
        || req.http.X-PageType == "bestseller"
        || req.http.X-PageType == "collection"
        || req.http.X-PageType == "elections"
        || req.http.X-PageType == "homepage"
        || req.http.X-PageType == "interactive"
        || req.http.X-PageType == "newsletter"
        || req.http.X-PageType == "paidpost"
        || req.http.X-PageType == "real-estate"
        || req.http.X-PageType == "slideshow"
        || req.http.X-PageType == "trending"
        || req.http.X-PageType == "video-library"
        || req.http.X-PageType == "watching"
        || req.http.X-PageType == "well") {
            add resp.http.Set-Cookie =
                "nyt-a=" + req.http.x-nyt-a + "; "+
                "Expires=" + time.add(now, 365d) + "; "+
                "Path=/; "+
                "Domain=.nytimes.com";
    }

}
