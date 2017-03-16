sub vcl_recv {
    # check to see if we got an nyt-a cookie in the request
    if (req.http.Cookie:nyt-a) {
        set req.http.x--fastly-nyt-a = req.http.Cookie:nyt-a;

    } else {
        # we didn't get a uuid, generate and set one
        set req.http.x--fastly-nyt-a = digest.hmac_sha256_base64(
            # key doesn't really matter for our purposes, but here's 256 bits entropy anyway:
            "XAbi6M4HfROODd+Phq1jR15r/9+OyiUTTmTrbzqe73k",
            now.sec
            randomstr(64)
            req.http.host
            req.http.user-agent
            req.http.cookie
            req.url
            client.ip
            req.http.Fastly-Client-IP
            time.start.usec
            time.elapsed.usec
            client.port
            server.identity
        );

        // we only need 22 base64 chars to reach 128 bits entropy (22 * 6 = 132):
        set req.http.x--fastly-nyt-a = regsub(req.http.x--fastly-nyt-a, "^(.{22}).*$", "\1");
        // '+' and '/' are technically cookie-safe, but just in case somebody has misbehaving code:
        set req.http.x--fastly-nyt-a = regsuball(req.http.x--fastly-nyt-a, "\+", "-");
        set req.http.x--fastly-nyt-a = regsuball(req.http.x--fastly-nyt-a, "\/", "_");
    }
}

sub vcl_deliver {
    # this will either set a new cookie
    # or extend the existing one to a year
    if (resp.http.Content-Type ~ "^text/html\b") {
        add resp.http.Set-Cookie =
            "nyt-a=" + req.http.x--fastly-nyt-a + "; "+
            "expires=" + time.add(now, 365d) + "; "+
            "path=/; "+
            "domain=.nytimes.com";
    }
}

# the backend doesn't need the private vars we've stashed on the request,
# so zap them from the backend request using vcl_miss and vcl_pass:
sub vcl_miss {
    unset bereq.http.x--fastly-nyt-a;
}
sub vcl_pass {
    unset bereq.http.x--fastly-nyt-a;
}
