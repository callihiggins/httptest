sub vcl_recv {
    /*
     * capture test cookie value, if present
     */
    if (req.http.Cookie:nyt.np.https-everywhere) {
        set req.http.x-nyt-np-https-everywhere = urldecode(req.http.Cookie:nyt.np.https-everywhere);
    }

    // detect that Fastly terminated a TLS connection
    if (req.http.Fastly-SSL) {
        // whitelist of URIs that must be supported via both HTTP and HTTPS
        if (   req.url ~ "^/svc/"
            || req.url ~ "^/content/help/itunes/privacy-policy.html"
            || req.url ~ "^/content/help/rights/privacy/policy/privacy-policy.html"
            || req.url ~ "^/apple-app-site-association"
            || req.url ~ "^/google34e0037c9fda7c66.html"
            || req.url ~ "^/adx/"
            || req.url ~ "^/store"
            || req.url ~ "^/auth/hdlogin"
            || req.url ~ "^/membercenter/emailus.html"
            || req.url ~ "^/gst/emailus.html"
            || req.url ~ "^/subscriptions"
            || req.url ~ "^/services/xml/rss"
            || req.url ~ "^/regilite"
        ) {
            // removed this logic for now just let it fall through...

        } else if ( req.http.x-nyt-np-https-everywhere == "1" && client.ip ~ internal) {
            // WP-17776: temporary cookie for HTTPS Everywhere testing
            set req.http.x-is-https = "-HTTPS";
        } else {
            set req.http.x-Redir-Url = "http://" + req.http.host + req.url;
            error 443 req.http.x-Redir-Url;
        }
    } else {
        // WP-18256: HTTPS Everywhere redirect to HTTPS when cookie enable + internal IP
        if ( req.http.x-nyt-np-https-everywhere == "1" && client.ip ~ internal) {
            set req.http.x-Redir-Url = "https://" + req.http.host + req.url;
            error 443 req.http.x-Redir-Url;
        }
    }

    if (!req.http.Fastly-SSL) {
        if (   
            req.url ~ "^/store"
            || req.url ~ "^/auth/hdlogin"
            || req.url ~ "^/membercenter/emailus.html"
            || req.url ~ "^/gst/emailus.html"
        ) { 
            set req.http.x-Redir-Url = "https://" + req.http.host + req.url;
            error 443 req.http.x-Redir-Url;
        }
    }
}

sub vcl_hash {
    if (req.http.x-is-https) {
        set req.hash += req.http.x-is-https;
    }
}

sub vcl_deliver {
    if (req.request == "FASTLYPURGE" && req.http.Fastly-SSL != "https") {
        set req.http.Fastly-SSL = "https";
        set req.http.x-nyt-np-https-everywhere = "1";
        restart;
    }
}

sub vcl_error {
    if (obj.status == 443) {
        set obj.http.Location = obj.response;
        set obj.status = 301;
        set obj.response = "Moved Permanently";
        set obj.http.X-API-Version = "0";
        return(deliver);
    }
}
