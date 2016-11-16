sub vcl_recv {

    if (req.http.x-environment == "stg"){

        if (req.http.host ~ "^(www-[a-z0-9]+\.)(dev\.|stg\.|)?nytimes.com$") {
            if (   req.url ~ "^/watching$"
                || req.url ~ "^/watching\?"
                || req.url ~ "^/watching/"
                || req.url ~ "^\/\d{4}\/\d{2}\/\d{2}\/watching\/"
            ) {
                if (req.url ~ "^/watching/api/users/") {
                    set req.http.X-PageType = "watching-nocache";
                } else {
                    set req.http.X-PageType = "watching";
                    unset req.http.Cookie;
                    unset req.http.X-Cookie;
                }
                call set_beta_watching_backend;
                set req.grace = 24h;
                set req.http.x-skip-glogin = "1";
                unset req.http.x-nyt-edition;
                unset req.http.x-nyt-s; 
                unset req.http.x-nyt-wpab;

                if (req.http.X-PageType == "watching-nocache") {
                    return(pass);
                }
            }
        }

        if (req.http.magicmarker-watching == "fake") {
            unset req.http.magicmarker-watching;
            set req.backend = beta_deadend;
            return(lookup);
        }

    }  
}

sub vcl_hash {
    if (req.http.X-PageType == "watching-nocache") {
        if (! req.http.Cookie && req.http.X-Cookie) {
            set req.http.Cookie = req.http.X-Cookie;
            unset req.http.X-Cookie;
        }
    }
}

sub vcl_fetch {
    if (req.http.X-PageType == "watching") {
        // use very short cache TTL for HTTP 4XXs
        if (beresp.status >= 400 && beresp.status < 500) {
            set beresp.ttl = 3s;
        }

        // use saint mode for HTTP 5XXs
        if (beresp.status >= 500) {
            set beresp.saintmode = 60s;
            return(restart);
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType ~ "^watching") {
        set resp.http.X-API-Version = "W2";
    }
}

sub vcl_error {
    if (req.http.X-PageType ~ "^watching" && obj.status >= 500 && obj.status < 600) {
        set req.http.magicmarker-watching = "fake";
        return(restart);
    }
}

sub set_beta_watching_backend {
    if (req.http.host ~ "\.dev\.") {
        //set req.backend = beta_watching_dev;
    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = beta_watching_stg;
    } else {
        //set req.backend = beta_watching_prd;
    }
}
