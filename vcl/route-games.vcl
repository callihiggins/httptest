sub recv_route_games {
    if (req.http.var-nyt-canonical-www-host) {
        if (req.url.path ~ "^/games/prototype/" || req.url.path ~ "^/svc/crosswords/" || req.url.path ~ "^/svc/games/") {
            set req.http.x-nyt-route = "games-service";
            set req.http.x-nyt-backend = "games_svc";
            set req.http.var-nyt-force-pass = "true";
            set req.http.var-nyt-send-gdpr = "true";
        }

        if (req.url.path ~ "^/puzzles") {
              set req.http.x-nyt-route = "games-phoenix";
              set req.http.x-nyt-backend = "games_phoenix";
              set req.http.var-nyt-send-gdpr = "true";

              // Games need cookies and until we sort out our mess with cookies we need to pass requests
              // to the apps
              set req.http.var-nyt-force-pass = "true";
              // Send x-gdpr header value to backend server
              set req.http.x-nyt-gdpr = req.http.var-cookie-nyt-gdpr;
        }

        if (req.url.path ~ "^/crosswords") {
            set req.http.x-nyt-route = "games-web";
            set req.http.x-nyt-backend = "games_web";
            set req.http.var-nyt-send-gdpr = "true";

            // Games need cookies and until we sort out our mess with cookies we need to pass requests
            // to the apps
            set req.http.var-nyt-force-pass = "true";
            // Send x-gdpr header value to backend server
            set req.http.x-nyt-gdpr = req.http.var-cookie-nyt-gdpr;
        }

        // We can treat the games assets as everything else and cache those (no cookies needed there)
        if (req.url.path ~ "^/games-assets/") {
            set req.http.x-nyt-route = "games-assets";
            set req.http.x-nyt-backend = "gcs_origin";
        }
    }
}

sub miss_pass_route_games {
  if (req.http.x-nyt-route == "games-service") {
    call set_games_svc_host;
  } else if (req.http.x-nyt-route == "games-web") {
    call set_games_web_host;
  } else if (req.http.x-nyt-route == "games-assets") {
    unset bereq.http.cookie;
    call set_games_assets_host;
  } else if (req.http.x-nyt-route == "games-phoenix") {
    call set_games_phoenix_host;
  }
}

sub deliver_games_api_version {
    if (req.http.x-nyt-route == "games-service") {
        set resp.http.X-API-Version = "GS";
    } else if (req.http.x-nyt-route == "games-web" ||
               req.http.x-nyt-route == "games-phoenix") {
        set resp.http.X-API-Version = "GW";
    }
}

sub set_games_svc_host {
    if (req.http.var-nyt-env == "dev") {
        set bereq.http.host = "nyt-games-dev.appspot.com";
    } else if (req.http.var-nyt-env == "stg") {
        set bereq.http.host = "nyt-games-dev.appspot.com";
    } else {
        set bereq.http.host = "nyt-games-prd.appspot.com";
    }
}

sub set_games_web_host {
    if (req.http.var-nyt-env == "dev") {
        set bereq.http.host = "puzzles.dev.nyt.net";
    } else if (req.http.var-nyt-env == "stg") {
        set bereq.http.host = "puzzles.dev.nyt.net";
    } else {
        set bereq.http.host = "puzzles.prd.nyt.net";
    }
}

sub set_games_assets_host {
    if(!req.backend.is_shield) {
        call miss_pass_set_bucket_auth_headers;
        set bereq.url = regsub(bereq.url, "^/games-assets/", "/");
    }
}

sub set_games_phoenix_host {
    if (req.http.var-nyt-env == "dev" ||
        req.http.var-nyt-env == "stg") {
        set bereq.http.host = "phoenix.games.dev.nyt.net";
    } else {
        set bereq.http.host = "phoenix.games.prd.nyt.net";
    }
}
