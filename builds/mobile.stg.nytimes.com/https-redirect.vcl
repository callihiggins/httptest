sub vcl_recv {
    /*
     * capture the internal https opt out cookie, if present
     */
    if (req.http.Cookie:nyt.np.internal-https-opt-out) {
        set req.http.x-internal-https-opt-out = urldecode(req.http.Cookie:nyt.np.internal-https-opt-out);
    }

    // IS a HTTPS connection
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

        // WSRE-214: All MW urls are https by default internally
        } else if ( client.ip ~ internal && !req.http.x-internal-https-opt-out ) {

        // if not in the above categories, redirect to http
        } else {
            call redirect_to_http;
        }

    // NOT a HTTPS connection
    } else {
        // MUST be over HTTPS
        if (   req.url ~ "^/store"
            || req.url ~ "^/auth/hdlogin"
            || req.url ~ "^/membercenter/emailus.html"
            || req.url ~ "^/gst/emailus.html"
        ) { 
            call redirect_to_https;

        // WSRE-214: All MW urls are https by default internally
        } else if (client.ip ~ internal && !req.http.x-internal-https-opt-out ) {
            call redirect_to_https;
        }
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

sub redirect_to_http {
    set req.http.x-Redir-Url = "http://" + req.http.host + req.url;
    error 443 req.http.x-Redir-Url;
}

sub redirect_to_https {
    set req.http.x-Redir-Url = "https://" + req.http.host + req.url;
    error 443 req.http.x-Redir-Url;
}
