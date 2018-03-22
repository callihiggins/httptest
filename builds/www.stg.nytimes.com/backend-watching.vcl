sub vcl_recv {

    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (   req.url ~ "^/watching$"
            || req.url ~ "^/watching\?"
            || req.url ~ "^/watching/"
            || req.url ~ "^\/\d{4}\/\d{2}\/\d{2}\/watching\/"
        ) {
            if (req.url ~ "^/watching/api/users/") {
                set req.http.X-PageType = "watching-nocache";
            } else {
                set req.http.X-PageType = "watching";
            }
            set req.backend = F_beta_watching;
            set req.http.x-nyt-backend = "beta_watching";
            unset req.http.x-nyt-edition;
            unset req.http.x-nyt-s;
            unset req.http.x-nyt-wpab;

            if (req.http.X-PageType == "watching-nocache") {
                set req.http.x-nyt-force-pass = "true";
                #return(pass);
            }
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

sub vcl_deliver {
    if (req.http.X-PageType ~ "^watching") {
        set resp.http.X-API-Version = "W2";
    }
}
