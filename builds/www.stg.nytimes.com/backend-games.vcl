sub vcl_recv {
    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (req.url.path ~ "^/svc/crosswords/" || req.url.path ~ "^/svc/games/(sudoku|set)/") {
            set req.http.X-PageType = "games-service";
            set req.http.x-skip-glogin = "1";
            return(pass);
        }

        if (req.http.x-environment == "stg") {
            if (req.url.path ~ "^/crosswords/game/(daily|mini|variety|bonus|special|paid)" || req.url.path ~ "^/games-assets/") {
                set req.http.X-PageType = "games-web";
                set req.http.x-skip-glogin = "1";

                // Games need cookies, so returning returning lookup early
                return(lookup);
            }
        }
    }
}

sub vcl_pass {
    call set_backend_request;
}

sub vcl_miss {
    call set_backend_request;
}

sub set_backend_request {
    if (req.http.X-PageType == "games-service") {
      call set_games_svc_backend;
    } else if (req.http.X-PageType == "games-web") {
      call set_games_web_backend;
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "games-service") {
        set resp.http.X-API-Version = "GS";
    } else if (req.http.X-PageType == "games-web") {
        set resp.http.X-API-Version = "GW";
    }
}

sub set_games_svc_backend {
    if (req.http.x-environment == "dev") {
        //set req.backend = ???;
    } else if (req.http.x-environment == "stg") {
        set req.backend = games_svc_stg;
        set bereq.http.host = "nyt-games-dev.appspot.com";
    } else {
        set req.backend = games_svc_prd;
        set bereq.http.host = "nyt-games-prd.appspot.com";
    }
}

sub set_games_web_backend {
    if (req.http.x-environment == "dev") {
        // No dev
    } else if (req.http.x-environment == "stg") {
        set req.backend = games_web_stg;
        set bereq.http.host = "puzzles.dev.nyt.net";
    } else {
        // No prod yet
    }
}
