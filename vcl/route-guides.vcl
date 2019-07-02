sub recv_route_guides {
    if (   req.url ~ "^/well/"
        || req.url ~ "^/guides/"
        || req.url.path == "/guides"
    ) {
        set req.http.x-nyt-route = "guides";
        set req.http.x-nyt-backend = "beta_guides";
        set req.http.var-nyt-send-gdpr = "true";

        if (req.url ~"^/guides/gifts/") {
            # For Gift Guides, pass category and price params to back-end:
            set req.url = querystring.filter_except(req.url,
                "category" + querystring.filtersep() +
                "price");
        } else {
          # manipulate query string parameters per environment as follows:
          # - prd: remove all
          # - stg: filter all except for the "SCOUT_API_HOST"
          # - dev: keep all
          if (req.http.var-nyt-env == "stg") {
            set req.url = querystring.filter_except(req.url, "SCOUT_API_HOST");
          } else if (req.http.var-nyt-env == "prd") {
            # Remove query params for all other routes:
            set req.url = querystring.remove(req.url);
          }
        }


    }
}

sub miss_pass_route_guides {

    unset bereq.http.cookie;

    if (req.http.x-nyt-route == "guides") {
        call set_guides_frontend_host;
    }
}

sub set_guides_frontend_host {
    if (req.http.var-nyt-env == "dev") {
        set bereq.http.host = "frontend.guides.stg.nyt.net";
    } else if (req.http.var-nyt-env == "stg") {
        set bereq.http.host = "frontend.guides.stg.nyt.net";
    } else {
        set bereq.http.host = "frontend.guides.prd.nyt.net";
    }
}
