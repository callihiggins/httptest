#                                                  `vi`     hp/st/oth   WP_ProjectVi(2)
#                       allocation logic:          cookie:  backend:    Abra variation:
#   -----------------------------------------------------------------------------------------
#   HP + Story:         (Rigor monitoring)       => "a0"    vi/vi/mw    -
#   excluded:           (geoip CA or AU)         => "z0"    mw/mw/mw    -
#   grandfathered Vi:   if (nyt.np.vi ~= /^1/)   => "b1"    vi/mw/mw    WP_ProjectVi="vi"
#   grandfathered ctrl: if (nyt.np.vi ~= /^2/)   => "z1"    mw/mw/mw    WP_ProjectVi="0"
#   HP + Story:         else {  Abra  0%         => "a2"    vi/vi/mw    WP_ProjectVi2="hp-st"
#   HP only:                    Abra  1%         => "b2"    vi/mw/mw    WP_ProjectVi2="hp"
#   Story only:                 Abra  0%         => "c2"    mw/vi/mw    WP_ProjectVi2="st"
#   ctrl (reported):            Abra  1%         => "z2"    mw/mw/mw    WP_ProjectVi2="0"
#   ctrl (unreported):          Abra 98%  }      => "z0"    mw/mw/mw    -
#   HP only:            (no use case yet)        => "b0"    mw/vi/mw    -
#   Story only:         (no use case yet)        => "c0"    mw/vi/mw    -
#
#   `vi` cookie meaning:
#       z = mw/mw/mw    1 = report for WP_ProjectVi     [0-9] = last digit of year in
#       a = vi/vi/mw    2 = report for WP_ProjectVi2            which cookie will expire
#       b = vi/mw/mw    0 = don't report
#       c = mw/vi/mw

sub vcl_recv {
    declare local var.hash STRING;
    declare local var.dart INTEGER;
    declare local var.test_group STRING;
    declare local var.abra_overrides STRING;

    #
    # (1) Determine our test_group.
    #

    # allow forcing our variation with querystring like `?abra=WP_ProjectVi2=hp-st`
    # or cookie like `ab7=WP_ProjectVi2=hp-st`:
    if (client.ip ~ internal || client.ip ~ external_staging_access) {
        set var.abra_overrides = "";
        # let `abra` querystring come first for priority over `ab7` cookie:
        if (req.url ~ "(?i)\?(?:|.*&)abra=([^&]*)") {
            set var.abra_overrides = urldecode(re.group.1);
        }
        if (req.http.cookie:ab7) {
            set var.abra_overrides = var.abra_overrides + "&" + urldecode(req.http.cookie:ab7);
        }
    }

    if (var.abra_overrides ~ "(?:^|&)WP_ProjectVi2=([^&]*)") {
        if      (re.group.1 == "hp-st")   { set var.test_group = "a0"; } # translate to equiv.
        else if (re.group.1 == "hp")      { set var.test_group = "b0"; } # test_group code
        else if (re.group.1 == "st")      { set var.test_group = "c0"; }
        else if (re.group.1 == "hp-st*")  { set var.test_group = "a2"; } # trailing `*` means,
        else if (re.group.1 == "hp*")     { set var.test_group = "b2"; } # make the frontend
        else if (re.group.1 == "st*")     { set var.test_group = "c2"; } # report this to Abra
        else if (re.group.1 ~ "\*$")      { set var.test_group = "z2"; }
        else                              { set var.test_group = "z0"; } # default to ctrl grp

    } else if (req.http.X-Rigor-Vi-Access == "1") {
        # Special header granting access to Vi for Rigor testing
        set var.test_group = "a0"; # HP + Story, unreported
        # TODO: change Rigor to use `ab7` cookie override

    } else if (geoip.country_code == "CA" || geoip.country_code == "AU") {
        # Canada and Australia excluded
        set var.test_group = "z0"; # control, unreported

    } else if (req.http.Cookie:nyt.np.vi ~ "^1") {
        # grandfathered into Vi, "1":
        set var.test_group = "b1"; # HP only, WP_ProjectVi="vi"
        # TODO (optimization): replace `nyt.np.vi` cookie with `vi` cookie?

    } else if (req.http.Cookie:nyt.np.vi ~ "^2") {
        # grandfathered into control, "2":
        set var.test_group = "z1"; # control, WP_ProjectVi="0"
        # TODO (optimization): replace `nyt.np.vi` cookie with `vi` cookie?

    } else {
        # use Abra-style allocation, like so:
        # 0..1%:    "b2" (HP only, reported)
        # 1..6%:    "z2" (control, reported)
        # 6..10%:   "b2" (HP only, reported)
        # 10..100%: "z0" (control, unreported)

        set var.hash = digest.hash_sha256(req.http.x--fastly-nyt-a + " WP_ProjectVi2");
        set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
        set var.dart = std.strtol(var.hash, 16);

        if (var.dart < 42949673) { # 1% * 0x100000000
            set var.test_group = "b2"; # HP only, reported

        } else if (var.dart < 257698038) { # 6% * 0x100000000
            set var.test_group = "z2"; # control, reported

        } else if (var.dart < 429496730) { # 10% * 0x100000000
            set var.test_group = "b2"; # HP only, reported

        } else { # var.dart < 0x100000000
            set var.test_group = "z0"; # control, unreported
        }

        # override with 1/3 each in staging:
        if (req.http.x-environment == "stg") {
            if (var.dart < 1431655765) { # 1/3 * 0x100000000
                set var.test_group = "b2"; # HP only, reported

            } else if (var.dart < 2863311531) { # 2/3 * 0x100000000
                set var.test_group = "z2"; # control, reported

            } else { # var.dart < 0x100000000
                set var.test_group = "z0"; # control, unreported
            }
        }
    }

    # use the req object to stash our test group and incoming `vi` cookie,
    # so later in vcl_recv we can set the outgoing `vi` cookie if needed:
    set req.http.x--fastly-vi-test-group = var.test_group;
    set req.http.x--fastly-req-cookie-vi = req.http.cookie:vi;


    #
    # (2) Decide which beckend to use for this request.
    #

    # Resources hosted by Vi must go to Vi, dead or alive:
    if (req.url.path ~ "^/((0_vendor-|main-|[0-9]+-).+|fonts).js$") {
        call set_projectvi_fe_backend;

    } else {
        # For other resources:
        if (req.url.path == "/" && var.test_group ~ "^[ab]") {
            # homepage, in a test group getting Vi homepage
            call set_projectvi_fe_backend;

        } else if (req.url.path ~ "^/2(01[4-9]|(0[2-9][0-9])|([1-9][0-9][0-9]))"
                   && req.url.path !~ "\.amp\.html$" && var.test_group ~ "^[ac]") {
            # story page, in a test group getting Vi story pages
            call set_projectvi_fe_backend;

        } else {
            # default everything else to Mobile Web:
            call set_mobileweb_fe_backend;
        }

        if ((req.backend == projectvi_fe_prd || req.backend == projectvi_fe_dev) && !req.backend.healthy) {
            call set_mobileweb_fe_backend; # fallback to MW if Vi is unhealthy
        }
    }

    if (req.backend == projectvi_fe_prd || req.backend == projectvi_fe_dev) {
        # must set this for hashing and saint mode in default.vcl:
        set req.http.X-NYT-Project-Vi = "1";
    }
}

