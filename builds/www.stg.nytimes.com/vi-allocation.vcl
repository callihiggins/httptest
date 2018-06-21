#                                              `vi_www_hp`  hp/st/oth       WP_ProjectVi_www_hp
#                       allocation logic:          cookie:  backend:        Abra variation:
#   ----------------------------------------------------------------------------------------------
#   HP + Story:         (Rigor monitoring)       => "a0"    vi/vi/nyt5      -
#   excluded:           (geoip CA or AU)         => "z0"    nyt5/nyt5/nyt5  -
#   HP + Story:         else {  Abra  0%         => "a2"    vi/vi/nyt5      WP_ProjectVi_www_hp="hp-st"
#   HP only:                    Abra  1%         => "b2"    vi/nyt5/nyt5    WP_ProjectVi_www_hp="hp"
#   Story only:                 Abra  0%         => "c2"    nyt5/vi/nyt5    WP_ProjectVi_www_hp="st"
#   ctrl (reported):            Abra  1%         => "z2"    nyt5/nyt5/nyt5  WP_ProjectVi_www_hp="0"
#   ctrl (unreported):          Abra 98%  }      => "z0"    nyt5/nyt5/nyt5  -
#   HP only:            (no use case yet)        => "b0"    nyt5/vi/nyt5    -
#   Story only:         (no use case yet)        => "c0"    nyt5/vi/nyt5    -
#                                                               (^ not sure if these allocations affect
#                                                                  any routes other than home anymore)
#   HP only:                    Abra  0.5%       => "e2"    vi/nyt5/nyt5    WP_ProjectVi_www_hp="hp-serv"
#   HP only:                    Abra  0.5%       => "f2"    vi/nyt5/nyt5    WP_ProjectVi_www_hp="hp-orig"
#   HP only:                    Abra  0.33%      => "g2"    vi/nyt5/nyt5    WP_ProjectVi_www_hp="hp-rm_gpt_media_dfp"
#   HP only:                    Abra  0.33%      => "h2"    vi/nyt5/nyt5    WP_ProjectVi_www_hp="hp-rm_media_dfp"
#   HP only:                    Abra  0.33%      => "i2"    vi/nyt5/nyt5    WP_ProjectVi_www_hp="hp-orig_dfp"
#                                                               (^ Full server side rendered home AB test)
#
#   `vi_www_hp` cookie (not read; used ONLY to signal to frontend JavaScript):
#       z = nyt5            1 = report for WP_ProjectVi     [0-9] = last digit of year in
#       a = vi              2 = report for WP_ProjectVi_www_hp      which cookie will expire
#       b = vi              0 = don't report
#       c = nyt5
#       d = vi (added Dec. 2017)
#       y = nyt5 (added Dec. 2017)
#       e = vi ab test variation with server-rendered homepage (added Feb. 2018)
#       f = vi ab test control (added Feb. 2018)
#       g = vi dfp ab test variation, remove gpt media (added June 2018)
#       h = vi dfp ab test variation, remove media (added June 2018)
#       i = vi dfp ab test control (added June 2018)
#
#   `vi_www_hp_opt` cookie meaning (handled elsewhere):
#       1 = force vi homepage
#       0 = opt out vi homepage
#
#   `vi_story_opt` cookie meaning (handled elsewhere):
#       1 = force vi stories
#       0 = opt out vi stories
#
#   `ab7` cookie can also be used to override ABRA allocation into any
#   variation of homepage and story tests, consistent with other ABRA
#   implementations, but can only be used by clients with internal NYT IPs
#   (unlike `vi_www_hp_opt` and `vi_story_opt`, which do not appear to be
#   IP-restricted).

