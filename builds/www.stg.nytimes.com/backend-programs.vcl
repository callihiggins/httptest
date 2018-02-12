sub vcl_recv {
    if (req.url.path ~ "^/programs/[\-a-z0-9]+/public/") {
        set req.http.X-PageType = "programs-gcs";
        call set_programs_gcs_backend;

        unset req.http.Cookie;
        unset req.http.X-Cookie;
        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-wpab;

        # Configure access to Cloud Storage
        set req.http.host = req.http.x-gcs-bucket ".storage.googleapis.com";

        return(lookup);
    }

    if (req.url.path ~ "^/programs/svc/shaq") {
        set req.http.X-PageType = "programs-service";
        set req.http.x-nyt-backend = "shaq_svc";
        set req.url = regsub(req.url, "^/programs/svc/shaq/(.*)", "/svc/shaq/\1");
        return(pass);
    }

    if (req.url.path ~ "^/programs/svc/") {
        set req.http.X-PageType = "programs-service";
        set req.http.x-nyt-backend = "programs_svc";
        return(pass);
    }

    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (req.url.path ~ "^/programs/" ) {
            set req.http.X-PageType = "programs-service";
            set req.http.x-nyt-backend = "programs_svc";
            unset req.http.Cookie;
            unset req.http.X-Cookie;
            return(lookup);
        }
    }
}

sub vcl_pass {
    if (req.http.X-PageType == "programs-service") {
        call set_programs_web_backend;
    }
}

sub vcl_miss {
    if (req.http.X-PageType == "programs-service") {
        call set_programs_web_backend;
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "programs-service") {
        set resp.http.X-API-Version = "PS";
    }
    if (req.http.X-PageType == "programs-gcs") {
        set resp.http.X-API-Version = "PGCS";
    }
}

sub set_programs_web_backend {

    set req.backend = F_programs_svc;

    if (req.http.x-environment == "dev") {
        set bereq.http.host = "ftu-dot-nyt-betaprog-dev.appspot.com";
    } else if (req.http.x-environment == "stg") {
        set bereq.http.host = "ftu-dot-nyt-betaprog-dev.appspot.com";
    } else {
        set bereq.http.host = "ftu-dot-nyt-betaprog-prd.appspot.com";
    }

}

sub set_programs_gcs_backend {
  set req.backend = F_programs_gcs;
  set req.http.x-nyt-backend = "programs_gcs";

  if (req.http.x-environment == "dev") {
    set req.http.x-gcs-bucket = "nyt-betaprog-dev-assets";
  } else if (req.http.x-environment == "stg") {
    set req.http.x-gcs-bucket = "nyt-betaprog-dev-assets";
  } else {
    set req.http.x-gcs-bucket = "nyt-betaprog-prd-assets";
  }
}
