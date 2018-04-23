# This is a small library of functions intended to facilitate EEA detection at the Fasly layer
# and signal to downstream consumers for cookie banner purposes and ad display logic
#
# The req.http.X-SendGDPR flag is what drives this funtionality.
# The headers will appear in the response if req.http.X-SendGDPR == "true" is set prior to execution.
# For a given Fastly service please update each desired route and include this flag to get the headers returned.
#

sub recv_gdpr {
    set req.http.x-has-gdpr = "false";
    set req.http.x-force-gdpr = "false";

    # If the incoming request had an `nyt-gdpr` cookie with a valid value (0|1)
    # then we capture that value in req.http.x-nyt-gdpr and mark the request
    # as having that cookie.
    if (!req.http.x-nyt-gdpr
        && req.http.Cookie:nyt-gdpr
        && (req.http.Cookie:nyt-gdpr == "0" || req.http.Cookie:nyt-gdpr == "1")
    ) {
        set req.http.x-has-gdpr = "true";
        set req.http.x-nyt-gdpr = req.http.Cookie:nyt-gdpr;
    }

    # If the request didn't have an `nyt-gdpr` cookie present, then we do geo detection
    # and match against the country list to determine whether headers should be sent back
    if (req.http.x-has-gdpr == "false") {
        # set a GDPR value for folks in the country list
        if (client.geo.country_code ~ "AT|BE|BG|HR|CY|CZ|DK|EE|FI|FR|DE|GR|HU|IE|IT|LV|LT|LU|MT|NL|PL|PT|RO|SK|SI|ES|SE|GB|IS|LI|NO|CH") {
            set req.http.x-nyt-gdpr = "1";
        } else {
            set req.http.x-nyt-gdpr = "0";
        }
    }

    # Request that have a query param of gdpr=0 or gdpr=1 can be
    # used to simulate EEA detection for testing purposes. This block
    # is what will parse the query param.
    if (req.url ~ "(?i)\?(?:|.*&)gdpr=([^&]*)") {
        if (re.group.1 == "0" || re.group.1 == "1") {
            set req.http.x-force-gdpr = "true";
            set req.http.x-nyt-gdpr = re.group.1;
        }
    }
}

# This can be called from to vcl_recv to enliven a service that can be used as a standalone
# EEA detection service.
sub recv_route_svc_gdpr {
    if (req.url ~ "/svc/gdpr\.json") {
        error 919 "GDPR service URL";
    }
}

sub error_919_gdpr {
    # JSON GDPR response
    if (obj.status == 919) {
        set obj.status = 200;
        set obj.http.Content-Type = "application/json; charset=utf-8";
        set obj.http.x-gdpr = req.http.x-nyt-gdpr;
        set obj.http.X-API-Version = "GDPR";
        if (req.http.origin ~ "\.(nytimes\.com|nyt\.net)$") {
            ## only allow nyt.net and nytimes.com domain for hace access control
            set obj.http.Access-Control-Allow-Origin = "*";
            set obj.http.Access-Control-Expose-Headers = "Content-Type";
            set obj.http.Access-Control-Allow-Methods = "GET, OPTIONS";
        } else if (!req.http.Origin || req.http.Origin == "null" ) {
            ## this is to support IOS requests. They don't send Header Origin
            set obj.http.Access-Control-Allow-Origin = "*";
            set obj.http.Access-Control-Expose-Headers = "Content-Type";
            set obj.http.Access-Control-Allow-Methods = "GET, OPTIONS";
        }
        synthetic
            {"{"GDPR":"} + req.http.x-nyt-gdpr + {"}"};
        return(deliver);
    }
}

sub deliver_gdpr {

    # this will either set a new cookie
    # or extend the existing one to a 6 hours
    # we will only do this for content pages

    if (req.http.x-force-gdpr == "true"
        || (req.http.X-SendGDPR == "true" && req.http.x-has-gdpr == "false")
    ) {
        add resp.http.Set-Cookie =
            "nyt-gdpr=" + req.http.x-nyt-gdpr + "; "+
            "Expires=" + time.add(now, 6h) + "; "+
            "Path=/; "+
            "Domain=.nytimes.com";

        # set the appropriate response header
        set resp.http.x-gdpr = req.http.x-nyt-gdpr;
    }
}
