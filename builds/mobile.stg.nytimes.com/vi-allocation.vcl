sub vcl_recv {

    declare local var.allocation-id STRING;
    declare local var.allocation-version INTEGER;
    declare local var.allocation-numerator INTEGER;
    declare local var.allocation-denominator INTEGER;

    declare local var.cookie-value INTEGER;
    declare local var.cookie-version INTEGER;
    declare local var.cookie-id STRING;
    declare local var.original-cookie-allocation-string STRING;

    # capture the original cookie value for later
    set req.http.X-NYT-Vi-Cookie-Value = if(req.http.Cookie:nyt.np.vi, req.http.Cookie:nyt.np.vi, "");


    # Allocation configuration

    # Mobile Home Screen
    if (req.url.path ~ "^/$") {
        set var.allocation-id = "mh";
        set var.allocation-version = 1;
        set var.allocation-numerator = 20;
        set var.allocation-denominator = 1000;

        if ( req.http.X-NYT-Vi-Cookie-Value ~ "(^|,)(([^\|]+)\|([^\|]+)\|mh)(,|$)" ) {
            set var.original-cookie-allocation-string = re.group.2;
            set var.cookie-value = std.atoi(re.group.3);
            set var.cookie-version = std.atoi(re.group.4);
            set var.cookie-id = var.allocation-id;
        } else {
            set var.original-cookie-allocation-string = "";
        }

    # Mobile Story
    } else if (req.url.path ~ "^/2(01[4-9]|(0[2-9][0-9])|([1-9][0-9][0-9]))" && req.url.path !~ ".amp.html") {
        set var.allocation-id = "ms";
        set var.allocation-version = 1;
        set var.allocation-numerator = 20;
        set var.allocation-denominator = 1000;

        # parse cookie for story
        if ( req.http.X-NYT-Vi-Cookie-Value ~ "(^|,)(([^\|]+)\|([^\|]+)\|ms)(,|$)" ) {
            set var.original-cookie-allocation-string = re.group.2;
            set var.cookie-value = std.atoi(re.group.3);
            set var.cookie-version = std.atoi(re.group.4);
            set var.cookie-id = var.allocation-id;
        } else {
            set var.original-cookie-allocation-string = "";
        }

    # Not a URL we allocate on, but could be a resource url that needs to go to vi
    } else if (req.url.path ~ "^/((0_vendor-|main-|[0-9]+-).+|fonts).js$") {
        # value to send to vi
        set var.cookie-value = 1;

    # Any other request, we should ignore and send to MW
    } else {
        # value to prevent allocation 
        set var.cookie-value = 999;
    }

    set req.http.X-Debug-ViAlloc-cookiestring = "*" + var.original-cookie-allocation-string + "*";
    set req.http.X-Debug-ViAlloc-cookievalue = "#" + var.cookie-value + "#";
    set req.http.X-Debug-ViAlloc-cookieversion = "#" + var.cookie-version + "#";
    set req.http.X-Debug-ViAlloc-cookieid = "*" + var.cookie-id + "*";

    # set to 50% in staging
    if (req.http.x-environment == "stg") {
        set var.allocation-numerator = 1;
        set var.allocation-denominator = 2;
    }

    # temporarily set to project vi backend so we can do a health check on it
    set req.backend = projectvi_fe_prd;

    # only allocate if vi backend is up and the no-allocate cookie val isn't set
    #  for now, Canada IP addresses are also excluded
    if ( req.backend.healthy && var.cookie-value != 999 && geoip.country_code != "CA" ) {

        # First phase is that if you allocate to either test, you always go to Vi
        # Originally: ( var.cookie-value == 1 || req.http.X-NYT-Vi-Cookie-Value ~ "(^|,)1\|" )

        # !!! Update from Data Engineering: always check first value in the cookie
        if ( req.http.X-NYT-Vi-Cookie-Value ~ "^1\|" ) {
            set req.http.X-NYT-Project-Vi = "1";
            set req.backend = projectvi_fe_prd;

        # If cookie is set to "2", they are in control and always go to mobileweb
        # Originally: (var.cookie-value == 2)

        # !!! Update from Data Engineering: always check first value in the cookie
        } else if ( req.http.X-NYT-Vi-Cookie-Value ~ "^2\|" ) {
            set req.http.X-NYT-Project-Vi = "2";
            call set_mobileweb_fe_backend;

        # If cookie doesn't exist, or in an old phase, reallocate
        } else if ( 
               req.http.X-NYT-Vi-Cookie-Value == ""
            || var.original-cookie-allocation-string == ""
            || (var.cookie-id == var.allocation-id && var.cookie-version != var.allocation-version)
        ) {
            if (randombool(var.allocation-numerator, var.allocation-denominator)) {

                # Have to allocate some of these to control
                if (randombool(1, 2)) {
                    set req.http.X-NYT-Project-Vi = "1";
                    set req.backend = projectvi_fe_prd;
                } else {
                    set req.http.X-NYT-Project-Vi = "2";
                    call set_mobileweb_fe_backend;
                }

            } else {
                set req.http.X-NYT-Project-Vi = "9";
                call set_mobileweb_fe_backend;
            }

        # If cookie is set to anything else, send to MW
        } else {
            set req.http.X-NYT-Project-Vi = "9";
            call set_mobileweb_fe_backend;
        }


        # Update the cookie string to set, based on above allocaiton

        # if there was no cookie to begin with, set to the current allocation
        if (req.http.X-NYT-Vi-Cookie-Value == "") {
            set req.http.X-Debug-ViAlloc-path = "nocookie";
            set req.http.X-NYT-Vi-Cookie-Value = 
                req.http.X-NYT-Project-Vi + "|" + var.allocation-version + "|" + var.allocation-id;

        # if there was a cookie, but this allocation was not present, append it
        } else if (var.original-cookie-allocation-string == "") {
            set req.http.X-Debug-ViAlloc-path = "noidalloc";
            set req.http.X-NYT-Vi-Cookie-Value = req.http.X-NYT-Vi-Cookie-Value + "," +
                req.http.X-NYT-Project-Vi + "|" + var.allocation-version + "|" + var.allocation-id;

        # otherwise, replace the original allocation string with the new one
        } else {
            set req.http.X-Debug-ViAlloc-path = "updatealloc";

            set req.http.X-NYT-Allocation-String = 
                    req.http.X-NYT-Project-Vi + "|" + var.allocation-version + "|" + var.allocation-id;

            # can't use a variable in regsub, so have to do this manually. ugh
            if (var.allocation-id == "mh") {
                set req.http.X-NYT-Vi-Cookie-Value = regsub(
                    req.http.X-NYT-Vi-Cookie-Value,
                    "([^\|,]+)\|([^\|]+)\|mh",
                    req.http.X-NYT-Allocation-String
                );
            } else if (var.allocation-id == "ms") {
                set req.http.X-NYT-Vi-Cookie-Value = regsub(
                    req.http.X-NYT-Vi-Cookie-Value,
                    "([^\|,]+)\|([^\|]+)\|ms",
                    req.http.X-NYT-Allocation-String
                );
            }
        }

    # Default to mobileweb with no allocation
    } else {
        call set_mobileweb_fe_backend;
    }

}
