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
    add resp.http.Set-Cookie = 
        "nyt-a=" + req.http.x-nyt-a + "; "+
        "Expires=" + time.add(now, 365d) + "; "+
        "Path=/; "+
        "Domain=.nytimes.com";
}
