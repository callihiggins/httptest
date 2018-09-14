include "subscription-currency-map-table";

sub recv_route_mwcm {
    if (req.http.var-nyt-canonical-www-host == "true") {
        if (    req.url == "/subscription"  ||
                req.url ~ "^/subscription(/|.html)"  ||
                req.url ~ "^/marketing(/)?" ||
                req.url == "/services/mobile" ||
                req.url ~ "^/services/mobile/" ||
                req.url == "/subscriptions" ||
                req.url ~ "^/subscriptions/"
            ) {

            set req.http.x-nyt-currency = table.lookup(subscription_currency_map, client.geo.country_code, "USD");
            set req.http.x-nyt-route = "mwcm";
            set req.http.x-nyt-backend = "mwcm";
            set req.http.var-nyt-send-gdpr = "true";

            if (    req.url !~ "^/marketing/(gdpr|moco|mpc)(/)?"  &&
                    req.url !~ "^/subscription/exo(/)?"
                ) {

              if (req.url == "/subscriptions" || req.url ~ "^/subscriptions/") {
                  # excludes "ptr" query string parameter.
                  set req.url = querystring.filter_except(req.url, "ptr");
              } else {
                  # excludes "exclude_optimizely", "exclude_jsonkidd", "exclude_abra" qs parameters
                  set req.url = querystring.regfilter_except(req.url, "^(exclude_optimizely|exclude_jsonkidd|exclude_abra|mwcmff)$");
              }
            } else {
                  set req.http.x-nyt-route = "mwcm-params";
            }

            # sets value of the header "req.http.var-nyt-ismagnolia" to "true|false" 
            # req.http.var-nyt-ismagnolia = "true" when requests comes to magnolia cms in mwcm backend
            # default vaule is "false"
            set req.http.var-nyt-ismagnolia = "false";

            if (    req.url == "/subscription" ||
                    req.url ~ "^/subscription(/|.html)" ||
                    req.url ~ "^/marketing/(surveys|gdpr|moco|mpc)(/)?"
                ) {
                set req.http.var-nyt-ismagnolia = "true";

                # checks the presence of nyt-m (meter) cookie
                # if present, then sets x-nyt-metered-hits and x-nyt-gateway-hits
                if ( req.http.cookie ~ "nyt-m=" ) {
                    
                    if (req.http.cookie:nyt-m ~ "&v=i.(\d+)&" ) {
                        set req.http.x-nyt-metered-hits = re.group.1;
                    }
                    
                    if (req.http.cookie:nyt-m ~ "&g=i.(\d+)&" ) {
                        set req.http.x-nyt-gateway-hits = re.group.1;
                    }
                }

                # checks the value of referer header
                # if nytimes.com/subscription/ then sets x-nyt-referer = "subscription"
                # if facebook.com then sets x-nyt-referer = "facebook"
                # if google.com then sets x-nyt-referer = "google" 
                if ( req.http.Referer ~ "^http(s?):\/\/www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com\/subscription(\/)?" ) {
                    set req.http.x-nyt-referer = "subscription";
                } else if ( req.http.Referer ~ "^http(s?):\/\/(.*\.)?facebook\.com" ) {
                    set req.http.x-nyt-referer = "facebook";
                } else if ( req.http.Referer ~ "^http(s?):\/\/(.*\.)?google\.com" ) {
                    set req.http.x-nyt-referer = "google";
                }
            }

            # x-nyt-subscriber header detects whether the user is a subscriber or not.
            # default value "false"
            # checks the presence of NYT-S cookie, changes the value to be "true", if present. 
            set req.http.x-nyt-subscriber = "false";
            if ( req.http.cookie ~ "NYT-S=" ) {
                set req.http.x-nyt-subscriber = "true";
            }
            
            # this logic allows stripping of optimizely dependency via cookie "mwcm_exclude_optimizely"
            # checks the presence of the "mwcm_exclude_optimizely" cookie 
            # appends "exclude_optimizely=true" qs parameter to the url
            # logic not applies to hd pages.
            if ( req.http.cookie ~ "mwcm_exclude_optimizely=" && req.url !~ "^/subscription/hd(/)?") {
                set req.url = querystring.add(req.url, "exclude_optimizely", "true");
            }

            # this logic allows stripping of jsonkidd dependency via cookie "mwcm_exclude_jsonkidd"
            # checks the presence of the "mwcm_exclude_jsonkidd" cookie
            # appends "exclude_jsonkidd=true" qs parameter to the url
            # logic not applies to hd pages.
            if ( req.http.cookie ~ "mwcm_exclude_jsonkidd=" && req.url !~ "^/subscription/hd(/)?") {
                set req.url = querystring.add(req.url, "exclude_jsonkidd", "true");
            }        
            
            # sets x-nyt-device="mobile"|"tablet"|"desktop" header based on the device_type header. 
            # x-nyt-device header will be used on mwcm backend for targeting.
            set req.http.x-nyt-device = "";
            if (req.http.device_type ~ "phone") {
                set req.http.x-nyt-device = "mobile";
            } else if (req.http.device_type ~ "tablet") {
                set req.http.x-nyt-device = "tablet";
            } else {
                set req.http.x-nyt-device = "desktop";
            }
        }
    }
}

sub deliver_route_mwcm {
    if (req.http.x-nyt-route == "mwcm") {

        if (req.http.x-nyt-nyhq-access) {
            # sets the response header only for the internal ips.
            # these headers will be useful for troubleshooting purpose.
            set resp.http.x-nyt-currency = req.http.x-nyt-currency;
            set resp.http.x-nyt-referer = req.http.x-nyt-referer;
            set resp.http.x-nyt-metered-hits = req.http.x-nyt-metered-hits;
            set resp.http.x-nyt-gateway-hits = req.http.x-nyt-gateway-hits;
            set resp.http.x-nyt-device = req.http.x-nyt-device;
            set resp.http.x-nyt-subscriber = req.http.x-nyt-subscriber;
        }

        if (resp.status == 301 || resp.status == 302) {
            if (resp.http.Location ~ "\?") {
                set resp.http.Location = resp.http.Location regsub(req.http.x-nyt-orig-querystring, "^\?", "&");
            }
            else {
                set resp.http.Location = resp.http.Location req.http.x-nyt-orig-querystring;
            }
        }
    }
}

sub miss_pass_route_mwcm {
    #https://community.fastly.com/t/pull-cookie-values-without-regular-expressions/430
    #https://www.getpagespeed.com/server-setup/varnish/varnish-cache-cookies
    # logic to allow NYT-S and nyt-a cookies to mwcm backend 
    if (req.http.x-nyt-route == "mwcm" && req.http.var-nyt-ismagnolia == "true") {
        set bereq.http.cookie = "";
            
        if ( req.http.cookie ~ "nyt-a=" ) {
            #checks the presence of the nyt-a
            # allows nyt-a to MWCM backend
            set bereq.http.cookie = "nyt-a=" req.http.cookie:nyt-a ";";   
        }
        
        if (req.http.cookie ~ "NYT-S=") {
            #checks the presence of the NYT-S
            # allows NYT-S to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " NYT-S=" req.http.cookie:NYT-S ";";
        }

        if (req.http.cookie ~ "nyt-mwcm=") {
            #checks the presence of the nyt-mwcm
            # allows nyt-mwcm to MWCM backend
            set bereq.http.cookie = bereq.http.cookie " nyt-mwcm=" req.http.cookie:nyt-mwcm ";";
        }
    }
}
