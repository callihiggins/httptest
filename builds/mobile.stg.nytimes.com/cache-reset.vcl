sub vcl_recv {
    if (req.http.x-cache-reset == "varnish") {
        if (!client.ip ~ internal) {
            # error, because this is either an external request or from an invalid host
            #std.syslog(180, "Unauthorized cache reset request from " + client.ip + " - " + req.http.host + " for " + req.url);
            error 405 "Not allowed";
        }
        set req.hash_always_miss = true;

        # workaround bug in CREAM:
        if (req.http.host == "www.nytimes.com") {
            set req.http.host = "mobile.nytimes.com";
            # this matters for Varnish's hash key; also, some responses from the node app vary by Host header
        }

        return (lookup);
    }
}