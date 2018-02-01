sub vcl_deliver {

    # remove extraneous response headers
    unset resp.http.nnCoection;
    unset resp.http.Via;
    unset resp.http.X-Backend;
    unset resp.http.X-DetectedRuntimeConfigFlag;
    unset resp.http.X-ESI-Status;
    unset resp.http.X-Hash;
    unset resp.http.X-Powered-By;
    unset resp.http.X-Varnish;


    // Well is setting Strict-Transport-Security! This leaks out so we need to remove it.
    // NO ONE can set this themselves for our entire domain.
    unset resp.http.strict-transport-security;

    # set some headers
    set resp.http.Connection = "close";

    # make sure these are available for vcl_log as we might remove it
    set req.http.x-nyt-backend-health = resp.http.x-nyt-backend-health;

    # lets return some headers to internal clients for debugging
    if (!req.http.x-nyt-internal-access){
        # remove these headers for external requests
        unset resp.http.X-VarnishCacheDuration;
        unset resp.http.X-Origin-Server;
        unset resp.http.x-nyt-backend-health;
        unset resp.http.x-nyt-backend;
    } else {
        # set these headers for internal requests
        set resp.http.x-nyt-continent = req.http.x-nyt-continent;
        set resp.http.x-nyt-country = req.http.x-nyt-country;
        set resp.http.x-nyt-region = req.http.x-nyt-region;
        set resp.http.x-nyt-geo-hash = req.http.x-nyt-geo-hash;
        set resp.http.x-nyt-timezone = req.http.x-nyt-timezone;
        set resp.http.x-nyt-gmt-offset = req.http.x-nyt-gmt-offset;
        set resp.http.device_type = req.http.device_type;
        set resp.http.x-nyt-backend = req.http.x-nyt-backend;
    }

    if (resp.http.X-API-Version) {
        set resp.http.X-API-Version = "F-" + resp.http.X-API-Version;
    } else {
        set resp.http.X-API-Version = "F-X";
    }

    if (!resp.http.X-PageType){
        set resp.http.X-PageType = req.http.X-PageType;
    }

    // remove deprecated internal https cookie
    if (req.http.x-nyt-internal-access && req.http.Cookie:nyt.np.https-everywhere) {
        add resp.http.Set-Cookie =
            "nyt.np.https-everywhere=; " +
            "Expires=" + time.sub(now, 365d) + "; " +
            "Path=/ ;" +
            "Domain=.nytimes.com";
    }

    // Content Security Policy for HTTPS
    if (req.http.Fastly-SSL) {
        declare local var.csp STRING;
        
        set var.csp = "default-src data: 'unsafe-inline' 'unsafe-eval' https:; script-src data: 'unsafe-inline' 'unsafe-eval' https: blob:; style-src data: 'unsafe-inline' https:; img-src data: https: blob:; font-src data: https:; connect-src https: wss:; media-src https: blob:; object-src https:; child-src https: data: blob:; form-action https:; block-all-mixed-content;";
        set resp.http.Content-Security-Policy = var.csp;
    }
}
