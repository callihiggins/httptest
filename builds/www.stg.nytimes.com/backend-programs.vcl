sub vcl_recv {
    if (req.http.host ~ "^(www-[a-z0-9]+\.)(dev\.|stg\.|)?nytimes.com$" || req.http.host ~ "^www\.(dev\.|stg\.|)?nytimes.com$") {

        if (req.url.path ~ "^/programs/[\-a-z0-9]+/public/") {

            set req.http.X-PageType = "programs-gcs";
            set req.http.x-nyt-backend = "programs_gcs";
            unset req.http.Cookie;
            unset req.http.X-Cookie;
            unset req.http.x-nyt-edition;
            unset req.http.x-nyt-s;
            unset req.http.x-nyt-wpab;
            #return(lookup);
        } else if (req.url.path ~ "^/programs/svc/shaq") {
            set req.http.X-PageType = "shaq-service";
            set req.http.x-nyt-backend = "shaq_svc";
            set req.http.x-nyt-force-pass = "true";
            #return(pass);
        } else if (req.url.path ~ "^/programs/" ) {
            set req.http.X-PageType = "programs-service";
            set req.http.x-nyt-backend = "programs_svc";
            unset req.http.Cookie;
            unset req.http.X-Cookie;
            #return(lookup);
        }
    }
}

sub vcl_pass {
    if (req.http.X-PageType == "programs-service") {
        call set_programs_web_backend;
    }

    if (req.http.X-PageType == "shaq-service") {
        call set_programs_shaq_backend;
    }

    if (req.http.X-PageType == "programs-gcs") {
        call set_programs_gcs_backend;
    }

}

sub vcl_miss {
    if (req.http.X-PageType == "programs-service") {
        call set_programs_web_backend;
    }

    if (req.http.X-PageType == "shaq-service") {
        call set_programs_shaq_backend;
    }

    if (req.http.X-PageType == "programs-gcs") {
        call set_programs_gcs_backend;
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

    if (req.http.x-environment == "dev") {
        set bereq.http.host = "ftu-dot-nyt-betaprog-dev.appspot.com";
    } else if (req.http.x-environment == "stg") {
        set bereq.http.host = "ftu-dot-nyt-betaprog-dev.appspot.com";
    } else {
        set bereq.http.host = "ftu-dot-nyt-betaprog-prd.appspot.com";
    }

}

sub set_programs_gcs_backend {
  # Configure access to Cloud Storage
  if (req.http.x-environment == "dev") {
    set bereq.http.host = "nyt-betaprog-dev-assets.storage.googleapis.com";
  } else if (req.http.x-environment == "stg") {
    set bereq.http.host = "nyt-betaprog-dev-assets.storage.googleapis.com";
  } else {
    set bereq.http.host = "nyt-betaprog-prd-assets.storage.googleapis.com";
  }

}

sub set_programs_shaq_backend {

    if (req.http.x-environment == "dev") {
        set bereq.http.host = "shaq-dot-nyt-betaprog-dev.appspot.com";
    } else if (req.http.x-environment == "stg") {
        set bereq.http.host = "shaq-dot-nyt-betaprog-dev.appspot.com";
    } else {
        set bereq.http.host = "shaq-dot-nyt-betaprog-prd.appspot.com";
    }

    set bereq.url = regsub(bereq.url, "^/programs/svc/shaq/(.*)", "/svc/shaq/\1");

}
