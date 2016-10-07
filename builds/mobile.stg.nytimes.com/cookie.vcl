sub vcl_recv {
    /*
     * capture specific cookie values into custom headers
     */
    if (req.http.Cookie:nyt-a) {
        set req.http.x-nyt-a = req.http.Cookie:nyt-a;
    }
}