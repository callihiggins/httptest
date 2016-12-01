sub vcl_recv {
    /*
     * capture https enable cookie value, if present
     */
    if (req.http.Cookie:nyt.np.enable-https) {
        set req.http.x-nyt-np-enable-https = urldecode(req.http.Cookie:nyt.np.enable-https);
    }

    /*
     * capture the internal https opt out cookie, if present
     */
    if (req.http.Cookie:nyt.np.internal-https-opt-out) {
        set req.http.x-internal-https-opt-out = urldecode(req.http.Cookie:nyt.np.internal-https-opt-out);
    }

    /*
     * Phase 1 candidates
     */
    if (   req.http.X-PageType == "homepage"
        || ( req.http.X-PageType == "article" && req.url ~ "^/2(01[4-9]|(0[2-9][0-9])|([1-9][0-9][0-9]))" ) // 2014 - future
        || req.http.X-PageType == "collection"
        || req.http.X-PageType == "video-library"
    ) {
        set req.http.x-https-phase = "1";
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
            || req.url ~ "^/newsletters/regilite"
            || req.url ~ "^/wrapper.html"
            || req.url == "/interactive/2016/world/news-tips.html"
            || req.url ~ "^/tips(/)?$"
            || req.url == "/securedrop"
        ) {

        /*
        // video section is public over https
        } else if ( req.http.X-PageType == "video-library" ) {
        */

        // WSRE-214: Phase 1 urls are https by default internally
        } else if ( 
               client.ip ~ internal
            && req.http.x-https-phase == "1"
            && !req.http.x-internal-https-opt-out
        ) {

        // internal https cookie-based test
        } else if ( req.http.x-nyt-np-enable-https == "1" && client.ip ~ internal) {

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
            || req.url == "/interactive/2016/world/news-tips.html"
            || req.url ~ "^/tips(/)?$"
            || req.url == "/securedrop"
        ) { 
            call redirect_to_https;

        // WSRE-214: Phase 1 urls are https by default internally
        } else if (
            client.ip ~ internal
            && req.http.x-https-phase == "1"
            && !req.http.x-internal-https-opt-out
        ) {
            call redirect_to_https;

        // internal https cookie-based test
        } else if ( req.http.x-nyt-np-enable-https == "1" && client.ip ~ internal) {
            call redirect_to_https;

        /*
        // video section is public over https
        } else if ( req.http.X-PageType == "video-library" ) {
            call redirect_to_https;
        */

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
