sub vcl_recv {
    set req.http.x-mobile-param = regsub(req.http.x-orig-querystring, ".*?.*(nytmobile=.).*", "\1");
}

sub vcl_deliver {
    if (resp.status != 301 && resp.status != 303) {
        set req.http.x-do-mobile-redirect = "0";

        // mobile device detection
        if (req.http.device_type == "smartphone" || req.http.device_type == "phone") {
            set req.http.x-do-mobile-redirect = "1";
        }

        if (req.http.X-PageType ~ "^blog") {
            // query string override
            if (req.http.x-mobile-param ~ "nytmobile=1") {
                set req.http.x-do-mobile-redirect = "1";
            }
            if (req.http.x-mobile-param ~ "nytmobile=0") {
                set req.http.x-do-mobile-redirect = "0";
            }

            // cookie override
            if (req.http.x-nyt-mobile == "0") {
                set req.http.x-do-mobile-redirect = "0";
            }
            if (req.http.x-nyt-mobile == "1") {
                set req.http.x-do-mobile-redirect = "1";
            }

            // whitelist of blog hostnames that do redirect
            // disable redirect if failed match
            if (   req.http.host !~ "^(6thfloor|afterdeadline|artsbeat|atwar|bits|bittman|boss|brooks|bruni|bucks|carpetbagger|cityroom|dealbook|dotearth|douthat|economix|firstlook|india|intransit|keller|kristof|krugman|latitude|learning|lens|newoldage|news|nocera|opinionator|parenting|publiceditor|runway|sinosphere|sports|takingnote|thecaucus|thelede|tmagazine|well|wordplay)(\.blogs|\.blogs5|)\."
                && req.http.host != "www.nytimes.com"
            ) {
                set req.http.x-do-mobile-redirect = "0";
            }

            // URLs for PageType blog2 never redirect
            if ( req.http.X-PageType == "blog2") {
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
            if (req.http.x-mobile-param ~ "nytmobile=1") {
                set req.http.x-do-mobile-redirect = "1";
            }
            if (req.http.x-mobile-param ~ "nytmobile=0") {
                set req.http.x-do-mobile-redirect = "0";
            }
            // homepage & sectionfronts specific logic
            if (req.http.X-PageType == "homepage") {
                // cookie override
                if (req.http.x-nyt-mobile == "0") {
                    set req.http.x-do-mobile-redirect = "0";
                }
                if (req.http.x-nyt-mobile == "1") {
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
                } else if ( req.url ~ "^/real-estate/" ) {
                    call do_realestate_redirect;
                }
            }
        }
    }
}

sub do_redirect {

    declare local var.orig_url STRING;

    set var.orig_url = req.url.path + req.http.x-orig-querystring;

    // pick mobile host based on the Fastly service we're in
    if (req.http.x-environment == "dev") {
        set req.http.mobile-host = "mobile.dev.nytimes.com";
    } else if (req.http.x-environment == "stg") {
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

sub do_realestate_redirect {
    if (  req.url ~ "^/real-estate/find-a-home" ) {
        set req.http.X-NewUri = "";
        // matches patterns like:
        // https://www.nytimes.com/real-estate/usa/ny/brooklyn/clinton-hill/homes-for-rent/333-washington-avenue/46-3257305
    } else if ( req.url ~ "^/real-estate/(.*)/homes-for-(sale|rent)/([^/]+)/([^/]+)" ) {
        set req.http.X-NewUri = regsub(req.url, "^/real-estate/(.*)/homes-for-(sale|rent)/([^/]+)/([^/]+)","listing/\4");
        // matches patterns like:
        // https://www.nytimes.com/real-estate/usa/ny/new-york/upper-east-side/homes-for-sale
    } else if ( req.url ~ "^/real-estate/([^\/]+)/([^\/]+)/([^\/]+)/([^\/]+)/homes-for-sale" ) {
        set req.http.X-NewUri = regsub(req.url, "^/real-estate/([^\/]+)/([^\/]+)/([^\/]+)/([^\/]+)/homes-for-sale", "search?channel=sales&search=See+Available+Homes&location=\4-\3-\2-\1");
        // matches patterns like:
        // https://www.nytimes.com/real-estate/usa/ny/new-york/upper-east-side/homes-for-rent
    } else if ( req.url ~ "^/real-estate/([^\/]+)/([^\/]+)/([^\/]+)/([^\/]+)/homes-for-rent" ) {
        set req.http.X-NewUri = regsub(req.url, "^/real-estate/([^\/]+)/([^\/]+)/([^\/]+)/([^\/]+)/homes-for-rent", "search?channel=rentals&search=See+Available+Homes&location=\4-\3-\2-\1");
        // https://www.nytimes.com/real-estate/homes-for-sale/?locations%5B%5D=upper-west-side-new-york-ny-usa&locations%5B%5D=lower-east-side-new-york-ny-usa&redirect=find-a-home
    } else if ( req.url ~ "^/real-estate/homes-for-sale\/?\?locations[^=]+=([^\&]+)" ) {
        set req.http.X-NewUri = regsub(req.url, "^/real-estate/homes-for-sale\/?\?locations[^=]+=([^\&]+)","search?channel=sales&location=\1&search=See+Available+Homes");
        // https://www.nytimes.com/real-estate/homes-for-rent/?locations%5B%5D=upper-west-side-new-york-ny-usa&locations%5B%5D=lower-east-side-new-york-ny-usa&redirect=find-a-home
    } else if ( req.url ~ "^/real-estate/homes-for-rent\/?\?locations[^=]+=([^\&]+)" ) {
        set req.http.X-NewUri = regsub(req.url, "^/real-estate/homes-for-rent\/?\?locations[^=]+=([^\&]+)","search?channel=rentals&location=\1&search=See+Available+Homes");
    } else if ( req.url ~ "^/real-estate/(.*)?homes-for-sale" ) {
        set req.http.X-NewUri = "?channel=sales";
    } else if ( req.url ~ "^/real-estate/(.*)?homes-for-rent" ) {
        set req.http.X-NewUri = "?channel=rentals";
    } else if ( req.url ~ "^/real-estate/(.*)/building/" ) {
        // matches patterns like:
        // https://www.nytimes.com/real-estate/usa/ny/new-york/upper-east-side/building/880-fifth-avenue/5096
        set req.http.X-NewUri = "";
    } else if ( req.url ~ "^/real-estate/my-real-estate$" ) {
        // https://www.nytimes.com/real-estate/my-real-estate
        set req.http.X-NewUri = "savedlistings";
    }

    set resp.http.Location = "https://m.realestatelistings.nytimes.com/" + req.http.X-NewUri;
    set resp.status = 301;
    set resp.response = "FOUND";
    set resp.http.x-device-type = req.http.device_type;
    set req.http.x-redirect-reason = "redir=[mobile]";
}
