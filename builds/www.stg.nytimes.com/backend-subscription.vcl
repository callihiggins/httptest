sub vcl_recv {

    if (req.http.x-environment == "stg") {

        if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
            if (    req.url == "/subscription"
                ||  req.url ~ "^/subscription/"
                ) {

                set req.http.X-PageType = "subscription";
                call set_subscription_backend;
                set req.grace = 24h;
                set req.http.x-skip-glogin = "1";
                unset req.http.x-nyt-edition;
                unset req.http.x-nyt-s; 
                unset req.http.x-nyt-wpab;
                set req.url = querystring.remove(req.url);
                return(lookup);
            }
        }
    }  
}

sub vcl_hash {
    if (req.http.X-PageType == "subscription") {
        unset req.http.X-Cookie;
        unset req.http.Cookie;
    }
}

sub vcl_fetch {
    if (req.http.X-PageType == "subscription") {
        // use very short cache TTL for HTTP 4XXs
        if (beresp.status >= 400 && beresp.status < 500) {
            set beresp.ttl = 3s;
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "subscription") {

        set resp.http.X-API-Version = "WCM";

        if(resp.status == 301 || resp.status == 302) {
            set resp.http.Location = resp.http.Location + req.http.x-orig-querystring;
        }
    }
}


sub set_subscription_backend {
    if (req.http.host ~ "\.dev\.") {
        //set req.backend = ???;
    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = subscription_stg;
    } else {
        //set req.backend = ???;
    }
}
