# This is a small library of functions intended to facilitate EEA detection at the Fasly layer
# and signal to downstream consumers for cookie banner purposes and ad display logic
#

#
# these functions contain logic that is used to
#   1. geo-locate a client's IP
#   2. determine if the client is in a country affected by GDPR
#   3. set a var header, var-cookie-nyt-gdpr, used to hold a value
#       a. 0 if the user is not affected by GDPR
#       b. 1 if the users IS affected by GDPR
#   4. if gdpr=[0|1] is sent as a query parameter it will force the header/cookie for testing
#      this query parameter is ONLY used for testing to override the EEA detection by IP
#      client-side code should always use the cookie or header value
#
#   Your fastly service is expected to `set req.http.var-nyt-send-gdpr = "true"` in order
#   to signify that the GDPR headers and cookies should be sent in the response
#   this is usually only desirable for content render routes, your service should set
#   this header in it's routing decisions appropriately.
#
#
# functions exist in this library for various response needs, please see the below docs
# for information on using these functions in your service properly

# recv_gdpr: this function will set up the state of the user for the rest of the
#            functions in this library. This function MUST be called for the rest of
#            the functions to execute properly. Also, be sure this function is called
#            before any query parameter filtering logic so that the override parameter
#            used for testing can be properly captured.
#
# call this function in your vcl_recv chain in your service
# it performs it's logic based on the current state of the user by using
#    1. the user's IP address
#    2. the current value of the user's nyt-gdpr cookie if it was sent in the request
#    3. `gdpr` query parameter used to force the deliver logic for testing purposes.
#        only use this for overriding the IP, client-side implementation should use the
#        cookie or header.
#
sub recv_gdpr {

    # initialize vars
    declare local var.nyt-has-gdpr BOOL;

    # If the incoming request had an `nyt-t` cookie with a valid value ("ok"|"out")
    # then we capture that value in req.http.var-cookie-nyt-t and mark the request
    # as having that cookie.
    if (!req.http.var-cookie-nyt-t
        && req.http.Cookie:NYT-T
        && (req.http.Cookie:NYT-T == "ok" || req.http.Cookie:NYT-T == "out")
    ) {
        set req.http.var-cookie-nyt-t = req.http.Cookie:NYT-T;
    }

    # If the incoming request had an `nyt-gdpr` cookie with a valid value (0|1)
    # then we capture that value in req.http.var-cookie-nyt-gdpr and mark the request
    # as having that cookie.
    if (!req.http.var-cookie-nyt-gdpr
        && req.http.Cookie:nyt-gdpr
        && (req.http.Cookie:nyt-gdpr == "0" || req.http.Cookie:nyt-gdpr == "1")
    ) {
        set var.nyt-has-gdpr = true;
        set req.http.var-cookie-nyt-gdpr = req.http.Cookie:nyt-gdpr;
    }

    # temporarily setting the cookie in every request
    # for routes that have send-gdpr == "true"
    # TODO: remove at some future point
    # This logic forces the cookie to be set always. Not sure why, but
    # since we are just renaming vars, going with the flow on this one.
    set var.nyt-has-gdpr = false;

    # If the request didn't have an `nyt-gdpr` cookie present, then we do geo detection
    # and match against the country list to determine whether headers should be sent back
    if (!var.nyt-has-gdpr) {
        # set a GDPR value for folks in the country list (note that this list is EEA + Barbados)
        if (client.geo.country_code ~ "AT|BB|BE|BG|HR|CY|CZ|DK|EE|FI|FR|DE|GR|HU|IE|IT|LV|LT|LU|MT|NL|PL|PT|RO|SK|SI|ES|SE|GB|IS|LI|NO|CH") {
            set req.http.var-cookie-nyt-gdpr = "1";
        } else {
            set req.http.var-cookie-nyt-gdpr = "0";
        }
    }

    # Request that have a query param of gdpr=0 or gdpr=1 can be
    # used to simulate EEA detection for testing purposes. This block
    # is what will parse the query param.
    # this was requested by implementors
    declare local var.gdpr_qparam STRING;
    set var.gdpr_qparam = subfield(req.url.qs, "gdpr", "&");
    if (var.gdpr_qparam == "0" || var.gdpr_qparam == "1") {
        set req.http.var-cookie-nyt-gdpr = var.gdpr_qparam;
    }
}

# deliver_gdpr: typically used for responses for web content routes
#
# it sets the following parameters in the HTTP response
#    1. nyt-gdpr cookie set to values 0 or 1. Expiry in 6 hours. Right now only .nytimes.com domain.
#    2. x-gdpr response header set to values 0 or 1.
#
# this function should be called in your vcl_deliver chain in your service
# it depends on recv_gdpr execution in vcl_recv to set up state variables
#
sub deliver_gdpr {

    # this will either set a new cookie
    # or extend the existing one to 6 hours
    if (req.http.var-cookie-nyt-gdpr || req.http.var-nyt-send-gdpr == "true") {
        add resp.http.Set-Cookie =
            "nyt-gdpr=" + req.http.var-cookie-nyt-gdpr + "; "+
            "Expires=" + time.add(now, 6h) + "; "+
            "Path=/; "+
            "Domain=.nytimes.com";

        # set the appropriate response header
        set resp.http.x-gdpr = req.http.var-cookie-nyt-gdpr;
    }
}

