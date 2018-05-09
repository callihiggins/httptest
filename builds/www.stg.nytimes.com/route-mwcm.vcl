include "subscription-currency-map-table";

sub recv_route_mwcm {
    if (req.http.x-nyt-canonical-www-host == "true") {
        if (    req.url == "/subscription"  ||
                req.url ~ "^/subscription/"  ||
                (   req.url == "/marketing"  &&
                    req.url != "/marketing/gdpr"
                ) ||
                (   req.url ~ "^/marketing/"  &&
                    req.url !~ "/marketing/gdpr/"
                ) ||
                req.url == "/services/mobile" ||
                req.url ~ "^/services/mobile/" ||
                req.url == "/subscriptions" ||
                req.url ~ "^/subscriptions/"
            ) {

            set req.http.x-nyt-currency = table.lookup(subscription_currency_map, client.geo.country_code, "USD");
            set req.http.x-nyt-route = "mwcm";
            set req.http.x-nyt-backend = "mwcm";
            set req.http.var-nyt-send-gdpr = "true";

            unset req.http.x-nyt-edition;
            unset req.http.x-nyt-s;
            unset req.http.x-nyt-wpab;
            unset req.http.x-cookie;
            unset req.http.cookie;

            if (req.url == "/subscriptions" || req.url ~ "^/subscriptions/") {
                # excludes "ptr" query string parameter.
                set req.url = querystring.filter_except(req.url, "ptr");
            } else {
                # excludes "exclude_optimizely", "exclude_jsonkidd", "exclude_abra" qs parameters 
                set req.url = querystring.regfilter_except(req.url, "^(exclude_optimizely|exclude_jsonkidd|exclude_abra)$");
            }
        }

        if (    req.url ~ "^/marketing/gdpr/" ||
                req.url == "/marketing/gdpr"  
            ) {

            set req.http.x-nyt-currency = table.lookup(subscription_currency_map, client.geo.country_code, "USD");
            set req.http.x-nyt-route = "mwcm";
            set req.http.x-nyt-backend = "mwcm";
            set req.http.var-nyt-send-gdpr = "true";
        }
        # sorts all the query parameters. 
        set req.url = querystring.sort(req.url);
    }
}

sub deliver_route_mwcm {
    if (req.http.x-nyt-route == "mwcm") {

        if (req.http.x-nyt-internal-access) {
            set resp.http.x-nyt-currency = req.http.x-nyt-currency;
        }

        if (resp.status == 301 || resp.status == 302) {
            if (resp.http.Location ~ "\?") {
                set resp.http.Location = resp.http.Location regsub(req.http.x-orig-querystring, "^\?", "&");
            }
            else {
                set resp.http.Location = resp.http.Location req.http.x-orig-querystring;
            }
        }
    }
}
