include "subscription-currency-map-table";

sub recv_route_mwcm {
    if (req.http.x-nyt-canonical-www-host == "true") {
        if (    req.url == "/subscription"  ||
                req.url ~ "^/subscription/"  ||
                req.url == "/marketing"  ||
                req.url ~ "^/marketing/"  ||
                req.url == "/services/mobile" ||
                req.url ~ "^/services/mobile/" ||
                req.url == "/subscriptions" ||
                req.url ~ "^/subscriptions/"
            ) {

            set req.http.x-nyt-currency = table.lookup(subscription_currency_map, client.geo.country_code, "USD");
            set req.http.x-nyt-route = "mwcm";
            set req.http.x-nyt-backend = "mwcm";
            set req.http.X-SendGDPR = "true";

            unset req.http.x-nyt-edition;
            unset req.http.x-nyt-s;
            unset req.http.x-nyt-wpab;
            unset req.http.x-cookie;
            unset req.http.cookie;

            if (req.url == "/subscriptions" || req.url ~ "^/subscriptions/") {
                set req.url = querystring.filter_except(req.url, "ptr");
            } else {
                set req.url = querystring.remove(req.url);
            }
        }
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
