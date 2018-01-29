include "subscription-currency-map-table";

sub vcl_recv {
    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (    req.url == "/subscription"  ||  
                req.url ~ "^/subscription/"  ||
                req.url == "/marketing/surveys"  ||
                req.url ~ "^/marketing/surveys/"  ||
                req.url == "/services/mobile" ||  
                req.url ~ "^/services/mobile/"
            ) {

            set req.http.X-NYT-Currency = table.lookup(subscription_currency_map, client.geo.country_code, "USD");
            set req.http.X-PageType = "mwcm";
            set req.http.x-nyt-backend = "mwcm";
            set req.backend = F_mwcm;
            unset req.http.x-nyt-edition;
            unset req.http.x-nyt-s;
            unset req.http.x-nyt-wpab;
            set req.url = querystring.remove(req.url);
            return(lookup);
        }

        # Enables only in dev environment. checks for req.http.x-environment == "dev"
        if (    (   req.url == "/marketing" ||  
                    req.url ~ "^/marketing/" ||
                    req.url == "/subscriptions" ||
                    req.url ~ "^/subscriptions/"
                ) && req.http.x-environment == "dev"
            ) {
            set req.http.X-PageType = "mwcm";
            set req.http.x-nyt-backend = "mwcm";
            set req.backend = F_mwcm;
            unset req.http.x-nyt-edition;
            unset req.http.x-nyt-s;
            unset req.http.x-nyt-wpab;
            set req.url = querystring.remove(req.url);
            return(lookup);
        }    
    }
}

sub vcl_hash {
    if (req.http.X-PageType == "mwcm") {
        unset req.http.X-Cookie;
        unset req.http.Cookie;
    }
}


sub vcl_deliver {
    if (req.http.X-PageType == "mwcm") {

        set resp.http.X-API-Version = "WCM";

        if (req.http.x-nyt-internal-access) {
          set resp.http.X-NYT-Currency = req.http.X-NYT-Currency;
        }

        if (resp.status == 301 || resp.status == 302) {
            set resp.http.Location = resp.http.Location + req.http.x-orig-querystring;
        }
    }
}