sub recv_vi_allocation_init {
    declare local var.hash STRING;
    declare local var.d INTEGER;
    declare local var.test_group STRING;
    declare local var.abra_overrides STRING;

    # only if this execution is not on the shield pop in a shielding scenario
    if (!req.http.x-nyt-shield-auth) {

        if (!req.http.x-ab7 && req.http.cookie:ab7) {
            set req.http.x-ab7 = req.http.cookie:ab7;
        }

        if (!req.http.x-vistory && req.http.cookie:vistory) {
            set req.http.x-vistory = req.http.cookie:vistory;
        }

        if (!req.http.x-vi-story-opt && req.http.cookie:vi_story_opt) {
            set req.http.x-vi-story-opt = req.http.cookie:vi_story_opt;
        } else { // if there is no opt-out value, default them to vi
            set req.http.x-vi-story-opt = "1";
        }

        #
        # (1) Determine our test_group.
        #

        # allow forcing our variation with querystring like `?abra=WP_ProjectVi_www_hp=hp-st`
        # or cookie like `ab7=WP_ProjectVi_www_hp=hp-st`:
        if (req.http.x-nyt-internal-access || req.http.x-nyt-external-access) {
            set var.abra_overrides = "";
            # let `abra` querystring come first for priority over `ab7` cookie:
            if (req.url ~ "(?i)\?(?:|.*&)abra=([^&]*)") {
                set var.abra_overrides = urldecode(re.group.1);
            }
            if (req.http.x-ab7) {
                set var.abra_overrides = var.abra_overrides + "&" + urldecode(req.http.x-ab7);
            }
        }


        # Bypass to vi for onion clients
        if (req.http.X-From-Onion == "1") {
            set var.test_group = "b2";
        } else if (var.abra_overrides ~ "(?:^|&)WP_ProjectVi_www_hp=([^&]*)") {
            if      (re.group.1 == "hp-st")               { set var.test_group = "a0"; } # translate to equiv.
            else if (re.group.1 == "hp")                  { set var.test_group = "b0"; } # test_group code
            else if (re.group.1 == "st")                  { set var.test_group = "c0"; }
            else if (re.group.1 == "hp-st*")              { set var.test_group = "a2"; } # trailing `*` means,
            else if (re.group.1 == "hp-serv")             { set var.test_group = "e2"; } # HP ab test variant
            else if (re.group.1 == "hp-orig")             { set var.test_group = "f2"; } # HP ab test control
            else if (re.group.1 == "hp-rm_gpt_media_dfp") { set var.test_group = "g2"; } # HP ab test dfp variant
            else if (re.group.1 == "hp-rm_media_dfp")     { set var.test_group = "h2"; } # HP ab test dfp variant
            else if (re.group.1 == "hp-orig_dfp")         { set var.test_group = "i2"; } # HP ab test dfp control
            else if (re.group.1 == "hp*")                 { set var.test_group = "b2"; } # make the frontend
            else if (re.group.1 == "st*")                 { set var.test_group = "c2"; } # report this to Abra
            else if (re.group.1 ~ "\*$")                  { set var.test_group = "z2"; }
            else                                          { set var.test_group = "z0"; } # default to ctrl grp
        } else if (req.http.X-Rigor-Vi-Access == "1") {
            # Special header granting access to Vi for Rigor testing
            set var.test_group = "a0"; # HP + Story, unreported
            # TODO: change Rigor to use `ab7` cookie override

        } else if (client.geo.country_code == "CA" || client.geo.country_code == "AU") {
            # Canada and Australia excluded
            set var.test_group = "z0"; # control, unreported

        } else {
            # use Abra-style allocation, like so:
            # 0..1%:    "b2" (HP only, reported)
            # 1..2%:    "z2" (control, reported)
            # 2..100%:  "z0" (control, unreported)

            set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " WP_ProjectVi_www_hp");
            set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
            set var.d = std.strtol(var.hash, 16);

            if (req.http.var-nyt-env == "prd") {
                if      (var.d < 0042949673) { set var.test_group = "b2"; } # < 1%      HP only, reported
                else if (var.d < 0085899346) { set var.test_group = "z2"; } # < 2%      control, reported
                else if (var.d < 0128849019) { set var.test_group = "d2"; } # < 3%      HP only (added Dec. 2017), reported
                else if (var.d < 0171798692) { set var.test_group = "y2"; } # < 4%      control (added Dec. 2017), reported
                else if (var.d < 0193273528) { set var.test_group = "e2"; } # < 4.5%    hp-serv (added Feb. 2018), reported
                else if (var.d < 0214748365) { set var.test_group = "f2"; } # < 5%      hp-orig (added Feb. 2018), reported
                else if (var.d < 0229064922) { set var.test_group = "g2"; } # < 5+1/3%  hp-rm_gpt_media_dfp (added June 2018), reported
                else if (var.d < 0243381480) { set var.test_group = "h2"; } # < 5+2/3%  hp-rm_media_dfp (added June 2018), reported
                else if (var.d < 0257698038) { set var.test_group = "i2"; } # < 6%      hp-orig_dfp (added June 2018), reported
                else   /* var.d < 2^32 */    { set var.test_group = "z0"; } # < 100%    control, unreported
            } else { # in staging or dev, use equal weights:
                if      (var.d < 0429496730) { set var.test_group = "b2"; } # < 1/10    HP only, reported
                else if (var.d < 0858993460) { set var.test_group = "z2"; } # < 2/10    control, reported
                else if (var.d < 1288490190) { set var.test_group = "d2"; } # < 3/10    HP only (added Dec. 2017), reported
                else if (var.d < 1717986920) { set var.test_group = "y2"; } # < 4/10    control (added Dec. 2017), reported
                else if (var.d < 2147483650) { set var.test_group = "e2"; } # < 5/10    hp-serv (added Feb. 2018), reported
                else if (var.d < 2576980380) { set var.test_group = "f2"; } # < 6/10    hp-orig (added Feb. 2018), reported
                else if (var.d < 3006477110) { set var.test_group = "g2"; } # < 7/10    hp-rm_gpt_media_dfp (added June 2018), reported
                else if (var.d < 3435973840) { set var.test_group = "h2"; } # < 8/10    hp-rm_media_dfp (added June 2018), reported
                else if (var.d < 3865470570) { set var.test_group = "i2"; } # < 9/10    hp-orig_dfp (added June 2018), reported
                else  /* var.d < 2^32 */     { set var.test_group = "z0"; } # < 10/10   control, unreported
            }
        }
        # If we're in the server-render test variation, tell Vi to server-render
        # the homepage via a header named `x-vi-ssr-www-hp` (which is meaningless
        # to the other backends and will be ignored):
        if (req.url.path == "/" && var.test_group ~ "^e") {
            set req.http.x-vi-ssr-www-hp = "hp-serv";
        } else if (req.url.path == "/" && var.test_group ~ "^f"){
            set req.http.x-vi-ssr-www-hp = "hp-orig";
        } else if (req.url.path == "/" && var.test_group ~ "^g"){
            set req.http.x-vi-ssr-www-hp = "hp-rm_gpt_media_dfp";
        } else if (req.url.path == "/" && var.test_group ~ "^h"){
            set req.http.x-vi-ssr-www-hp = "hp-rm_media_dfp";
        } else if (req.url.path == "/" && var.test_group ~ "^i"){
            set req.http.x-vi-ssr-www-hp = "hp-orig_dfp";
        } else {
            set req.http.x-vi-ssr-www-hp = "";
        }

        # use the req object to stash our test group and incoming `vi_www_hp` cookie,
        # so later in vcl_recv we can set the outgoing `vi_www_hp` cookie if needed
        # shield pop also needs these headers
        set req.http.x--fastly-vi-test-group = var.test_group;
        set req.http.x--fastly-req-cookie-vi = req.http.cookie:vi_www_hp;
        set req.http.x--fastly-vi-story-opt = req.http.x-vi-story-opt;
        set req.http.x--fastly-dart = var.d;
    }
}

