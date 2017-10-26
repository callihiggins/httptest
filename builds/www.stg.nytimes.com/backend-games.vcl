sub vcl_recv {
    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (req.url.path ~ "^/games/prototype/" || req.url.path ~ "^/svc/crosswords/" || req.url.path ~ "^/svc/games/(sudoku|set)/") {
            set req.http.X-PageType = "games-service";
            set req.http.x-skip-glogin = "1";
            return(pass);
        }

        if (req.url.path ~ "^/crosswords(/|/index.html)?$" &&
            req.url.qs !~ "nyt-games=legacy") {

            set req.http.X-PageType = "games-web";
            set req.http.x-skip-glogin = "1";

            // Since we're returning early, we need to do this here for now
            if (!req.http.Fastly-SSL) {
                call redirect_to_https;
            }

            // Games need cookies and until we sort out our mess with cookies we need to pass requests
            // to the apps
            return(pass);
        }

        if ((req.url.path ~ "^/crosswords/game/(sudoku|kenken|set)" ||
            req.url.path ~ "^/crosswords/archive") &&
            req.url.qs !~ "nyt-games=legacy") {

            set req.http.X-PageType = "games-web";
            set req.http.x-skip-glogin = "1";

            // Since we're returning early, we need to do this here for now
            if (!req.http.Fastly-SSL) {
                call redirect_to_https;
            }

            // Games need cookies and until we sort out our mess with cookies we need to pass requests
            // to the apps
            return(pass);
        }

        if (req.http.x-environment == "stg" &&
            (req.url.path ~ "^/crosswords/(tips-and-tricks|stats|primer)" ||
             req.url.path ~ "^/crosswords/game/acrostic") &&
            req.url.qs !~ "nyt-games=legacy") {

            set req.http.X-PageType = "games-web";
            set req.http.x-skip-glogin = "1";

            // Since we're returning early, we need to do this here for now
            if (!req.http.Fastly-SSL) {
                call redirect_to_https;
            }

            // Games need cookies and until we sort out our mess with cookies we need to pass requests
            // to the apps
            return(pass);
        }

        if (req.url.path ~ "^/crosswords/game/(daily|mini|variety|bonus|special|paid)") {
            set req.http.X-PageType = "games-web";
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
        set req.backend = games_web_prd;
        set bereq.http.host = "puzzles.prd.nyt.net";
    }
}

sub set_games_assets_backend {
    if (req.http.x-environment == "dev") {
        // No dev
    } else {
        // one asset bucket for stg and prd
        set req.backend = games_assets_prd;
        set bereq.http.host = "storage.googleapis.com";
    }
}
