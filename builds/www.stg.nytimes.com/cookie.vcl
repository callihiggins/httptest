sub recv_remove_cookie_check {

    /*
     * If we have restarted the transaction, req.http.Cookie will be empty
     * and we will lose the NYT-S cookie value.
     * Copy cookie header to custom header then unset cookie header
     * to facilitate caching.
     * Do not do this for (NYT4) www backend (this means pass right now)
     * and only do this remap if this is not a restarted request.
     */
    if (   req.backend != F_www_userinfo
        && req.http.x-nyt-force-pass != "true"
        && req.restarts == 0
        && ( req.request == "HEAD"
          || req.request == "GET"
        ) ) {
        set req.http.X-Cookie = req.http.Cookie;
        unset req.http.Cookie;
    }
}
