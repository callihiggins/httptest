sub vcl_deliver {
    // no referer, deny framing
    if (!req.http.Referer) {
        set resp.http.X-Frame-Options = "DENY";
    } elseif (req.http.Referer !~ "^https?://(?:[^?/]+\.)?(?:localhost|(?:nytimes|nytco|nytlabs|stumbleupon|starbucks|insightexpress|optimizely)\.com|(?:newsdev\.net))(?:\:[1-9][0-9]*)?/") {
        // referer does not match the whilelisted domains
        set resp.http.X-Frame-Options = "DENY";
    }

    // otherwise, do nothing to allow framing
}