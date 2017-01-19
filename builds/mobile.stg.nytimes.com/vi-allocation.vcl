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
    if (req.url ~ "^/$") {
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
    } else if (req.url ~ "^/2(01[4-9]|(0[2-9][0-9])|([1-9][0-9][0-9]))") {
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

    if (req.backend.healthy && client.ip ~ internal && req.http.x-environment == "stg") {

        # If cookie is set to "1", they should go to Vi - disabled for now
        # if (var.cookie-value == 1) { 

        # first phase is that if you allocate to either test, you always go to Vi
        if ( req.http.X-NYT-Vi-Cookie-Value ~ "(^|,)1\|" ) {
            set req.http.X-NYT-Project-Vi = "1";
            set req.backend = projectvi_fe_prd;

        # If cookie is set to "2", they are in control and always go to mobileweb
        } else if (var.cookie-value == 2) {
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
                    "([^\|]+)\|([^\|]+)\|mh",
                    req.http.X-NYT-Allocation-String 
                );
            } else if (var.allocation-id == "ms") {
                set req.http.X-NYT-Vi-Cookie-Value = regsub(
                    req.http.X-NYT-Vi-Cookie-Value,
                    "([^\|]+)\|([^\|]+)\|ms",
                    req.http.X-NYT-Allocation-String 
                );
            }
        }

    } else {
        # if vi is unhealthy, always mobileweb
        call set_mobileweb_fe_backend;
    }

}
