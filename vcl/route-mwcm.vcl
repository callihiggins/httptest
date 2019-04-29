sub recv_route_mwcm {

    if (req.http.var-nyt-canonical-www-host == "true") {

        if (    req.url ~ "^/subscription"  ||
                req.url ~ "^/marketing(/)?" ||
                req.url == "/services/mobile" ||
                req.url ~ "^/services/mobile/"
            ) {

            set req.http.x-nyt-route = "mwcm";
            set req.http.x-nyt-backend = "mwcm";
            set req.http.var-nyt-send-gdpr = "true";

            if (    req.url !~ "^/marketing/(gdpr|moco|mpc|account)(/)?"  &&
                    req.url !~ "^/subscription/exo(/)?"
                ) {

                if (req.url == "/subscriptions" || req.url ~ "^/subscriptions/") {
                      # excludes query string parameters except "ptr"
                      set req.url = querystring.filter_except(req.url, "ptr");
                } else {
                  # excludes "exclude_optimizely", "exclude_jsonkidd", "exclude_abra" qs parameters
                    set req.url = querystring.regfilter_except(req.url, "^(exclude_optimizely|exclude_jsonkidd|exclude_abra|mwcmff|campaignId|skipFastly|promoStartDate|pre_prod|previewPersona|mgnlPreviewAsVisitor|preferredLocale|date-override)$");
                }
            } else {
                  set req.http.x-nyt-route = "mwcm-params";
            }

            # sets value of the header "req.http.var-nyt-ismagnolia" to "true|false"
            # req.http.var-nyt-ismagnolia = "true" when requests comes to magnolia cms in mwcm backend
            # default vaule is "false"
            set req.http.var-nyt-ismagnolia = "false";

            if (    req.url == "/subscription" ||
                    req.url ~ "^/subscription(/|.html|\?)" ||
                    req.url ~ "^/marketing/(surveys|gdpr|moco|mpc|account)(/)?"
                ) {
                set req.http.var-nyt-ismagnolia = "true";

                # if a querystring `pre_prod=true` present
                # then change the x-nyt-backend to be `mwcm_preview`
                # and x-nyt-route to be `mwcm-preview`
                if (    req.http.x-nyt-nyhq-access == "1" &&
                        (   subfield(req.url.qs, "pre_prod", "&") == "true" ||
                            req.http.cookie:cmots_pre_prod == "true"
                        )
                    ) {
                    set req.http.x-nyt-route = "mwcm-preview";
                    set req.http.x-nyt-backend = "mwcm_preview";
                    set req.http.var-nyt-force-pass = "true";
                }

                call shared_recv_cmots_headers_init;

                # checks skipFastly=true qs param
                # if present, then sets x-nyt-miss
                # x-nyt-miss forces cache type to be miss if the request is coming from the internal ips.
                if ( subfield(req.url.qs, "skipFastly", "&") == "true" ) {
                    set req.http.x-nyt-miss = "1";
                }

                # this logic allows stripping of optimizely dependency via cookie "mwcm_exclude_optimizely"
                # checks the presence of the "mwcm_exclude_optimizely" cookie
                # appends "exclude_optimizely=true" qs parameter to the url
                # logic not applies to hd pages.
                if ( req.http.cookie:mwcm_exclude_optimizely && req.url !~ "^/subscription/hd(/)?") {
                    set req.url = querystring.add(req.url, "exclude_optimizely", "true");
                }

                # this logic allows stripping of jsonkidd dependency via cookie "mwcm_exclude_jsonkidd"
                # checks the presence of the "mwcm_exclude_jsonkidd" cookie
                # appends "exclude_jsonkidd=true" qs parameter to the url
                # logic not applies to hd pages.
                if ( req.http.cookie:mwcm_exclude_jsonkidd && req.url !~ "^/subscription/hd(/)?") {
                    set req.url = querystring.add(req.url, "exclude_jsonkidd", "true");
                }

                # checks for date-override or promoStartDate
                # if present, then sets x-nyt-miss
                # x-nyt-miss forces cache type to be miss if the request is coming from the internal ips.
                if ( req.url ~ "(\?|&)(promoStartDate|date-override)=" ) {
                    set req.http.x-nyt-miss = "1";
                }
            }
        }
    }
}

