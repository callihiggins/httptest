sub recv_route_watching {

  if (req.http.var-nyt-canonical-www-host) {
      if (   req.url ~ "^/watching$"
          || req.url ~ "^/watching\?"
          || req.url ~ "^/watching/"
          || req.url ~ "^\/\d{4}\/\d{2}\/\d{2}\/watching\/"
      ) {
          # set gdpr cookie on this route
          set req.http.var-nyt-send-gdpr = "true";

          if (req.url ~ "^/watching/api/users/") {
              set req.http.x-nyt-route = "watching-nocache";
          } else {
              set req.http.x-nyt-route = "watching";
              call recv_route_watching_filter_querystring;
          }
          set req.http.x-nyt-backend = "beta_watching";
          set req.http.var-nyt-send-gdpr = "true";

          if (req.http.x-nyt-route == "watching-nocache") {
              set req.http.var-nyt-force-pass = "true";
          }
      }
  }
}

sub deliver_watching_api_version {
    if (req.http.x-nyt-route ~ "^watching") {
        set resp.http.X-API-Version = "W2";
    }
}

sub miss_pass_route_watching {
    # host header for gae route
    if (req.http.x-nyt-route == "watching") {
        if (req.http.var-nyt-env == "prd") {
            set bereq.http.host = "watching-dot-nyt-watching-prd.appspot.com";
        } else {
            set bereq.http.host = "watching-dot-nyt-watching-dev.appspot.com";
        }

        unset bereq.http.cookie;
    }
}

sub recv_route_watching_filter_querystring {
  set req.url = querystring.filter_except(req.url,
      "genre" + querystring.filtersep() +
      "ids[]" + querystring.filtersep() +
      {"ids%5B%5D"} + querystring.filtersep() +
      "mood" + querystring.filtersep() +
      "q" + querystring.filtersep() +
      "services[]" + querystring.filtersep() +
      {"services%5B%5D"} + querystring.filtersep() +
      "sub_genre" + querystring.filtersep() +
      "type");
}
