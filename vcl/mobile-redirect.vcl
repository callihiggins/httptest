sub recv_mobile_redirect_capture_qparam {
    # edge will send this header to the shield, don't capture this if we're a shield
    if (!req.http.x-nyt-shield-auth && req.http.x-nyt-orig-querystring ~ "nytmobile=") {
        set req.http.var-nyt-mobile-param = regsub(req.http.x-nyt-orig-querystring, ".*?.*(nytmobile=.).*", "\1");
    }
}

sub deliver_mobile_redirect {

    # only redirect to mobile on an edge pop
    if (!req.http.x-nyt-shield-auth) {
        if (resp.status != 301 && resp.status != 303) {
            set req.http.x-do-mobile-redirect = "0";

            // mobile device detection
            if (req.http.device_type == "smartphone" || req.http.device_type == "phone") {
                set req.http.x-do-mobile-redirect = "1";
            }

            if (req.http.x-nyt-route ~ "^blog") {
                // query string override
                if (req.http.var-nyt-mobile-param ~ "nytmobile=1") {
                    set req.http.x-do-mobile-redirect = "1";
                }
                if (req.http.var-nyt-mobile-param ~ "nytmobile=0") {
                    set req.http.x-do-mobile-redirect = "0";
                }

                // cookie override
                if (req.http.var-cookie-nyt-mobile == "0") {
                    set req.http.x-do-mobile-redirect = "0";
                }
                if (req.http.var-cookie-nyt-mobile == "1") {
                    set req.http.x-do-mobile-redirect = "1";
                }

                // whitelist of blog hostnames that do redirect
                // disable redirect if failed match
                if (   req.http.host !~ "^(6thfloor|afterdeadline|artsbeat|atwar|bits|bittman|boss|brooks|bruni|bucks|carpetbagger|cityroom|dealbook|dotearth|douthat|economix|firstlook|india|intransit|keller|kristof|krugman|latitude|learning|lens|newoldage|news|nocera|opinionator|parenting|publiceditor|runway|sinosphere|sports|takingnote|thecaucus|thelede|tmagazine|well|wordplay)(\.blogs|\.blogs5|)\."
                    && req.http.host != "www.nytimes.com"
                ) {
                    set req.http.x-do-mobile-redirect = "0";
                }

                // URLs for PageType blog-legacy never redirect
                if ( req.http.x-nyt-route == "blog-legacy") {
                    set req.http.x-do-mobile-redirect = "0";
                }

                // do not redirect for years older than 2012
                if (   req.url !~ "^/$"
                    && req.url !~ "^/\?"
                    && req.url !~ "^/20[1-9][2-9]/"
                    && req.url !~ "^/times-insider/20[1-9][2-9]/"
                ) {
                    set req.http.x-do-mobile-redirect = "0";
                }

                // do not redirect day-archive pages
                // WP-7178: URLs exist with only single-digit month and/or day
                set req.http.x-request-uri = regsub(req.url, "\?.*", "");
                if (   req.http.x-request-uri ~ "^/(19|20)[0-9][0-9]/[0-9][0-9]/[0-9][0-9]/?$"
                    || req.http.x-request-uri ~ "^/(19|20)[0-9][0-9]/[0-9]/[0-9][0-9]/?$"
                    || req.http.x-request-uri ~ "^/(19|20)[0-9][0-9]/[0-9][0-9]/[0-9]/?$"
                    || req.http.x-request-uri ~ "^/(19|20)[0-9][0-9]/[0-9]/[0-9]/?$"
                ) {
                    set req.http.x-do-mobile-redirect = "0";
                }

                if (req.http.x-do-mobile-redirect == "1") {
                    call do_redirect;
                }
            } else {
                // query string override
                if (req.http.var-nyt-mobile-param ~ "nytmobile=1") {
                    set req.http.x-do-mobile-redirect = "1";
                }
                if (req.http.var-nyt-mobile-param ~ "nytmobile=0") {
                    set req.http.x-do-mobile-redirect = "0";
                }
                // homepage & sectionfronts specific logic
                if (req.http.x-nyt-route == "homepage" || req.http.x-nyt-route == "vi-homepage") {
                    // cookie override
                    if (req.http.var-cookie-nyt-mobile == "0") {
                        set req.http.x-do-mobile-redirect = "0";
                    }
                    if (req.http.var-cookie-nyt-mobile == "1") {
                        set req.http.x-do-mobile-redirect = "1";
                    }
                }
                // interactive & service specific logic
                if (req.url ~ "^/interactive/" || req.url ~ "^/svc/") {
                    set req.http.x-do-mobile-redirect = "0";
                }

                //do not redirect Watching section; WP-19158
                if (req.url ~ "^\/\d{4}\/\d{2}\/\d{2}\/watching\/") {
                  set req.http.x-do-mobile-redirect = "0";
                }

                // do not redirect Timeswire to mobile domain
                if (req.url ~ "^/timeswire(\/?)$") {
                  set req.http.x-do-mobile-redirect = "0";
                }


                // FOR MOBILE SHUTDOWN
                // Exceptions for urls now supported by www
                if (req.http.x-nyt-route == "amp") {
                  set req.http.x-do-mobile-redirect = "0";
                }

                if (req.http.x-do-mobile-redirect == "1") {
                    if (   req.url ~ "^/$"
                        || req.url ~ "^/index.html"
                        || req.url ~ "^/19((5|7)[0-9]|9[6-9])/"
                        || req.url ~ "^/2[0-9][0-9][0-9]/"
                        || req.url ~ "^/(aponline|reuters)/20([0-9][7-9]|[1-9][0-9])/"
                        || req.url ~ "^/pages/"
                        || req.url ~ "^/(recommendations)"
                        || req.url ~ "^/best-sellers-books/overview.html"
                        || req.url ~ "^/interactive/blogs/directory.html"
                        || req.url ~ "^/most-popular-emailed"
                        || req.url ~ "^/slideshow/20(1[5-9]|[2-9][0-9])/"
                    ) {
                        call do_redirect;
                    }
                }
            }
        }
    }
}

sub do_redirect {

    declare local var.orig_url STRING;

    set var.orig_url = req.url.path + req.http.x-nyt-orig-querystring;

    // pick mobile host based on the Fastly service we're in
    if (req.http.var-nyt-env == "dev") {
        set req.http.mobile-host = "mobile.dev.nytimes.com";
    } else if (req.http.var-nyt-env == "stg") {
        set req.http.mobile-host = "mobile.stg.nytimes.com";
    } else {
        set req.http.mobile-host = "mobile.nytimes.com";
    }

    set resp.http.Location = "https://" + req.http.mobile-host + querystring.filter(var.orig_url, "nytmobile");
    set resp.status = 303;
    set resp.response = "See Other";
    set resp.http.x-device-type = req.http.device_type;
    set req.http.x-redirect-reason = "redir=[mobile]";
}