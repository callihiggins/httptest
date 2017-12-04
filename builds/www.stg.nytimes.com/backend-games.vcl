sub vcl_recv {
    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (req.url.path ~ "^/games/prototype/" || req.url.path ~ "^/svc/crosswords/" || req.url.path ~ "^/svc/games/(sudoku|set)/") {
            set req.http.X-PageType = "games-service";
            set req.http.x-nyt-backend = "games_svc";
            set req.http.x-skip-glogin = "1";
            return(pass);
        }

        if (req.url.path ~ "^/crosswords" &&
            req.url.qs !~ "nyt-games=legacy") {

            set req.http.X-PageType = "games-web";
            set req.http.x-nyt-backend = "games_web";
            set req.http.x-skip-glogin = "1";

            // Since we're returning early, we need to do this here for now
            if (!req.http.Fastly-SSL) {
                call redirect_to_https;
            }

            // Games need cookies and until we sort out our mess with cookies we need to pass requests
            // to the apps
            return(pass);
        }

        // We can treat the games assets as everything else and cache those (no cookies needed there)
        if (req.url.path ~ "^/games-assets/") {
            set req.http.X-PageType = "games-assets";
            set req.http.x-nyt-backend = "games_assets";
            set req.http.x-skip-glogin = "1";

            if (!req.http.Fastly-SSL) {
                call redirect_to_https;
            }

            unset req.http.Cookie;
            unset req.http.X-Cookie;
            unset req.http.x-nyt-edition;
            unset req.http.x-nyt-s;
            unset req.http.x-nyt-wpab;
            return(lookup);
        }

        // submissions page
        if (req.url.path ~ "^/crosswords/submissions$") {
            set req.http.X-PageType = "games-web";
            set req.http.x-nyt-backend = "games_web";
            set req.http.x-skip-glogin = "1";

            if (!req.http.Fastly-SSL) {
                call redirect_to_https;
            }
            return(pass);
        }
    }
}

sub vcl_pass {
    call set_games_backend_request;
}

sub vcl_miss {
    call set_games_backend_request;
}

sub set_games_backend_request {
    if (req.http.X-PageType == "games-service") {
      call set_games_svc_backend;
    } else if (req.http.X-PageType == "games-web") {
      call set_games_web_backend;
    } else if (req.http.X-PageType == "games-assets") {
      call set_games_assets_backend;
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

    set req.backend = F_games_svc;

    if (req.http.x-environment == "dev") {
        set bereq.http.host = "nyt-games-dev.appspot.com";
    } else if (req.http.x-environment == "stg") {
        set bereq.http.host = "nyt-games-dev.appspot.com";
    } else {
        set bereq.http.host = "nyt-games-prd.appspot.com";
    }
}

sub set_games_web_backend {

    set req.backend = F_games_web;

    if (req.http.x-environment == "dev") {
        set bereq.http.host = "puzzles.dev.nyt.net";
    } else if (req.http.x-environment == "stg") {
        set bereq.http.host = "puzzles.dev.nyt.net";
    } else {
        set bereq.http.host = "puzzles.prd.nyt.net";
    }
}

sub set_games_assets_backend {

    set req.backend = F_games_assets;
    set bereq.http.host = "storage.googleapis.com";

}
