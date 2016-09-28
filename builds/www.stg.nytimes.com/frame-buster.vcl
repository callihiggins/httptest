sub vcl_deliver {
    # no referer or not a whitelisted referer?
    # DENY framing
    if (!req.http.Referer) {
        set resp.http.X-Frame-Options = "DENY";
    } elseif (req.http.Referer !~ "^https?://(?:[^?/]+\.)?(?:localhost|(?:nytimes|nytco|nytlabs|stumbleupon|starbucks|insightexpress|optimizely)\.com|(?:newsdev\.net))(?:\:[1-9][0-9]*)?/") {
        set resp.http.X-Frame-Options = "DENY";
    }
}
