sub vcl_deliver {

    # remove extraneous response headers
    remove resp.http.nnCoection;
    remove resp.http.Via;
    remove resp.http.X-Backend;
    remove resp.http.X-DetectedRuntimeConfigFlag;
    remove resp.http.X-ESI-Status;
    remove resp.http.X-Hash;
    remove resp.http.X-Powered-By;
    remove resp.http.X-Varnish;


    // Well is setting Strict-Transport-Security! This leaks out so we need to remove it.
    // NO ONE can set this themselves for our entire domain.
    unset resp.http.strict-transport-security;

    # set some headers
    set resp.http.Connection = "close";

    # lets return some headers to internal clients for debugging
    if (client.ip !~ internal){
        # remove these headers for external requests
        remove resp.http.X-VarnishCacheDuration;
        remove resp.http.X-Origin-Server;
    } else {
        # set these headers for internal requests
        set resp.http.X-NYT-Backend = req.http.X-NYT-Backend;
        set resp.http.x-nyt-continent = req.http.x-nyt-continent;
        set resp.http.x-nyt-country = req.http.x-nyt-country;
        set resp.http.x-nyt-region = req.http.x-nyt-region;
        set resp.http.x-nyt-geo-hash = req.http.x-nyt-geo-hash;
    }

    if (resp.http.X-API-Version) {
        set resp.http.X-API-Version = "F-" + resp.http.X-API-Version;
    } else {
        set resp.http.X-API-Version = "F-X";
    }

    if (!resp.http.X-PageType){
        set resp.http.X-PageType = req.http.X-PageType;
    }

    if (req.http.X-Health) {
        set resp.http.X-Health = req.http.X-Health;
    }

    // if we found two NYT-S cookies, try to expire the possible non-canonical versions
    // only dev/stg for now
    if (req.http.x-environment != "prd"){
        if (req.http.x-nyt-s2){

            // delete a docroot cookie under www.nytimes.com
            add resp.http.Set-Cookie =
                "NYT-S=; "+
                "Expires=" + time.sub(now, 365d) + "; "+
                "Path=/; "+
                "Domain=www.nytimes.com";

            // delete dir path cookies if we are not rendering the homepage
            if (req.http.X-PageType != "homepage") {
                add resp.http.Set-Cookie =
                    "NYT-S=" + req.http.x-nyt-a + "; "+
                    "Expires=" + time.sub(now, 365d) + "; "+
                    "Path=" + req.url.dirname + "; " +
                    "Domain=www.nytimes.com";

                add resp.http.Set-Cookie =
                    "NYT-S=" + req.http.x-nyt-a + "; "+
                    "Expires=" + time.sub(now, 365d) + "; "+
                    "Path=" + req.url.dirname + "; " +
                    "Domain=.nytimes.com";
            }
        }
    }

    // remove deprecated internal https cookie
    if (client.ip ~ internal && req.http.Cookie:nyt.np.https-everywhere) {
        add resp.http.Set-Cookie =
            "nyt.np.https-everywhere=; " +
            "Expires=" + time.sub(now, 365d) + "; " +
            "Path=/ ;" +
            "Domain=.nytimes.com";
    }

    // Content Security Policy for HTTPS
    if (req.http.Fastly-SSL) {
        declare local var.csp STRING;
        declare local var.report-uri STRING;

        set var.csp = "default-src data: 'unsafe-inline' 'unsafe-eval' https:; script-src data: 'unsafe-inline' 'unsafe-eval' https: blob:; style-src data: 'unsafe-inline' https:; img-src data: https: blob:; font-src data: https:; connect-src https: wss:; media-src https: blob:; object-src https:; child-src https: data: blob:; form-action https:; block-all-mixed-content;";
        set var.report-uri = "report-uri https://nytimes.report-uri.io/r/default/csp/enforce;";

        if (req.http.x-environment == "prd") {
            // all internal traffic, and 1% of external traffic should report CSP violations
            if (client.ip ~ internal || randombool(1, 100)) {
                set resp.http.Content-Security-Policy = var.csp + " " + var.report-uri;
            } else {
                set resp.http.Content-Security-Policy = var.csp;
            }
        } else {
            set resp.http.Content-Security-Policy = var.csp;
        }
    }
}
