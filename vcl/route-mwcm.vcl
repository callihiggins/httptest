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
            set req.http.var-nyt-cmots-s3-fallback = "false";

            # routes to mwcm_resilient backend if req.restart greater than "0"
            # sets route as "mwcm-resilient"
            # sets backend as "mwcm_resilient"
            if ( req.restarts > 0) {
                set req.http.x-nyt-route = "mwcm-resilient";
                set req.http.x-nyt-backend = "mwcm_resilient";
                set req.http.x-nyt-mwcm-fallback = req.url;

                # NOTE: Supports html for the metered assets fallback, no consumers for now.
                if ( req.url ~ "^/marketing/mpc/" ) {
                    set req.url = "/subscription/resilient/mcassets.json";
                } else if (req.url ~ "^/subscription/ads/") {
                  set req.url = "/subscription/resilient/banner-ads.html";
                } else {
                    set req.url = "/subscription/resilient/index.html";
                }

                # https://docs.fastly.com/guides/integrations/amazon-s3
                set req.http.host = "s1-nyt-com.s3.amazonaws.com";
                set req.http.var-nyt-cmots-s3-fallback = "true";
            }

            if (    req.url !~ "^/marketing/(gdpr|moco|mpc|account)(/)?"  &&
                    req.url !~ "^/subscription/exo(/)?"
                ) {

                if (req.url == "/subscriptions" || req.url ~ "^/subscriptions/") {
                      # excludes query string parameters except "ptr"
                      set req.url = querystring.filter_except(req.url, "ptr");
                } else {
                  # excludes "exclude_optimizely", "exclude_jsonkidd", "exclude_abra" qs parameters
                    set req.url = querystring.regfilter_except(req.url, "(?i)^(exclude_optimizely|exclude_jsonkidd|exclude_abra|mwcmff|campaignId|skipFastly|promoStartDate|pre_prod|previewPersona|mgnlPreviewAsVisitor|preferredLocale|date-override|us|st)$");
                }
            } else {
                    set req.http.x-nyt-route = "mwcm-params";
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
                        req.url ~ "^/marketing/(surveys|gdpr|moco|mpc|account)(/)?"
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
            call render_mu_fallback;

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

sub render_ads_fallback {
    synthetic {"<!DOCTYPE html><html><head> <meta charset="utf-8"/> <title></title> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <style type="text/css" media="screen"> @charset "UTF-8";.site *{-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale}@font-face{font-family:cheltenham-normal-200;src:local("â˜ºï¸Ž"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-200.woff) format("woff"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-200.ttf) format("truetype");font-style:normal;font-weight:200}@font-face{font-family:cheltenham-normal-300;src:local("â˜ºï¸Ž"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-300.woff) format("woff"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-300.ttf) format("truetype");font-style:normal;font-weight:300}@font-face{font-family:cheltenham-normal-400;src:local("â˜ºï¸Ž"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-400.woff) format("woff"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-400.ttf) format("truetype");font-style:normal;font-weight:400}@font-face{font-family:cheltenham-normal-500;src:local("â˜ºï¸Ž"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-500.woff) format("woff"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-500.ttf) format("truetype");font-style:normal;font-weight:500}@font-face{font-family:cheltenham-normal-700;src:local("â˜ºï¸Ž"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-700.woff) format("woff"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-700.ttf) format("truetype");font-style:normal;font-weight:700}@font-face{font-family:cheltenham-normal-800;src:local("â˜ºï¸Ž"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-800.woff) format("woff"),url(https://g1.nyt.com/fonts/family/cheltenham/cheltenham-normal-800.ttf) format("truetype");font-style:normal;font-weight:800}@font-face{font-family:franklin-normal-500;src:local("☺︎"),url(https://g1.nyt.com/fonts/family/franklin/franklin-normal-500.woff) format("woff"),url(https://g1.nyt.com/fonts/family/franklin/franklin-normal-500.ttf) format("truetype");font-style:normal;font-weight:500}@font-face{font-family:franklin-normal-700;src:local("☺︎"),url(https://g1.nyt.com/fonts/family/franklin/franklin-normal-700.woff) format("woff"),url(https://g1.nyt.com/fonts/family/franklin/franklin-normal-700.ttf) format("truetype");font-style:normal;font-weight:700}@font-face{font-family:franklin-normal-800;src:local("☺︎"),url(https://g1.nyt.com/fonts/family/franklin/franklin-normal-800.woff2) format("woff2"),url(https://g1.nyt.com/fonts/family/franklin/franklin-normal-800.woff) format("woff"),url(https://g1.nyt.com/fonts/family/franklin/franklin-normal-800.ttf) format("truetype");font-style:normal;font-weight:800}@font-face{font-family:franklin-normal-900;src:local("☺︎"),url(https://g1.nyt.com/fonts/family/franklin/franklin-normal-900.woff2) format("woff2"),url(https://g1.nyt.com/fonts/family/franklin/franklin-normal-900.woff) format("woff"),url(https://g1.nyt.com/fonts/family/franklin/franklin-normal-900.ttf) format("truetype");font-style:normal;font-weight:900}@font-face{font-family:karnak-normal-400;src:local("☺︎"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-400.woff) format("woff"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-400.ttf) format("truetype");font-style:normal;font-weight:400}@font-face{font-family:karnak-normal-500;src:local("☺︎"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-500.woff2) format("woff2"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-500.woff) format("woff"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-500.ttf) format("truetype");font-style:normal;font-weight:500}@font-face{font-family:karnak-normal-600;src:local("☺︎"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-600.woff2) format("woff2"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-600.woff) format("woff"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-600.ttf) format("truetype");font-style:normal;font-weight:600}@font-face{font-family:karnak-normal-700;src:local("☺︎"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-700.woff2) format("woff2"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-700.woff) format("woff"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-700.ttf) format("truetype");font-style:normal;font-weight:700}@font-face{font-family:karnak-normal-900;src:local("☺︎"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-900.woff2) format("woff2"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-900.woff) format("woff"),url(https://g1.nyt.com/fonts/family/karnak/karnak-normal-900.ttf) format("truetype");font-style:normal;font-weight:900}p{margin:0}body{font-family:franklin-normal-500,sans-serif;height:270px;width:100%}.impression-tracker{display:none}a:link{text-decoration:none;color:#fff;min-height:1px}a:visited{color:#fff}#container{max-width:1605px;margin:0 auto;font-family:franklin-normal-500,sans-serif;-moz-osx-font-smoothing:grayscale;-webkit-font-smoothing:antialiased;background-color:#fff;border:1px solid #000}#container,#container .context-bullet-content{font-family:franklin-normal-500,sans-serif;-moz-osx-font-smoothing:grayscale;-webkit-font-smoothing:antialiased}#container .cta{border-radius:3px;border:2px solid #000;color:#fff;background-color:#000;text-transform:uppercase;font-family:franklin-normal-700,sans-serif;font-size:11px;padding:9px 13px 7px 13px;position:absolute;top:210px;left:550px}#flex-frame{position:relative;width:100%;height:270px;-webkit-box-sizing:border-box;box-sizing:border-box;background-size:cover;background-position:right;margin-left:auto;margin-right:auto}.content-container{width:970px;height:270px;float:none;position:relative;margin:0 auto}.content-container .logo{margin:0;position:absolute;z-index:0}.content-well{display:-webkit-box;display:-ms-flexbox;display:flex;width:100%;height:100%;-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between;position:absolute;top:0;left:0;z-index:0}.content-left-well{-ms-flex-item-align:start;align-self:flex-start;position:absolute;top:0;left:0}#container .title{font-family:karnak-normal-700,sans-serif;font-size:32px;line-height:33px;color:#000;display:block}#container .title-1{font-family:karnak-normal-700,sans-serif;font-size:32px;line-height:33px;color:#000;display:none}.logo .logo-std{display:block}.media-container{background-size:cover;background-position:center;width:100%;color:#fff;height:100%;position:relative;overflow:hidden;float:right;z-index:1}.media-content{position:absolute;z-index:0;bottom:auto;top:0;left:0}.media-image{display:block}@media (-webkit-min-device-pixel-ratio:2),(min-resolution:192dpi){.logo .logo-std{display:block}}@media only screen and (max-width:319px){#flex-frame{width:319px}.media-container{z-index:0;bottom:auto;display:block}.media-content{position:absolute;z-index:0;bottom:auto;left:0;top:0;display:block}.media-image{position:absolute;left:45px;top:120px;-webkit-transform-origin:bottom left;transform-origin:bottom left;-webkit-transform:scale(.75);transform:scale(.75)}.content-container{width:319px}.content-well{display:-webkit-box;display:-ms-flexbox;display:flex;width:100%;height:100%;position:absolute;left:0;height:0}#container .title{display:none}#container .title-1{position:absolute;font-size:32px;line-height:32px;top:50px;left:45px;width:500px;display:block}#container .cta{position:absolute;top:180px;left:45px}}@media only screen and (min-width:320px) and (max-width:479px){#flex-frame{width:320px}.media-container{z-index:0;bottom:auto;display:block}.media-content{position:absolute;z-index:0;bottom:auto;left:0;top:0;display:block}.media-image{position:absolute;left:45px;top:120px;-webkit-transform-origin:bottom left;transform-origin:bottom left;-webkit-transform:scale(.75);transform:scale(.75)}.content-container{width:320px}.content-well{display:-webkit-box;display:-ms-flexbox;display:flex;width:100%;height:100%;position:absolute;left:0;height:0}#container .title{display:none}#container .title-1{position:absolute;font-size:32px;line-height:32px;top:50px;left:45px;width:500px;display:block}#container .cta{position:absolute;top:180px;left:45px}}@media only screen and (min-width:480px) and (max-width:739px){#flex-frame{width:480px}.media-container{z-index:0;bottom:auto;display:block}.media-content{position:absolute;z-index:0;bottom:auto;left:0;top:0;display:block}.media-image{position:absolute;left:45px;top:95px}.content-container{width:480px}.content-well{display:-webkit-box;display:-ms-flexbox;display:flex;width:100%;height:100%;position:absolute;left:0;height:0}#container .title{position:absolute;font-size:32px;line-height:32px;top:50px;left:45px;width:500px}#container .cta{position:absolute;top:180px;left:45px}}@media only screen and (min-width:740px) and (max-width:974px){#flex-frame{width:740px}.media-container{z-index:0;bottom:auto;display:block}.media-content{position:absolute;z-index:0;bottom:auto;left:0;top:0;display:block}.media-image{position:absolute;left:45px;top:135px}.content-container{width:740px}.content-well{display:-webkit-box;display:-ms-flexbox;display:flex;width:100%;height:100%;position:absolute;left:0;height:0}#container .title{position:absolute;font-size:32px;line-height:32px;top:90px;left:45px;width:500px}#container .cta{position:absolute;top:90px;left:590px}}@media only screen and (min-width:975px) and (max-width:1605px){#flex-frame{width:970px}.media-container{z-index:0;bottom:auto;display:block}.media-content{position:absolute;z-index:0;bottom:auto;left:0;top:0;display:block}.media-image{position:absolute;left:45px;top:135px}.content-container{width:970px}.content-well{display:-webkit-box;display:-ms-flexbox;display:flex;width:100%;height:100%;position:absolute;left:0;height:0}#container .title{position:absolute;font-size:32px;line-height:32px;top:90px;left:45px;width:500px}#container .cta{position:absolute;top:90px;left:790px}}@media only screen and (min-width:1606px){#flex-frame{width:970px}.media-container{z-index:0;bottom:auto;display:block}.media-content{position:absolute;z-index:0;bottom:auto;left:0;top:0;display:block}.media-image{position:absolute;left:45px;top:135px}.content-container{width:970px}.content-well{display:-webkit-box;display:-ms-flexbox;display:flex;width:100%;height:100%;position:absolute;left:0;height:0}#container .title{position:absolute;font-size:32px;line-height:32px;top:90px;left:45px;width:500px}#container .cta{position:absolute;top:90px;left:790px}}</style> <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/gsap/1.19.1/TimelineMax.min.js'></script> <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/gsap/1.19.1/TweenMax.min.js'></script></head><body topmargin="0" marginwidth="0" marginheight="0" leftmargin="0"> <a target="_blank" href="%%CLICK_URL_ESC%%%%DEST_URL%%"> <div id="container"> <div id="flex-frame"> <div class="media-container"> <div class="media-content"> <img class="media-image" width="210px" src="https://www.nytimes.com/subscription/resilient/nyt-logo-for-adds.svg"/> </div></div><div class="content-container"> <div class="content-well"> <div class="content-left-well"> <div class="title" id="t1"> The truth is worth it. </div></div><div class="content-left-well"> <div class="title-1" id="t1"> The truth is<br>worth it. </div></div></div><div class="cta">SEE THE STORIES</div></div></div></div></a></body></html>"};
}

 sub render_mu_fallback {
    synthetic {"{"welcomeAd":{"active":true,"status":"active","campaignName":"go_to_optimizely","html":"\n\n\n","content":{"frequencyCap":{"frequencyCapEnabled":false}}},"barOne":{"active":true,"status":"active","campaignName":"go_to_optimizely","html":"\n\n\n","content":{"frequencyCap":{"frequencyCapEnabled":false}}},"mobileTruncator":{"active":true,"html":"\n\n\n","js":null,"css":null,"assets":null,"fields":{"copy1":"We're unable to process the payment for your subscription.","copy2":"Please update your information so that your New York Times subscription won't be canceled.","cta":"Update payment information now","locationLink":"https://myaccount.nytimes.com/"}{"""}{"}"}{","targetingInfo":null,"campaignName":"go_to_optimizely"}{"""}{"}"}{","truncator":{"active":true,"status":"active","campaignName":"go_to_optimizely","html":"\n\n\n","content":{"frequencyCap":{"frequencyCapEnabled":false}}},"dock":{"active":true,"status":"active","campaignName":"go_to_optimizely","html":"\n\n\n","content":{"frequencyCap":{"frequencyCapEnabled":false}}},"inlineUnit":{"active":true,"status":"active","campaignName":"go_to_optimizely","html":"\n\n\n","content":{"frequencyCap":{"frequencyCapEnabled":false}}},"gateway":{"active":true,"status":"active","campaignName":"go_to_optimizely","html":"\n\n\n\n\n\n\n\n\n\n <iframe style=\"position:absolute;\" height=\"100%\" width=\"100%\" src=\"/subscription/resilient/mcassets-gateway.html\"></iframe>\n","content":{"gatewayLink":"/subscription/resilient/mcassets-gateway.html","frequencyCap":{"frequencyCapEnabled":false}}}}"};
}

sub render_lp_fallback {
    synthetic {"<!DOCTYPE html><html lang="en"> <head> <title>The New York Times</title> <meta content="" http-equiv="Content-Type"> <meta content="width=device-width, initial-scale=1.0" name="viewport"> <link rel="stylesheet" href="https://a1.nyt.com/fonts/css/fonts.css" type="text/css"/> <style type="text/css"> .font-smoothing{-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale}.noLineBreak{display:inline-block}.hidden{display:none;visibility:hidden}@media (min-width:544px){.hidden-xs{display:none}}@media (min-width:768px){.hidden-sm,.hidden-sm-up{display:none}}@media (min-width:992px){.hidden-md{display:none}}@media (min-width:1200px){.hidden-lg{display:none}}@media (max-width:543px){.hidden-xs-down{display:none}}@media (max-width:767px){.hidden-sm-down{display:none}}@media (max-width:991px){.hidden-md-down{display:none}}@media (max-width:1199px){.hidden-lg-down{display:none}}.together{display:inline-block}img{display:block}.prepend-asterisk,.prepend-asterisk-double,.prepend-plus,.prepend-plus-double{position:relative}.prepend-asterisk-double:before,.prepend-asterisk:before,.prepend-plus-double:before,.prepend-plus:before{position:absolute;padding-top:.2em;height:1em}.prepend-asterisk:before,.prepend-plus:before{content:"*";left:-1em;left:-1.5ch;width:1em;width:1ch}.prepend-asterisk-double:before,.prepend-plus-double:before{position:absolute;content:"**";left:-2em;left:-2.5ch;width:2em;width:2ch}.prepend-plus:before{content:"+";padding-top:0}.prepend-plus-double:before{content:"++";padding-top:0}.prepend-plus-double:before,.prepend-plus:before{margin-top:-1px}.bypass .hidden-bypass,body:not(.bypass) .hidden-non-bypass{display:none}.striker,.strikethrough{position:relative;color:rgba(255,255,255,.5)}.striker:before,.strikethrough:before{position:absolute;width:100%;height:1px;background-color:rgba(255,255,255,.5);content:"";bottom:39%}*{-webkit-box-sizing:border-box;box-sizing:border-box}html{-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;-webkit-text-size-adjust:100%}body{margin:0;color:#000}body>iframe,body>img{display:none;height:0}.wrapper{position:relative}.section,.wrapper{width:100%;height:auto}.section{overflow:hidden;background-color:#fff}.section .container{width:100%;height:auto;max-width:914px;margin:0 auto;overflow:hidden}.section .container.wide-container{max-width:100%}.section .row{height:auto}.section .column,.section .row{width:100%;float:left}@media (min-width:768px){.section .column{width:50%}}.section .rule-element:after{content:"";width:100%;bottom:0;background-color:#000}.section .rule-element{position:relative}.section .rule-element:after{bottom:-16px;left:0;right:0;height:1px;width:60px;margin:0 auto;position:absolute;background-color:#333}.section .strike-through{position:relative}.section .strike-through:after{bottom:40%;left:0;height:1px;width:100%;position:absolute;background-color:#000;content:""}{"""}{"}"}{".main-content{padding:24px 0 32px}@media (min-width:768px){.main-content{padding:80px 50px 148px}}.main-content .offer__column{padding:0 20px 16px}@media (min-width:768px){.main-content .offer__column{padding:24px 20px 0 0}}@media (min-width:992px){.main-content .offer__column{width:65%;padding:24px 90px 0 0}}.main-content .offer__column .logo-holder{width:100%;height:auto;margin:0 auto 24px}.main-content .offer__column .logo-holder .nyt-logo{width:100%;max-width:171px;margin:0 auto;display:block}@media (min-width:768px){.main-content .offer__column .logo-holder .nyt-logo{max-width:227px;margin:0}}.main-content .offer__column .logo-holder .nyt-logo svg{width:171px;height:24px}@media (min-width:768px){.main-content .offer__column .logo-holder .nyt-logo svg{width:227px;height:32px}}.main-content .offer__column .offer-holder{width:100%;height:auto;margin:0 auto}.main-content .offer__column .offer-holder__offer{margin:0 auto 16px;font-family:cheltenham,nyt-cheltenham,georgia,times new roman,times,serif;font-size:20px;line-height:1.2;text-align:center;max-width:280px;font-weight:500}@media (min-width:768px){.main-content .offer__column .offer-holder__offer{font-size:22px;max-width:100%;text-align:left;margin:0 auto 56px}}@media (min-width:992px){.main-content .offer__column .offer-holder__offer{font-size:32px}}.main-content .offer__column .offer-holder__offer.rule-element:after{bottom:-32px;margin:0;left:0;width:40px;background-color:#333;display:none}@media (min-width:768px){.main-content .offer__column .offer-holder__offer.rule-element:after{display:block}}.main-content .offer__column .offer-holder__text{margin:0 auto;font-family:franklin,nyt-franklin,Helvetica Neue,Arial,sans-serif;font-size:12px;line-height:1.4;text-align:center}@media (min-width:768px){.main-content .offer__column .offer-holder__text{font-size:14px;text-align:left}}@media (min-width:992px){.main-content .offer__column .offer-holder__text{font-size:18px}}@media (min-width:768px){.main-content .bundle__column{width:50%;max-width:324px;float:right}}@media (min-width:992px){.main-content .bundle__column{width:35%}}.main-content .bundle__column .bundle-holder{width:100%;height:auto}.main-content .bundle__column .bundle-holder .bundle{width:100%;height:auto;max-width:414px;border:2px solid #6288a5;border-top:8px solid #6288a5;margin:0 auto 24px;padding:0 20px}@media (min-width:768px){.main-content .bundle__column .bundle-holder .bundle{max-width:324px}}.main-content .bundle__column .bundle-holder .bundle .bundle__header{width:100%;height:auto;padding:24px 0 16px;border-bottom:1px solid #dedede}.main-content .bundle__column .bundle-holder .bundle .bundle__header__name{font-family:cheltenham,nyt-cheltenham,georgia,times new roman,times,serif;font-size:22px;line-height:1;text-align:center;font-weight:500;margin:0 auto 32px;color:#000}.main-content .bundle__column .bundle-holder .bundle .bundle__header__name.rule-element{position:relative}.main-content .bundle__column .bundle-holder .bundle .bundle__header__name.rule-element:after{bottom:-16px;left:0;right:0;height:1px;width:60px;margin:0 auto;position:absolute;background-color:#333}.main-content .bundle__column .bundle-holder .bundle .bundle__header__offer{margin:0 auto;font-family:franklin,nyt-franklin,Helvetica Neue,Arial,sans-serif;font-size:16px;line-height:1.1;text-align:center;color:#000}.main-content .bundle__column .bundle-holder .bundle .bundle__header__offer .strike-through:after{transform:rotate(-14deg);background-color:#d31e25;-webkit-transform:rotate(-14deg);-moz-transform:rotate(-14deg);-ms-transform:rotate(-14deg);-o-transform:rotate(-14deg);bottom:54%}.main-content .bundle__column .bundle-holder .bundle .detail-switch-holder{width:100%;height:auto;padding:24px 0;text-align:center}@media (min-width:768px){.main-content .bundle__column .bundle-holder .bundle .detail-switch-holder{display:none}}.main-content .bundle__column .bundle-holder .bundle .detail-switch-holder .detail-switch{display:inline-block;margin:0 auto;font-family:franklin,nyt-franklin,Helvetica Neue,Arial,sans-serif;font-size:14px;line-height:1.1;text-align:center;color:#444;text-decoration:none;font-weight:500}.main-content .bundle__column .bundle-holder .bundle .detail-switch-holder .detail-switch__icon{display:inline-block;width:14px;height:9px}.main-content .bundle__column .bundle-holder .bundle .detail-switch-holder .detail-switch__icon.upcaret{position:relative;top:3px}.main-content .bundle__column .bundle-holder .bundle .bundle__detail{width:100%;height:auto;padding:0 30px;display:none}@media (min-width:768px){.main-content .bundle__column .bundle-holder .bundle .bundle__detail{display:block!important;padding:23px 38px 0}}.main-content .bundle__column .bundle-holder .bundle .bundle__detail__feature{margin:0 0 24px;text-align:left;font-family:franklin,nyt-franklin,Helvetica Neue,Arial,sans-serif;font-size:14px;line-height:1.4;position:relative}.main-content .bundle__column .bundle-holder .bundle .bundle__detail__feature__check{position:absolute;left:-23px;top:0;display:none}@media (min-width:768px){.main-content .bundle__column .bundle-holder .bundle .bundle__detail__feature__check{display:block}}.main-content .bundle__column .bundle-holder .bundle__cta-holder{width:100%;height:auto;padding:0 20px}.main-content .bundle__column .bundle-holder .bundle__cta-holder__cta{display:block;height:42px;width:100%;max-width:284px;background-color:#ebebeb;border-radius:3px;-webkit-border-radius:3px;-moz-border-radius:3px;-ms-border-radius:3px;-o-border-radius:3px;color:#333;font-family:franklin,nyt-franklin,Helvetica Neue,Arial,sans-serif;font-size:15px;line-height:1.2;text-align:center;font-weight:500;margin:0 auto 10px;padding:12px 0;text-decoration:none}.main-content .bundle__column .bundle-holder .bundle__cta-holder__cta:last-child{margin:0 auto}.main-content .bundle__column .bundle-holder .bundle__cta-holder__cta.subscribe-cta{background-color:#4d7b9f;color:#fff}.footer{padding:0 20px}@media (min-width:768px){.footer{padding:0 50px}}.footer .container{border-top:1px solid #e2e2e2;padding:16px 0}.footer .footer-links{width:100%;height:auto;text-align:center;max-width:200px;margin:0 auto}@media (min-width:768px){.footer .footer-links{text-align:left;max-width:100%}}.footer .footer-links .footer-link{color:#6288a5;font-size:12px;line-height:1.6;text-align:center;font-weight:600;text-decoration:none;margin:0 5%;font-family:franklin,nyt-franklin,Helvetica Neue,Arial,sans-serif}@media (min-width:768px){.footer .footer-links .footer-link{margin:0 1%}}.footer .footer-links .footer-link.company-link{color:#666;display:inline-block;margin:0}</style> <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> <script type="text/javascript">window.addEventListener('load', function (){window.setTimeout(function (){var script=document.createElement('script'); //script.src='https://a1.nyt.com/analytics/json-kidd.min.js'; script.src='https://a1.nyt.com/analytics/json-kidd-no-ender.min.js'; script.async=true; document.head.appendChild(script);}, 500);}); </script> </head> <body> <div class="wrapper"> <section class="section main-content"> <div class="container"> <div class="row"> <div class="column offer__column"> <div class="logo-holder"> <a href="https://www.nytimes.com/" class="nyt-logo"> <svg class="" viewBox="0 0 184 25" fill="#000"> <path d="M13.8 2.9c0-2-1.9-2.5-3.4-2.5v.3c.9 0 1.6.3 1.6 1 0 .4-.3 1-1.2 1-.7 0-2.2-.4-3.3-.8C6.2 1.4 5 1 4 1 2 1 .6 2.5.6 4.2c0 1.5 1.1 2 1.5 2.2l.1-.2c-.2-.2-.5-.4-.5-1 0-.4.4-1.1 1.4-1.1.9 0 2.1.4 3.7.9 1.4.4 2.9.7 3.7.8v3.1L9 10.2v.1l1.5 1.3v4.3c-.8.5-1.7.6-2.5.6-1.5 0-2.8-.4-3.9-1.6l4.1-2V6l-5 2.2C3.6 6.9 4.7 6 5.8 5.4l-.1-.3c-3 .8-5.7 3.6-5.7 7 0 4 3.3 7 7 7 4 0 6.6-3.2 6.6-6.5h-.2c-.6 1.3-1.5 2.5-2.6 3.1v-4.1l1.6-1.3v-.1l-1.6-1.3V5.8c1.5 0 3-1 3-2.9zm-8.7 11l-1.2.6c-.7-.9-1.1-2.1-1.1-3.8 0-.7 0-1.5.2-2.1l2.1-.9v6.2zm10.6 2.3l-1.3 1 .2.2.6-.5 2.2 2 3-2-.1-.2-.8.5-1-1V9.4l.8-.6 1.7 1.4v6.1c0 3.8-.8 4.4-2.5 5v.3c2.8.1 5.4-.8 5.4-5.7V9.3l.9-.7-.2-.2-.8.6-2.5-2.1L18.5 9V.8h-.2l-3.5 2.4v.2c.4.2 1 .4 1 1.5l-.1 11.3zM34 15.1L31.5 17 29 15v-1.2l4.7-3.2v-.1l-2.4-3.6-5.2 2.8v6.6l-1 .8.2.2.9-.7 3.4 2.5 4.5-3.6-.1-.4zm-5-1.7V8.5l.2-.1 2.2 3.5-2.4 1.5zM53.1 2c0-.3-.1-.6-.2-.9h-.2c-.3.8-.7 1.2-1.7 1.2-.9 0-1.5-.5-1.9-.9l-2.9 3.3.2.2 1-.9c.6.5 1.1.9 2.5 1v8.3L44 3.2c-.5-.8-1.2-1.9-2.6-1.9-1.6 0-3 1.4-2.8 3.6h.3c.1-.6.4-1.3 1.1-1.3.5 0 1 .5 1.3 1v3.3c-1.8 0-3 .8-3 2.3 0 .8.4 2 1.6 2.3v-.2c-.2-.2-.3-.4-.3-.7 0-.5.4-.9 1.1-.9h.5v4.2c-2.1 0-3.8 1.2-3.8 3.2 0 1.9 1.6 2.8 3.4 2.7v-.2c-1.1-.1-1.6-.6-1.6-1.3 0-.9.6-1.3 1.4-1.3.8 0 1.5.5 2 1.1l2.9-3.2-.2-.2-.7.8c-1.1-1-1.7-1.3-3-1.5V5l8 14h.6V5c1.5-.1 2.9-1.3 2.9-3zm7.3 13.1L57.9 17l-2.5-2v-1.2l4.7-3.2v-.1l-2.4-3.6-5.2 2.8v6.6l-1 .8.2.2.9-.7 3.4 2.5 4.5-3.6-.1-.4zm-5-1.7V8.5l.2-.1 2.2 3.5-2.4 1.5zM76.7 8l-.7.5-1.9-1.6-2.2 2 .9.9v7.5l-2.4-1.5V9.6l.8-.5-2.3-2.2-2.2 2 .9.9V17l-.3.2-2.1-1.5v-6c0-1.4-.7-1.8-1.5-2.3-.7-.5-1.1-.8-1.1-1.5 0-.6.6-.9.9-1.1v-.2c-.8 0-2.9.8-2.9 2.7 0 1 .5 1.4 1 1.9s1 .9 1 1.8v5.8l-1.1.8.2.2 1-.8 2.3 2 2.5-1.7 2.8 1.7 5.3-3.1V9.2l1.3-1-.2-.2zm18.6-5.5l-1 .9-2.2-2-3.3 2.4V1.6h-.3l.1 16.2c-.3 0-1.2-.2-1.9-.4l-.2-13.5c0-1-.7-2.4-2.5-2.4s-3 1.4-3 2.8h.3c.1-.6.4-1.1 1-1.1s1.1.4 1.1 1.7v3.9c-1.8.1-2.9 1.1-2.9 2.4 0 .8.4 2 1.6 2V13c-.4-.2-.5-.5-.5-.7 0-.6.5-.8 1.3-.8h.4v6.2c-1.5.5-2.1 1.6-2.1 2.8 0 1.7 1.3 2.9 3.3 2.9 1.4 0 2.6-.2 3.8-.5 1-.2 2.3-.5 2.9-.5.8 0 1.1.4 1.1.9 0 .7-.3 1-.7 1.1v.2c1.6-.3 2.6-1.3 2.6-2.8s-1.5-2.4-3.1-2.4c-.8 0-2.5.3-3.7.5-1.4.3-2.8.5-3.2.5-.7 0-1.5-.3-1.5-1.3 0-.8.7-1.5 2.4-1.5.9 0 2 .1 3.1.4 1.2.3 2.3.6 3.3.6 1.5 0 2.8-.5 2.8-2.6V3.7l1.2-1-.2-.2zm-4.1 6.1c-.3.3-.7.6-1.2.6s-1-.3-1.2-.6V4.2l1-.7 1.4 1.3v3.8zm0 3c-.2-.2-.7-.5-1.2-.5s-1 .3-1.2.5V9c.2.2.7.5 1.2.5s1-.3 1.2-.5v2.6zm0 4.7c0 .8-.5 1.6-1.6 1.6h-.8V12c.2-.2.7-.5 1.2-.5s.9.3 1.2.5v4.3zm13.7-7.1l-3.2-2.3-4.9 2.8v6.5l-1 .8.1.2.8-.6 3.2 2.4 5-3V9.2zm-5.4 6.3V8.3l2.5 1.8v7.1l-2.5-1.7zm14.9-8.4h-.2c-.3.2-.6.4-.9.4-.4 0-.9-.2-1.1-.5h-.2l-1.7 1.9-1.7-1.9-3 2 .1.2.8-.5 1 1.1v6.3l-1.3 1 .2.2.6-.5 2.4 2 3.1-2.1-.1-.2-.9.5-1.2-1V9c.5.5 1.1 1 1.8 1 1.4.1 2.2-1.3 2.3-2.9zm12 9.6L123 19l-4.6-7 3.3-5.1h.2c.4.4 1 .8 1.7.8s1.2-.4 1.5-.8h.2c-.1 2-1.5 3.2-2.5 3.2s-1.5-.5-2.1-.8l-.3.5 5 7.4 1-.6v.1zm-11-.5l-1.3 1 .2.2.6-.5 2.2 2 3-2-.2-.2-.8.5-1-1V.8h-.1l-3.6 2.4v.2c.4.2 1 .3 1 1.5v11.3zM143 2.9c0-2-1.9-2.5-3.4-2.5v.3c.9 0 1.6.3 1.6 1 0 .4-.3 1-1.2 1-.7 0-2.2-.4-3.3-.8-1.3-.4-2.5-.8-3.5-.8-2 0-3.4 1.5-3.4 3.2 0 1.5 1.1 2 1.5 2.2l.1-.2c-.3-.2-.6-.4-.6-1 0-.4.4-1.1 1.4-1.1.9 0 2.1.4 3.7.9 1.4.4 2.9.7 3.7.8V9l-1.5 1.3v.1l1.5 1.3V16c-.8.5-1.7.6-2.5.6-1.5 0-2.8-.4-3.9-1.6l4.1-2V6l-5 2.2c.5-1.3 1.6-2.2 2.6-2.9l-.1-.2c-3 .8-5.7 3.5-5.7 6.9 0 4 3.3 7 7 7 4 0 6.6-3.2 6.6-6.5h-.2c-.6 1.3-1.5 2.5-2.6 3.1v-4.1l1.6-1.3v-.1L140 8.8v-3c1.5 0 3-1 3-2.9zm-8.7 11l-1.2.6c-.7-.9-1.1-2.1-1.1-3.8 0-.7.1-1.5.3-2.1l2.1-.9-.1 6.2zm12.2-12h-.1l-2 1.7v.1l1.7 1.9h.2l2-1.7v-.1l-1.8-1.9zm3 14.8l-.8.5-1-1V9.3l1-.7-.2-.2-.7.6-1.8-2.1-2.9 2 .2.3.7-.5.9 1.1v6.5l-1.3 1 .1.2.7-.5 2.2 2 3-2-.1-.3zm16.7-.1l-.7.5-1.1-1V9.3l1-.8-.2-.2-.8.7-2.3-2.1-3 2.1-2.3-2.1L154 9l-1.8-2.1-2.9 2 .1.3.7-.5 1 1.1v6.5l-.8.8 2.3 1.9 2.2-2-.9-.9V9.3l.9-.6 1.5 1.4v6l-.8.8 2.3 1.9 2.2-2-.9-.9V9.3l.8-.5 1.6 1.4v6l-.7.7 2.3 2.1 3.1-2.1v-.3zm8.7-1.5l-2.5 1.9-2.5-2v-1.2l4.7-3.2v-.1l-2.4-3.6-5.2 2.8v6.8l3.5 2.5 4.5-3.6-.1-.3zm-5-1.7V8.5l.2-.1 2.2 3.5-2.4 1.5zm14.1-.9l-1.9-1.5c1.3-1.1 1.8-2.6 1.8-3.6v-.6h-.2c-.2.5-.6 1-1.4 1-.8 0-1.3-.4-1.8-1L176 9.3v3.6l1.7 1.3c-1.7 1.5-2 2.5-2 3.3 0 1 .5 1.7 1.3 2l.1-.2c-.2-.2-.4-.3-.4-.8 0-.3.4-.8 1.2-.8 1 0 1.6.7 1.9 1l4.3-2.6v-3.6h-.1zm-1.1-3c-.7 1.2-2.2 2.4-3.1 3l-1.1-.9V8.1c.4 1 1.5 1.8 2.6 1.8.7 0 1.1-.1 1.6-.4zm-1.7 8c-.5-1.1-1.7-1.9-2.9-1.9-.3 0-1.1 0-1.9.5.5-.8 1.8-2.2 3.5-3.2l1.2 1 .1 3.6z"></path> </svg> </a> </div><div class="offer-holder"> <h1 class="offer-holder__offer rule-element">Subscribe now and get <span class="noLineBreak">The New York Times</span> for <span class="sale-price">$2</span> a week for your first year.</h1> <p class="offer-holder__text"> <strong>You can cancel at any time.</strong> </p></div></div><div class="column bundle__column"> <div class="bundle-holder"> <div class="bundle"> <header class="bundle__header"> <h3 class="bundle__header__name rule-element">Basic Subscription</h3> <p class="bundle__header__offer"> <span class="regular-price strike-through">$3.75</span> <strong><span class="sale-price">$2</span>/week</strong> for one year. </p></header> <div class="detail-switch-holder"> <a href="javascript:void(0)" class="detail-switch"> <span class="detail-switch__text">What&rsquo;s included</span> <i class="detail-switch__icon caret"> <svg width="14" height="9" viewBox="0 0 14 9" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M2.0275 0L7 4.96167L11.9725 0L13.5 1.5275L7 8.0275L0.5 1.5275L2.0275 0Z" fill="#444444"/> </svg> </i> </a> </div><div class="bundle__detail"> <p class="bundle__detail__feature"> <i class="bundle__detail__feature__check"> <svg width="12" height="11" viewBox="0 0 12 11" fill="none" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" clip-rule="evenodd" d="M2.12048 9.12134L-0.000854492 7L1.41333 5.58569L3.53467 7.70703L10.6057 0.635986L12.02 2.05029L4.94885 9.12134L3.53467 10.5356L2.12048 9.12134Z" fill="#333333"/> </svg> </i> <strong>Unlimited articles</strong> on NYTimes.com and in the NYT app </p><p class="bundle__detail__feature"> <i class="bundle__detail__feature__check"> <svg width="12" height="11" viewBox="0 0 12 11" fill="none" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" clip-rule="evenodd" d="M2.12048 9.12134L-0.000854492 7L1.41333 5.58569L3.53467 7.70703L10.6057 0.635986L12.02 2.05029L4.94885 9.12134L3.53467 10.5356L2.12048 9.12134Z" fill="#333333"/> </svg> </i> <strong>Early access to</strong> content and subscriber exclusives </p></div></div><div class="bundle__cta-holder"> <a href="https://myaccount.nytimes.com/get-started?OC=20000189620&campaignId=7HFJL" class="bundle__cta-holder__cta subscribe-cta needsParam">Subscribe Now</a> <a href="https://www.nytimes.com/get-started" class="bundle__cta-holder__cta non-subscribe-cta needsParam">Continue Without Subscribing</a> </div></div></div></div></div></section> <footer class="footer section"> <div class="container"> <div class="footer-links"> <a href="https://www.nytco.com/" class="footer-link company-link" target="_blank">&copy; <span class="current-year">2019</span> The New York Times Company</a> <a href="https://help.nytimes.com/hc/en-us" class="footer-link" target="_blank">Help</a> <a href="https://help.nytimes.com/hc/en-us/articles/115015385887-Contact-Us?redir=myacc" class="footer-link" target="_blank">Feedback</a> </div></div></footer> </div></body></html>"};
}
