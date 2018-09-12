sub deliver_response_headers {

    # remove extraneous response headers
    unset resp.http.nnCoection;
    unset resp.http.Via;
    unset resp.http.X-Backend;
    unset resp.http.X-DetectedRuntimeConfigFlag;
    unset resp.http.X-ESI-Status;
    unset resp.http.X-Hash;
    unset resp.http.X-Powered-By;
    unset resp.http.X-Varnish;


    # Only Fastly services can control this header, do not let it be set right now
    unset resp.http.strict-transport-security;

    # not sure we need this, don't set this if we're a shield pop
    if(!req.http.x-nyt-shield-auth){
        set resp.http.Connection = "close";
    }

    # make sure these are available for vcl_log as we might remove it
    set req.http.x-nyt-backend-health = resp.http.x-nyt-backend-health;

    # decide whether to keep or delete response headers based on auth level
    if (!req.http.x-nyt-nyhq-access){
        # remove these headers for external requests
        unset resp.http.X-VarnishCacheDuration;
        unset resp.http.X-Origin-Server;
        unset resp.http.x-nyt-backend-health;
    } else {
        # set these headers for internal requests
        set resp.http.x-nyt-continent = req.http.x-nyt-continent;
        set resp.http.x-nyt-country = req.http.x-nyt-country;
        set resp.http.x-nyt-region = req.http.x-nyt-region;
        set resp.http.x-nyt-latitude = req.http.x-nyt-latitude;
        set resp.http.x-nyt-longitude = req.http.x-nyt-longitude;
        set resp.http.x-nyt-city = req.http.x-nyt-city;
        set resp.http.x-nyt-gmt-offset = req.http.x-nyt-gmt-offset;
        set resp.http.x-nyt-postal-code = req.http.x-nyt-postal-code;
        set resp.http.device_type = req.http.device_type;
        set resp.http.x-nyt-final-url = req.url;
        if (req.http.x-nyt-geo-hash) {
            set resp.http.x-nyt-geo-hash = req.http.x-nyt-geo-hash;
        }
    }

    if (resp.http.X-API-Version) {
        set resp.http.X-API-Version = "F-" + resp.http.X-API-Version;
    } else {
        set resp.http.X-API-Version = "F-X";
    }

    # do not send the restart reason header back out if we are a shield pop
    if(req.http.x-nyt-shield-auth){
        unset resp.http.x-nyt-restart-reason;
    }

    # always set these response headers if this is a shield pop
    # we will let these flow through to the edge pop as-is
    # we want to report in the edge response the ACTUAL origin route/backend that served the request
    # this is in the case the sheild restarted and went to a different backend
    if (req.http.x-nyt-shield-auth) {
        set resp.http.x-nyt-route = req.http.x-nyt-route;
        set resp.http.x-nyt-backend = req.http.x-nyt-backend;
    # unset the x-nyt-backend header if this is an edge pop without nyhq access
    } else if(!req.http.x-nyt-nyhq-access) {
        unset resp.http.x-nyt-backend;
    # if we got this far it's an edge that is nyhq
    # if NOT shielded, overwrite this header with the route defined one
    # do not let origins override it, this is FASTLY ROUTING ONLY HEADER
    } else if(!req.http.var-nyt-is-shielded) {
        set resp.http.x-nyt-backend = req.http.x-nyt-backend;
    }

    # if the x-nyt-route header is still not set in the response, set it based on req in this node
    if (!resp.http.x-nyt-route) {
        set resp.http.x-nyt-route = req.http.x-nyt-route;
    }

    // remove deprecated internal https cookie
    if (req.http.x-nyt-nyhq-access && req.http.Cookie:nyt.np.https-everywhere) {
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
        set var.report-uri = "report-uri https://wwwnytimes.report-uri.com/r/d/csp/enforce;";

        # dev and stg only for now
        if (req.http.var-nyt-env == "dev" || req.http.var-nyt-env == "stg") {
            // all internal traffic, and 1% of external traffic should report CSP violations
            if (req.http.var-nyt-allow-access-nyhq || randombool(1, 100)) {
                set resp.http.Content-Security-Policy = var.csp + " " + var.report-uri;
            } else {
                set resp.http.Content-Security-Policy = var.csp;
            }
        } else {
            set resp.http.Content-Security-Policy = var.csp;
        }
    }
}

// Post Audit function
// Return debug headers for internal clients
sub deliver_debug_response_headers {
  if (req.http.x-nyt-nyhq-access) {
    set resp.http.debug-var-nyt-env = req.http.var-nyt-env;
    set resp.http.debug-var-nyt-force-pass = if(req.http.var-nyt-force-pass, req.http.var-nyt-force-pass, "false");
  }
}
