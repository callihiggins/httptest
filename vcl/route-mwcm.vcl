include "subscription-currency-map-table";

sub recv_route_mwcm {
    if (req.http.var-nyt-canonical-www-host == "true") {
        if (    req.url ~ "^/subscription"  ||
                req.url ~ "^/marketing(/)?" ||
                req.url == "/services/mobile" ||
                req.url ~ "^/services/mobile/"
            ) {

            set req.http.x-nyt-currency = table.lookup(subscription_currency_map, client.geo.country_code, "USD");
            set req.http.x-nyt-route = "mwcm";
            set req.http.x-nyt-backend = "mwcm";
            set req.http.var-nyt-send-gdpr = "true";

            if (    req.url !~ "^/marketing/(gdpr|moco|mpc|account)(/)?"  &&
                    req.url !~ "^/subscription/exo(/)?"
                ) {

              if (req.url == "/subscriptions" || req.url ~ "^/subscriptions/") {
                  # excludes "ptr" query string parameter.
                  set req.url = querystring.filter_except(req.url, "ptr");
              } else {
                  # excludes "exclude_optimizely", "exclude_jsonkidd", "exclude_abra" qs parameters
                  set req.url = querystring.regfilter_except(req.url, "^(exclude_optimizely|exclude_jsonkidd|exclude_abra|mwcmff|campaignId|skipFastly|promoStartDate|pre_prod)$");
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

                # checks skipFastly=true qs param
                # if present, then sets x-nyt-miss
                # x-nyt-miss forces cache type to be miss if the request is coming from the internal ips. 
                if ( subfield(req.url.qs, "skipFastly", "&") == "true" ) {
                    set req.http.x-nyt-miss = "1";
                }

                # checks the presence of nyt-m (meter) cookie
                # if present, then sets x-nyt-metered-hits and x-nyt-gateway-hits
                if ( req.http.cookie:nyt-m ) {
                    
                    if (req.http.cookie:nyt-m ~ "&v=i.(\d+)&" ) {
                        set req.http.x-nyt-metered-hits = re.group.1;
                    }
                    
                    if (req.http.cookie:nyt-m ~ "&g=i.(\d+)&" ) {
                        set req.http.x-nyt-gateway-hits = re.group.1;
                    }
                }

                # checks the value of referer header
                # if nytimes.com then sets x-nyt-targeting-source="hp"
                # if nytimes.com/subscription/ then sets x-nyt-referer = "subscription" and x-nyt-targeting-source="lp"
                # if nytimes.com/interactive/ then sets x-nyt-targeting-source="ip"
                # if nytimes.com/201[4-9]/ then sets x-nyt-targeting-source="vi"
                # if nytimes.com/(18[5-9][0-9]|19[0-9][0-9]|200[0-9]|201[0-3])/ then sets x-nyt-targeting-source="nyt5"
                # x-nyt-targeting-source header will be used for source targeting. 
                # if facebook.com then sets x-nyt-referer = "facebook"
                # if google.com then sets x-nyt-referer = "google" 
                if ( req.http.Referer ~ "^http(s?):\/\/www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com($|\/$)" ) {
                    set req.http.x-nyt-targeting-source = "hp";
                } else if ( req.http.Referer ~ "^http(s?):\/\/www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com\/subscription(\/)?" ) {
                    set req.http.x-nyt-referer = "subscription";
                    set req.http.x-nyt-targeting-source = "lp"; # "lp" stands for landing page
                } else if ( req.http.Referer ~ "^http(s?):\/\/www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com\/interactive(\/)?" ) {
                    set req.http.x-nyt-targeting-source = "ip"; # "ip" stands for interactive page
                } else if ( req.http.Referer ~ "^http(s?):\/\/www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com\/(18[5-9][0-9]|19[0-9][0-9]|200[0-9]|201[0-3])/" ) {
                    set req.http.x-nyt-targeting-source = "nyt5"; # "nyt5" is for nyt5 articles
                } else if ( req.http.Referer ~ "^http(s?):\/\/www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com\/201[4-9]/" ) {
                    set req.http.x-nyt-targeting-source = "vi"; # "vi" is for vi articles  
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
            if ( req.http.cookie:NYT-S ) {
                set req.http.x-nyt-subscriber = "true";
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
    if (req.http.x-nyt-route ~ "^mwcm") {

        if (req.http.x-nyt-nyhq-access == "1") {
            # sets the response header only for the internal ips.
            # these headers will be useful for troubleshooting purpose.
            set resp.http.x-nyt-currency = req.http.x-nyt-currency;
            set resp.http.x-nyt-referer = req.http.x-nyt-referer;
            set resp.http.x-nyt-metered-hits = req.http.x-nyt-metered-hits;
            set resp.http.x-nyt-gateway-hits = req.http.x-nyt-gateway-hits;
            set resp.http.x-nyt-device = req.http.x-nyt-device;
            set resp.http.x-nyt-subscriber = req.http.x-nyt-subscriber;
            set resp.http.x-nyt-targeting-source = req.http.x-nyt-targeting-source;
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
