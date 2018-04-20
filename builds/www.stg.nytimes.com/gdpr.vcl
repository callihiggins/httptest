sub recv_gdpr {
    if (!req.http.x-nyt-gdpr && req.http.Cookie:nyt-gdpr) {
        set req.http.x-nyt-gdpr = req.http.Cookie:nyt-gdpr;
    }

    # check to see if we got an nyt-gdpr cookie in the request
    if (
        !req.http.x-nyt-gdpr ||
         (req.http.x-nyt-gdpr != "0" && req.http.x-nyt-gdpr != "1")
    ) {
        # set a GDPR value for folks in Europe
        if (req.http.x-nyt-continent == "EU") {
            set req.http.x-nyt-gdpr = "1";
        } else {
            set req.http.x-nyt-gdpr = "0";
        }
    }
}

sub deliver_gdpr {

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
        || req.http.X-PageType == "vi-interactive"
        || req.http.X-PageType == "newsletter"
        || req.http.X-PageType == "paidpost"
        || req.http.X-PageType == "real-estate"
        || req.http.X-PageType == "slideshow"
        || req.http.X-PageType == "trending"
        || req.http.X-PageType == "video-library"
        || req.http.X-PageType == "watching"
        || req.http.X-PageType == "guides"
        || req.http.X-PageType == "mwcm" /* marketing */) {
            add resp.http.Set-Cookie =
                "nyt-gdpr=" + req.http.x-nyt-gdpr + "; "+
                "Expires=" + time.add(now, 7d) + "; "+
                "Path=/; "+
                "Domain=.nytimes.com";
    }

}
