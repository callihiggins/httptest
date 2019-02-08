sub recv_route_programs {
    if (req.http.var-nyt-canonical-www-host) {

        if (req.url.path ~ "^/programs/[\-a-z0-9]+/public/" || req.url.path ~ "^/programs/public/") {

            set req.http.x-nyt-route = "programs-gcs";
            set req.http.x-nyt-backend = "gcs_origin";
            set req.http.var-nyt-send-gdpr = "true";
        } else if (req.url.path ~ "^/programs/svc/shaq") {
            set req.http.x-nyt-route = "shaq-service";
            set req.http.x-nyt-backend = "shaq_svc";
            set req.http.var-nyt-force-pass = "true";
            set req.http.var-nyt-send-gdpr = "true";
        } else if (req.url.path ~ "^/programs/") {
            set req.http.x-nyt-route = "programs-service";
            set req.http.x-nyt-backend = "programs_svc";
            set req.http.var-nyt-send-gdpr = "true";

            # manipulate query string parameters per environment as follows:
            # - prd: remove all
            # - stg: filter all except for the "buildId" param
            # - dev: keep all
            if (req.http.var-nyt-env == "stg") {
                set req.url = querystring.filter_except(req.url, "buildId");
            } else if (req.http.var-nyt-env == "prd") {
                set req.url = querystring.remove(req.url);
            }
        }
    }
}

sub miss_pass_route_programs {
    if (req.http.x-nyt-route == "programs-service") {
        unset bereq.http.cookie;
        call set_programs_web_host;
    }

    if (req.http.x-nyt-route == "shaq-service") {
        call set_programs_shaq_host;
    }

    if (req.http.x-nyt-route == "programs-gcs") {
        unset bereq.http.cookie;
        call miss_pass_set_bucket_auth_headers;
    }
}

sub deliver_programs_api_version {
    if (req.http.x-nyt-route == "programs-service") {
        set resp.http.X-API-Version = "PS";
    }
}

sub set_programs_web_host {

    if (req.http.var-nyt-env == "dev") {
        set bereq.http.host = "ftu-dot-nyt-betaprog-dev.appspot.com";
    } else if (req.http.var-nyt-env == "stg") {
        set bereq.http.host = "ftu-dot-nyt-betaprog-dev.appspot.com";
    } else {
        set bereq.http.host = "ftu-dot-nyt-betaprog-prd.appspot.com";
    }

}

sub set_programs_shaq_host {

    if (req.http.var-nyt-env == "dev") {
        set bereq.http.host = "shaq-dot-nyt-betaprog-dev.appspot.com";
    } else if (req.http.var-nyt-env == "stg") {
        set bereq.http.host = "shaq-dot-nyt-betaprog-dev.appspot.com";
    } else {
        set bereq.http.host = "shaq-dot-nyt-betaprog-prd.appspot.com";
    }

    set bereq.url = regsub(bereq.url, "^/programs/svc/shaq/(.*)", "/svc/shaq/\1");

}
