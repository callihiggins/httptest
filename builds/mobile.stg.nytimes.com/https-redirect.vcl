
sub vcl_recv {

    /*
     * capture test cookie value, if present
     */
    if (req.http.Cookie ~ "nyt.np.https-everywhere=") {
        set req.http.x-nyt-np-https-everywhere = urldecode(regsub(req.http.Cookie, "(.*)nyt.np.https-everywhere=([^;]*)(.*)", "\2"));
    }
    if (! req.http.x-nyt-np-https-everywhere) {
        set req.http.x-nyt-np-https-everywhere = "";
    }

    // detect that netscaler downstepped HTTPS to HTTP
    if (req.http.X-Forwarded-Proto == "https") {
        // whitelist of URIs that must be supported via both HTTP and HTTPS
        if (   req.url ~ "^/svc/"
            || req.url ~ "^/content/help/itunes/privacy-policy.html"
            || req.url ~ "^/content/help/rights/privacy/policy/privacy-policy.html"
            || req.url ~ "^/apple-app-site-association"
            || req.url ~ "^/.well-known/apple-developer-merchantid-domain-association"
            || req.url ~ "^/google34e0037c9fda7c66.html"
            || req.url ~ "^/mw-static/"
        ) {
            // remove X-Forwarded-Proto from whitelisted URIs
            unset req.http.X-Forwarded-Proto;
        } elsif ( req.http.x-nyt-np-https-everywhere == "1" && client.ip ~ internal) {
            // WP-17776: temporary cookie for HTTPS Everywhere testing
            // remove X-Forwarded-Proto from whitelisted URIs
            unset req.http.X-Forwarded-Proto;
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
}

sub vcl_hash {
    if (req.http.x-is-https) {
        set req.hash += req.http.x-is-https;
    }
}

sub vcl_deliver {
    // restart CREAM API request to also reset HTTPS cache key
    if (req.http.x-cache-reset == "varnish") {
        set req.http.X-Forwarded-Proto = "https";
        set req.http.x-nyt-np-https-everywhere = "1";
        return(restart);
    }
}

sub vcl_error {
    if (obj.status == 442) {
        if (client.ip ~ internal) {
            synthetic "<script>window.NYTD.https = {'url':'https://internal-tools02.dev.ewr1.nytimes.com/https/','icon':'https://internal-tools02.dev.ewr1.nytimes.com/https/images/t-lock.svg'};</script>";
        } else {
            synthetic "";
        }
        return (deliver);
    }

    if (obj.status == 443) {
        set obj.http.Location = obj.response;
        set obj.status = 301;
        set obj.response = "Moved Permanently";
        set obj.http.X-API-Version = "0";
        return(deliver);
    }
}
