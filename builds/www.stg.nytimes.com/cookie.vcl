sub vcl_recv {
    /*
     * capture specific cookie values into custom headers
     */
    if (req.http.Cookie:NYT-S) {
        set req.http.x-nyt-s = urldecode(req.http.Cookie:NYT-S);
    }

    if (req.http.Cookie:NYT-Edition) {
        set req.http.x-nyt-s = urldecode(req.http.Cookie:NYT-Edition);
    }

    if (req.http.Cookie:nyt-d) {
        set req.http.x-nyt-s = urldecode(req.http.Cookie:nyt-d);
    }

    if (req.http.Cookie:NYT-wpAB) {
        set req.http.x-nyt-s = urldecode(req.http.Cookie:NYT-wpAB);
    }

    # This is not necessary but it's not hurting anything. -- stephen
    /*
     * If we have restarted the transaction, req.http.Cookie will be empty
     * and we will lose the NYT-S cookie value.
     * Copy cookie header to custom header then unset cookie header
     * to facilitate caching.
     * Do not do this for (NYT4) www backend
     * and only do this remap if this is not a restarted request.
     */
    if (req.backend != www && req.restarts == 0) {
        set req.http.X-Cookie = req.http.Cookie;
        unset req.http.Cookie;
    }
}