sub vcl_deliver {
    declare local var.now_dt TIME;
    declare local var.now_year INTEGER;
    declare local var.expire_year STRING;
    declare local var.expire_year_last_digit STRING;
    declare local var.vi_cookie_desired STRING;

    if (resp.http.Content-Type ~ "^text/html *(;|$)") {

        # Requirements for the `vi` cookie:
        #
        #  1. It should be set once per calendar year, at most, to minimize
        #     the weight of Set-Cookie headers
        #  2. It should last at least ~365 days after response is delivered,
        #     for frontend JS to read it during lifetime of page
        #  3. It should expire as soon as possible, within these constraints
        #     and without bloating the cookie size
        #
        # We achieve this (micro-)optimization by setting the cookie's
        # expiration date to Jan 1 of the year after next, and encoding this
        # date (as the last digit of the year) inside the cookie so we can
        # check it here and bump the expiration if needed. Of course, we also
        # update the cookie if its payload just needs to be changed.

        set var.now_dt = now;

        # UGH. Maybe there's a better way, but I had to abuse timestamp
        # manipulation functions here to awkwardly workaround Fastly's lack of
        # support for integer math. See:
        # <https://community.fastly.com/t/vcl-fastly-integer-math/817>
        # <https://docs.fastly.com/guides/vcl/date-and-time-related-vcl-
        # features>

        # get current year as integer:
        set var.now_year = std.atoi(strftime({"%Y"}, var.now_dt));
        # add 2 directly to year number (thereby accounting for leap years), getting result as string:
        set var.expire_year = strftime({"%s"}, time.add(std.integer2time(var.now_year), 2s));

        # We want our `vi` cookie to be our test group, plus the year number
        # at least ~365 days from now (encoded as its last digit):
        set var.expire_year_last_digit = regsub(var.expire_year, "^\d+(\d)$|^.*$", "\1");
        set var.vi_cookie_desired = req.http.x--fastly-vi-test-group + var.expire_year_last_digit;

        # If the existing cookie is wrong, we need to update it. But also, if
        # the date encoded within it is different from our desired expiration
        # date, we need to bump it:
        if (req.http.x--fastly-req-cookie-vi != var.vi_cookie_desired) {
            add resp.http.Set-Cookie =
                "vi=" + var.vi_cookie_desired +
                "; path=/; domain=.nytimes.com; expires=" +
                std.time(
                    "Sun, 1 Jan " + var.expire_year + " 00:00:00 GMT", # the "Sun" part doesn't matter
                    time.add(var.now_dt, 730d) # default to 2 years from now if std.time parsing fails
                );
        }

        # set resp.http.X-Debug-now_dt = var.now_dt;
        # set resp.http.X-Debug-now_year = var.now_year;
        # set resp.http.X-Debug-expire_year = var.expire_year;
        # set resp.http.X-Debug-vi_cookie_desired = var.vi_cookie_desired;
        # set resp.http.X-Debug-vi_cookie_actual = "here --> '" + req.http.x--fastly-req-cookie-vi + "'";
    }
}


# the backend doesn't need the private vars we've stashed on the request,
# so zap them from the backend request using vcl_miss and vcl_pass:
sub vcl_miss {
    unset bereq.http.x--fastly-req-cookie-vi;
    unset bereq.http.x--fastly-vi-test-group;
}
sub vcl_pass {
    unset bereq.http.x--fastly-req-cookie-vi;
    unset bereq.http.x--fastly-vi-test-group;
}


# SAVE EITAN