# recv_route_svc_gdpr: typically used in native mobile applications
#
# This route function can be called in a service's vcl_recv to enliven
# a route that can be used as a standalone EEA detection service.
# Typically used by native mobile applications, but any implementation
# can use this if it is desired.
#
# if you do not need this route in your service, feel free to not call it.
# clients will typically use www.nytimes.com for this.
#
# This route relies on recv_gdpr to intialize state
#
# CORS is implemented in the following manner
#
#   1. nytimes.com/nyt.net/nyt.com/thewirecutter.com/wirecutter.com/hellosociety.com Origin allows `*`
#   2. lack of origin header (Safari bug) allowa `*`
#   3. GET and OPTIONS methods are allowed
#
# the format of the json response is very simple and is as follows:
#
#   {"GDPR":0} # user is not in a GDPR affected country
#   {"GDPR":1} # user is in a GDPR affected country
#
sub recv_route_svc_gdpr {
    if (req.url ~ "/svc/gdpr\.json") {
        set req.http.x-nyt-route = "gdpr_svc";
        error 919 "GDPR service URL";
    }
}

# error_919_gdpr: helper function for recv_route_svc_gdpr to send a json response
#                 fastly can only send synthetic responses using vcl_error
#
# if you need the GDPR json service enlivened in your fastly service, add this
# function call to your `vcl_error` as well as `recv_route_svc_gdpr` to your `vcL_recv`
#
sub error_919_gdpr {
    # JSON GDPR response
    if (obj.status == 919) {
        set obj.status = 200;
        set obj.http.Content-Type = "application/json; charset=utf-8";
        set obj.http.x-gdpr = req.http.var-cookie-nyt-gdpr;

        # Only allow NYT controlled domains, and their roots, with optional
        # schema, port, etc. to have access control.
        #
        # Additonally, in order to support iOS requests (and others that don't
        # provide an Origin, such as hitting the endpoint directly or calling
        # hitting it from the command line), allow requests that have no Origin
        # set.
        if (req.http.Origin ~ "^(https?://)?(.+\.)?(((nyt|nytimes|thewirecutter|wirecutter|hellosociety|nytimes\.stats|shi-magazine)\.com)|nyt\.net|brandstand\.co)(:\d+)?$"
            || !req.http.Origin
            || req.http.Origin == "null") {
            set obj.http.Access-Control-Allow-Origin = "*";
            set obj.http.Access-Control-Allow-Methods = "GET, OPTIONS";
            set obj.http.Access-Control-Expose-Headers = "Content-Type";
        }
        synthetic
            {"{"GDPR":"} + req.http.var-cookie-nyt-gdpr + {"}"};
        return(deliver);
    }
}

# recv_route_svc_amp_gdpr: typically used by AMP articles
#
# This route function can be called in a service's vcl_recv to enliven
# a route that can be used as a standalone EEA detection service.
# Typically used by AMP articles, but any implementation
# can use this if it is desired.
#
# if you do not need this route in your service, feel free to not call it.
# clients will typically use www.nytimes.com for this.
#
# This route relies on recv_gdpr to intialize state
#
# CORS is implemented in the following manner
#
#   1. nytimes.com/nyt.net/nyt.com/google.com Origin allows `*`
#   2. lack of origin header (Safari bug) allowa `*`
#   3. GET, OPTIONS and POST methods are allowed
#
# ref: https://ampbyexample.com/user_consent/basic_user_consent_flow/#basic-usage
# the format of the json response is very simple and is as follows:
#
#   {"promptIfUnknown":false} # user is not in a GDPR affected country
#   {"promptIfUnknown":true} # user is in a GDPR affected country and
#   user doesn't have an NYT-T cookie or value is set to "out"
#
sub recv_route_svc_amp_gdpr {
    if (req.url ~ "/svc/amp-consent\.json") {
        set req.http.x-nyt-route = "amp_consent_gdpr_svc";
        error 918 "GDPR service URL";
    }
}

# error_918_amp_gdpr: helper function for recv_route_svc_gdpr to send a json response
#                 fastly can only send synthetic responses using vcl_error
#
# if you need the GDPR json service enlivened in your fastly service, add this
# function call to your `vcl_error` as well as `recv_route_svc_gdpr` to your `vcL_recv`
#
sub error_918_amp_gdpr {
    # JSON GDPR response
    if (obj.status == 918) {
        declare local var.amp-gdpr STRING;
        set obj.status = 200;
        set obj.http.Content-Type = "application/json; charset=utf-8";
        if (req.http.origin ~ "\.(nytimes\.com|nyt\.net|nyt\.com|google\.com)$") {
            ## only allow nyt.net and nytimes.com domain for hace access control
            set obj.http.Access-Control-Allow-Origin = "*";
            set obj.http.Access-Control-Expose-Headers = "Content-Type";
            set obj.http.Access-Control-Allow-Methods = "GET, OPTIONS, POST";
        } else if (!req.http.Origin || req.http.Origin == "null" ) {
            ## this is to support IOS requests. They don't send Header Origin
            set obj.http.Access-Control-Allow-Origin = "*";
            set obj.http.Access-Control-Expose-Headers = "Content-Type";
            set obj.http.Access-Control-Allow-Methods = "GET, OPTIONS, POST";
        }

        if (req.http.var-cookie-nyt-gdpr == "1") {
            if (!req.http.var-cookie-nyt-t || req.http.var-cookie-nyt-t == "out") {
                set var.amp-gdpr = "true";
            } else {
                set var.amp-gdpr = "false";
            }
        } else {
            set var.amp-gdpr = "false";
        }
        set obj.http.x-nyt-amp-consent = var.amp-gdpr;

        synthetic
            {"{"promptIfUnknown":"} + var.amp-gdpr + {"}"};
        return(deliver);
    }
}