sub deliver_vi_allocation_set_cookie {

    # only if this execution is not on the shield pop in a shielding scenario
    if (!req.http.x-nyt-shield-auth) {
        declare local var.now_dt TIME;
        declare local var.now_year INTEGER;
        declare local var.expire_year STRING;
        declare local var.expire_year_last_digit STRING;
        declare local var.vi_cookie_desired STRING;
        declare local var.vi_cookie_desired_story STRING;

        if (resp.http.Content-Type ~ "^text/html *(;|$)") {

            # Requirements for the `vi_www_hp` cookie:
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

            # We want our `vi_www_hp` cookie to be our test group, plus the year number
            # at least ~365 days from now (encoded as its last digit):
            set var.expire_year_last_digit = regsub(var.expire_year, "^\d+(\d)$|^.*$", "\1");
            set var.vi_cookie_desired = req.http.x--fastly-vi-test-group + var.expire_year_last_digit;

            # If the existing cookie is wrong, we need to update it. But also, if
            # the date encoded within it is different from our desired expiration
            # date, we need to bump it.
            if (req.http.x--fastly-req-cookie-vi != var.vi_cookie_desired) {
                add resp.http.Set-Cookie =
                    "vi_www_hp=" + var.vi_cookie_desired +
                    "; path=/; domain=.nytimes.com; expires=" +
                    std.time(
                        "Sun, 1 Jan " + var.expire_year + " 00:00:00 GMT", # the "Sun" part doesn't matter
                        time.add(var.now_dt, 730d) # default to 2 years from now if std.time parsing fails
                    );
            }

        #     set resp.http.X-Debug-now_dt = var.now_dt;
        #     set resp.http.X-Debug-now_year = var.now_year;
        #     set resp.http.X-Debug-expire_year = var.expire_year;
        #     set resp.http.X-Debug-vi_cookie_desired = var.vi_cookie_desired;
        #     set resp.http.X-Debug-vi_cookie_actual = "here --> '" + req.http.x--fastly-req-cookie-vi + "'";
        #     set resp.http.X-Debug-dart = "dart --> '" + req.http.x--fastly-dart + "'";
        #     set resp.http.X-Debug-vi_story_opt = "here --> '" + req.http.x--fastly-vi-story-opt + "'";
        }

        # for debugging and automated tests:
        if (req.http.x-nyt-debug ~ "." && (req.http.x-nyt-internal-access || req.http.x-nyt-external-access)) {
            set resp.http.x-nyt-debug-req-http-x-vi-ssr-www-hp = req.http.x-vi-ssr-www-hp;
        }
    }
}

# the origin doesn't need the private vars we've stashed on the request,
# so zap them from the backend request using vcl_miss and vcl_pass
# do NOT remove these if the backend is a fastly shield pop as we need these
# headers used to override vi-alloc logic in the shield
# so that it is ALWAYS controlled by the edge pop when talking to a shield
sub miss_pass_remove_vialloc_headers {
    if (!req.http.var-nyt-is-shielded) {
        unset bereq.http.x--fastly-req-cookie-vi;
        unset bereq.http.x--fastly-vi-test-group;
        unset bereq.http.x--fastly-project-vi;
        unset bereq.http.x-nyt-vi-alloc-edge;
    } else {
        # this is an edge talking to a shield, set the vi-alloc indicator for the shield specifcally
        if (bereq.http.x--fastly-project-vi == "1") {
            set bereq.http.x-nyt-vi-alloc-edge = "true";
        }
    }
}

# SAVE EITAN