sub deliver_route_mwcm {

    if (    req.http.x-nyt-route ~ "^mwcm" ) {

        # Sets delivery headers
        # https://github.com/nytm/fastly-shared-cmots
        call shared_deliver_cmots_response_headers;

        # querystring appending logic applies to only mwcm route
        # does not applies to mwcm-params
        # reason: querystring are allowed to the backend for mwcm-params
        if (    req.http.x-nyt-route == "mwcm" &&
                (   resp.status == 301 ||
                    resp.status == 302
                )
            ) {

            if (resp.http.Location ~ "\?") {

                if (req.url ~ "^/subscription[^s]") {

                    # for "/subscription", we allow "campaignId" to the backend
                    # we need to strip campaignId and pre_prod from the http.x-nyt-orig-querystring
                    # as resp.http.Location will have the campaignId and pre_prod
                    if (    req.http.x-nyt-orig-querystring ~ "campaignId=([^&]*)" &&
                            resp.http.Location ~ "campaignId=([^&]*)"
                        ) {
                        set req.http.x-nyt-orig-querystring = regsub(req.http.x-nyt-orig-querystring, "campaignId=([^&]*)","");
                    }

                    if (    req.http.x-nyt-orig-querystring ~ "pre_prod=([^&]*)" &&
                            resp.http.Location ~ "pre_prod=([^&]*)"
                        ) {
                        set req.http.x-nyt-orig-querystring = regsub(req.http.x-nyt-orig-querystring, "pre_prod=([^&]*)","");
                    }

                    # appends x-nyt-orig-querystring to Location header
                    # appends when x-nyt-orig-querystring = "?test=test"
                    # does not appends when x-nyt-orig-querystring = "?"
                    if (req.http.x-nyt-orig-querystring != "?") {
                        set resp.http.Location = resp.http.Location regsub(req.http.x-nyt-orig-querystring, "^\?", "&");
                    }
                } else {
                    set resp.http.Location = resp.http.Location regsub(req.http.x-nyt-orig-querystring, "^\?", "&");
                }
            } else {
                set resp.http.Location = resp.http.Location req.http.x-nyt-orig-querystring;
            }
        }

        if (req.http.Origin ~ "\.nyt(imes)?\.(com|net)(:\d+)?$") {
            ## only allow nyt.net and nytimes.com domain for hace access control
            set resp.http.Access-Control-Allow-Origin = req.http.Origin;
            set resp.http.Access-Control-Allow-Credentials = "true";
        } else if (!req.http.Origin || req.http.Origin == "null" ) {
            ## this is to support IOS requests. They don't send Header Origin
            set resp.http.Access-Control-Allow-Origin = "*";
            set resp.http.Access-Control-Allow-Credentials = "true";
        }
    }
}

sub miss_pass_route_mwcm {
    #https://community.fastly.com/t/pull-cookie-values-without-regular-expressions/430
    #https://www.getpagespeed.com/server-setup/varnish/varnish-cache-cookies
    # logic to allow NYT-S and nyt-a cookies to mwcm backend
    if (req.http.x-nyt-route ~ "^mwcm" && req.http.var-nyt-ismagnolia == "true") {
        set bereq.http.cookie = "";

        if ( req.http.cookie:nyt-a ) {
            #checks the presence of the nyt-a
            # allows nyt-a to MWCM backend
            set bereq.http.cookie = "nyt-a=" req.http.cookie:nyt-a ";";
        }
        else if (req.http.var-cookie-nyt-a) {
            set bereq.http.cookie = "nyt-a=" req.http.var-cookie-nyt-a ";";
        }

        if (req.http.cookie:NYT-S) {
            #checks the presence of the NYT-S
            # allows NYT-S to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " NYT-S=" req.http.cookie:NYT-S ";";
        }

        if (req.http.cookie:nyt-mwcm) {
            #checks the presence of the nyt-mwcm
            # allows nyt-mwcm to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " nyt-mwcm=" req.http.cookie:nyt-mwcm ";";
        }

        if (req.http.cookie:ab7 && req.http.x-nyt-nyhq-access == "1") {
            #checks the presence of ab7 and nyhd
            # allows ab7 to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " ab7=" req.http.cookie:ab7 ";";
        }

        if (req.http.cookie:cmots_pre_prod && req.http.x-nyt-nyhq-access == "1") {
            #checks the presence of  cmots_pre_prod and nyhd
            # allows ab7 to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " cmots_pre_prod=" req.http.cookie:cmots_pre_prod ";";
        }

        if (req.http.cookie:nyt-d) {
            #checks the presence of the nyt-d
            # allows nyt-d to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " nyt-d=" req.http.cookie:nyt-d ";";
        }

        if (req.http.cookie:edu_cig_opt) {
            #checks the presence of the edu_cig_opt
            # allows edu_cig_opt to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " edu_cig_opt=" req.http.cookie:edu_cig_opt ";";
        }

        if (req.http.cookie:b2b_cig_opt) {
            #checks the presence of the b2b_cig_opt
            # allows b2b_cig_opt to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " b2b_cig_opt=" req.http.cookie:b2b_cig_opt ";";
        }
    }
}
