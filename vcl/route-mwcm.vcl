sub recv_route_mwcm {

    if (req.http.var-nyt-canonical-www-host == "true") {

        if (    req.url ~ "^/subscription"  ||
                req.url ~ "^/marketing(/)?" ||
                req.url ~ "^/initiative($|/|\?)" ||
                req.url ~ "^/payments($|/|\?)" ||
                req.url == "/services/mobile" ||
                req.url ~ "^/services/mobile/"
            ) {

            set req.http.x-nyt-route = "mwcm";
            set req.http.x-nyt-backend = "mwcm";
            set req.http.var-nyt-send-gdpr = "true";
            set req.http.var-nyt-cmots-s3-fallback = "false";

            # query string whitelist
            # repo: https://github.com/nytm/fastly-shared-cmots
            call shared_recv_cmots_qs_params_whitelist;

            # routes to mwcm_resilient backend if req.restart greater than "0"
            # sets route as "mwcm-resilient"
            # sets backend as "mwcm_resilient"
            if ( req.restarts > 0) {
                set req.http.x-nyt-route = "mwcm-resilient";
                set req.http.x-nyt-backend = "mwcm_resilient";
                set req.http.x-nyt-mwcm-fallback = req.url;

                # NOTE: Supports html for the metered assets fallback, no consumers for now.
                if ( req.url ~ "^/marketing/mpc/" && req.http.x-nyt-user-status != "sub") {
                    # serves "non-sub"|"regi"|"anon" specific fallback content
                    set req.url = "/subscription/resilient/mwcm/mcassets-nonsub.json";
                } else if (req.url ~ "^/marketing/mpc/") {
                    # serves "sub" specific fallback content
                    set req.url = "/subscription/resilient/mwcm/mcassets-sub.json";
                } else if (req.url ~ "^/subscription/ads/") {
                  set req.url = "/subscription/resilient/banner-ads.html";
                } else {
                    set req.url = "/subscription/resilient/index.html";
                }

                # https://docs.fastly.com/guides/integrations/amazon-s3
                set req.http.host = "s1-nyt-com.s3.amazonaws.com";
                set req.http.var-nyt-cmots-s3-fallback = "true";
            }

            # Set the backend to be S3 bucket
            # this route conists of the fallback content
            if (req.url ~ "^/subscription/resilient") {
                    set req.http.x-nyt-route = "mwcm-resilient";
                    set req.http.x-nyt-backend = "mwcm_resilient";
                    set req.http.host = "s1-nyt-com.s3.amazonaws.com";
                    set req.http.var-nyt-cmots-s3-fallback = "true";
            }

            # sets value of the header "req.http.var-nyt-ismagnolia" to "true|false"
            # req.http.var-nyt-ismagnolia = "true" when requests comes to magnolia cms in mwcm backend
            # default vaule is "false"
            set req.http.var-nyt-ismagnolia = "false";

            if (  req.http.var-nyt-cmots-s3-fallback != "true" &&
                    (   req.url == "/subscription" ||
                        req.url ~ "^/subscription(/|.html|\?)" ||
                        req.url ~ "^/marketing/(surveys|gdpr|moco|mpc|account)(/)?" ||
                        req.url ~ "^/initiative" ||
                        req.url ~ "^/payments"
                    )
                ) {
                set req.http.var-nyt-ismagnolia = "true";

                call shared_recv_cmots_headers_init;
                call shared_recv_cmots_miss_init;

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

sub fetch_route_mwcm {

     if (    beresp.status >= 500 && beresp.status < 600 &&
             req.http.x-nyt-route ~ "^mwcm"
        ) {

         # Deliver stale if the object is available
        if (stale.exists) {
            return(deliver_stale);
        }

        # handles 5XX retry logic at magnolia level
        # restarts the request
        # routes the request to s3 backend
        if (    req.restarts < 1 && req.url !~ "^/subscription/resilient" && (req.request == "GET" || req.request == "HEAD")
          ) {

            restart;
        }

        # handles 5XX retry logic at s3 level
        if (    req.restarts < 3 && req.url ~ "^/subscription/resilient" && (req.request == "GET" || req.request == "HEAD")
          ) {

            restart;
        }
    }
}

sub deliver_route_mwcm {

    if (    req.http.x-nyt-route ~ "^mwcm" ) {

        # Sets delivery headers
        # https://github.com/nytm/fastly-shared-cmots
        call shared_deliver_cmots_response_headers;

        if (req.http.x-nyt-nyhq-access == "1") {
            set resp.http.x-nyt-mwcm-fallback = req.http.x-nyt-mwcm-fallback;
        }

        # querystring appending logic applies to only mwcm route
        if (    req.http.x-nyt-route == "mwcm" &&
                (   resp.status == 301 ||
                    resp.status == 302
                )
            ) {

            if (resp.http.Location ~ "\?") {

                if (req.http.var-nyt-ismagnolia == "true") {

                    # handles duplicate qs params when redirected.
                    # repo: https://github.com/nytm/fastly-shared-cmots
                    call shared_recv_cmots_handle_redirect_regex_pattern;

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

        if (req.http.cookie:nyt-cmots) {
            #checks the presence of the nyt-cmots
            # allows nyt-cmots to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " nyt-cmots=" req.http.cookie:nyt-cmots ";";
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

        if (req.http.cookie:edu_opt) {
            #checks the presence of the edu_opt
            #temp fix using regsuball for encoding issues with edu_opt jkidd cookies
            # allows edu_opt to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " edu_opt=" regsuball(req.http.cookie:edu_opt, "\:", "%253A") ";";
        }

        if (req.http.cookie:b2b_opt) {
            #checks the presence of the b2b_opt
            #temp fix using regsuball for encoding issues with b2b_opt jkidd cookies
            # allows b2b_opt to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " b2b_opt=" regsuball(req.http.cookie:b2b_opt, "\:", "%253A") ";";
        }

        if (req.http.cookie:jkidd-t) {
            #checks the presence of the jkidd-t
            # allows jkidd-t to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " jkidd-t=" req.http.cookie:jkidd-t ";";
        }

        if (req.http.cookie:nyt-jkidd) {
            #checks the presence of the nyt-jkidd
            # allows nyt-jkidd to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " nyt-jkidd=" req.http.cookie:nyt-jkidd ";";
        }
    }
}

sub handle_error_fallback_route_mwcm {

    if (req.http.x-nyt-route ~ "^mwcm") {

        if ( req.url ~ "^/marketing/mpc/" || req.url ~ "^/subscription/resilient/mcassets" ) {
            # set messaging units error fallback page
            set obj.http.content-type = "application/json";
            call set_error_obj_headers;
            if (req.http.x-nyt-user-status != "sub") {
                # serves "non-sub"|"regi"|"anon" specific fallback content
                call render_mwcm_mu_fallback_nonsub;
            } else {
                # serves "sub" specific fallback content
                call render_mwcm_mu_fallback_sub;
            }

            return (deliver);
        } else if ( req.url ~ "^/subscription/ads" || req.url ~ "^/subscription/resilient/banner-ads" ) {
            # set banner ads error fallback page
            set obj.http.content-type = "text/html;charset=UTF-8";
            call set_error_obj_headers;
            call render_ads_fallback;

            return(deliver);
        } else {
            # set landing page error fallback page
            set obj.http.content-type = "text/html;charset=UTF-8";
            call set_error_obj_headers;
            call render_lp_fallback;

            return(deliver);
        }
    }
}

sub set_error_obj_headers {
    set obj.status = 200;
    set obj.response = "OK";
    set obj.http.cache-control = "no-cache, no-store, must-revalidate";
    set obj.http.x-nyt-route = "mwcm-error";
    set obj.http.surrogate-control= "max-age=1, stale-if-error=0, stale-while-revalidate=0";
}
