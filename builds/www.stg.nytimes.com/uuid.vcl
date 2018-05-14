sub vcl_deliver {

    # set the header
    # this will either set a new cookie
    # or extend the existing one to a year
    # we will only do this for content pages
    # do not send this cookie if we are on a shield pop
    if (!req.http.x-nyt-shield-auth) {
        if (req.http.x-nyt-route == "article"
            || req.http.x-nyt-route == "vi-story"
            || req.http.x-nyt-route == "bestseller"
            || req.http.x-nyt-route == "collection"
            || req.http.x-nyt-route == "elections"
            || req.http.x-nyt-route == "homepage"
            || req.http.x-nyt-route == "vi-homepage"
            || req.http.x-nyt-route == "vi-interactive"
            || req.http.x-nyt-route == "vi-slideshow"
            || req.http.x-nyt-route == "newsletter"
            || req.http.x-nyt-route == "paidpost"
            || req.http.x-nyt-route == "real-estate"
            || req.http.x-nyt-route == "slideshow"
            || req.http.x-nyt-route == "trending"
            || req.http.x-nyt-route == "video-library"
            || req.http.x-nyt-route == "watching"
            || req.http.x-nyt-route == "guides"
            || req.http.x-nyt-route == "mwcm" /* marketing */) {
                add resp.http.Set-Cookie =
                    "nyt-a=" + req.http.x-nyt-a + "; "+
                    "Expires=" + time.add(now, 365d) + "; "+
                    "Path=/; "+
                    "Domain=.nytimes.com";
        }
    }
}
