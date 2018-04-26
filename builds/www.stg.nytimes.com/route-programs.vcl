sub recv_route_programs {
    if (req.http.x-nyt-canonical-www-host) {

        if (req.url.path ~ "^/programs/[\-a-z0-9]+/public/" || req.url.path ~ "^/programs/public/") {

            set req.http.x-nyt-route = "programs-gcs";
            set req.http.x-nyt-backend = "programs_gcs";
            unset req.http.Cookie;
            unset req.http.X-Cookie;
            unset req.http.x-nyt-edition;
            unset req.http.x-nyt-s;
            unset req.http.x-nyt-wpab;
        } else if (req.url.path ~ "^/programs/svc/shaq") {
            set req.http.x-nyt-route = "shaq-service";
            set req.http.x-nyt-backend = "shaq_svc";
            set req.http.x-nyt-force-pass = "true";
        } else if (req.url.path ~ "^/programs/" ) {
            set req.http.x-nyt-route = "programs-service";
            set req.http.x-nyt-backend = "programs_svc";
            unset req.http.Cookie;
            unset req.http.X-Cookie;
        }
    }
}

sub miss_pass_route_programs {
    if (req.http.x-nyt-route == "programs-service") {
        call set_programs_web_host;
    }

    if (req.http.x-nyt-route == "shaq-service") {
        call set_programs_shaq_host;
    }

    if (req.http.x-nyt-route == "programs-gcs") {
        call set_programs_gcs_host;
    }
}

sub deliver_programs_api_version {
    if (req.http.x-nyt-route == "programs-service") {
        set resp.http.X-API-Version = "PS";
    }
    if (req.http.x-nyt-route == "programs-gcs") {
        set resp.http.X-API-Version = "PGCS";
    }
}

sub set_programs_web_host {

    if (req.http.x-environment == "dev") {
        set bereq.http.host = "ftu-dot-nyt-betaprog-dev.appspot.com";
    } else if (req.http.x-environment == "stg") {
        set bereq.http.host = "ftu-dot-nyt-betaprog-dev.appspot.com";
    } else {
        set bereq.http.host = "ftu-dot-nyt-betaprog-prd.appspot.com";
    }

}

sub set_programs_gcs_host {
  # Configure access to Cloud Storage
  if (req.http.x-environment == "dev") {
    set bereq.http.host = "nyt-betaprog-dev-assets.storage.googleapis.com";
  } else if (req.http.x-environment == "stg") {
    set bereq.http.host = "nyt-betaprog-dev-assets.storage.googleapis.com";
  } else {
    set bereq.http.host = "nyt-betaprog-prd-assets.storage.googleapis.com";
  }

}

sub set_programs_shaq_host {

    if (req.http.x-environment == "dev") {
        set bereq.http.host = "shaq-dot-nyt-betaprog-dev.appspot.com";
    } else if (req.http.x-environment == "stg") {
        set bereq.http.host = "shaq-dot-nyt-betaprog-dev.appspot.com";
    } else {
        set bereq.http.host = "shaq-dot-nyt-betaprog-prd.appspot.com";
    }

    set bereq.url = regsub(bereq.url, "^/programs/svc/shaq/(.*)", "/svc/shaq/\1");

}
