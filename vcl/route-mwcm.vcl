include "subscription-currency-map-table";

sub recv_route_mwcm {
    if (req.http.var-nyt-canonical-www-host == "true") {
        if (    req.url == "/subscription"  ||
                req.url ~ "^/subscription/"  ||
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

            if (req.url !~ "^/marketing/(gdpr|moco)(/)?") {

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

            # x-nyt-subscriber header detects whether the user is a subscriber or not.
            # default value "false"
            # checks the presence of NYT-S cookie, changes the value to be "true", if present. 
            set req.http.x-nyt-subscriber = "false";
            if ( req.http.cookie ~ "NYT-S=" ) {
                set req.http.x-nyt-subscriber = "true";
            }
            # sets value of the header "req.http.var-nyt-ismagnolia" to "true|false" 
            # req.http.var-nyt-ismagnolia = "true" when requests comes to magnolia cms in mwcm backend
            # default vaule is "false"
            set req.http.var-nyt-ismagnolia = "false";

            if (    req.url == "/subscription" ||
                    req.url ~ "^/subscription/" ||
                    req.url ~ "^/marketing/(surveys|gdpr|moco)(/)?"
                ) {
                set req.http.var-nyt-ismagnolia = "true";
            }
        }
    }
}

sub deliver_route_mwcm {
    if (req.http.x-nyt-route == "mwcm") {

        if (req.http.x-nyt-nyhq-access) {
            set resp.http.x-nyt-currency = req.http.x-nyt-currency;
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
    }
}
