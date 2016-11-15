sub vcl_recv {

    if (req.http.x-environment == "stg") {
        if (req.http.host ~ "^www([\-a-z0-9^\.]+)?.(dev\.|stg\.)?nytimes.com$") {
            if (req.url ~ "^/svc/crosswords/") {
                set req.http.X-PageType = "games-service";
                call set_games_backend;
                set req.http.x-skip-glogin = "1";
                return(pass);
            }
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType ~ "games-service") {
        set resp.http.X-API-Version = "GS";
    }
}

sub set_games_backend {
    if (req.http.host ~ "\.dev\.") {
        //set req.backend = beta_watching_dev;
    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = games_stg;
        set req.http.host = "nyt-games-dev.appspot.com";
    } else {
        //set req.backend = beta_watching_prd;
    }
}
