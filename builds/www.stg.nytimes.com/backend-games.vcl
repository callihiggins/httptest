sub vcl_recv {
    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (req.url ~ "^/svc/crosswords/" || req.url ~ "^/svc/games/(sudoku|set)/") {
            set req.http.X-PageType = "games-service";
            set req.http.x-skip-glogin = "1";
            return(pass);
        }
    }
}

sub vcl_pass {
    if (req.http.X-PageType ~ "games-service") {
      call set_games_backend;
    }
}

sub vcl_deliver {
    if (req.http.X-PageType ~ "games-service") {
        set resp.http.X-API-Version = "GS";
    }
}

sub set_games_backend {
    if (req.http.host ~ "\.dev\.") {
        //set bereq.backend = ???;
    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = games_stg;
        set bereq.http.host = "nyt-games-dev.appspot.com";
    } else {
        set req.backend = games_prd;
        set bereq.http.host = "nyt-games-prd.appspot.com";
    }
}
