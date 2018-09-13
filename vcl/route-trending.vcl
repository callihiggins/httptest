sub recv_route_trending {
    if (req.http.var-nyt-canonical-www-host) {
      if (   req.url ~ "^/trending/"
          || req.url ~ "^/trending?"
          || req.url ~ "^/trending$"
      ) {
          set req.http.x-nyt-route = "trending";
          // TODO: Once the backend is updated for Samizdat, swap
          // this out to projectvi_fe
          set req.http.x-nyt-backend = "projectvi_trending_fe";
          set req.http.var-nyt-error-retry = "false";
          set req.http.var-nyt-wf-auth = "true";
          set req.http.x--fastly-project-vi = "1";
          set req.http.var-nyt-send-gdpr = "true";
          set req.url = querystring.filter_except(req.url, "nytapp");
        }
    }
}

sub miss_pass_route_trending {
  if (req.http.x-nyt-route == "trending") {
    unset bereq.http.cookie;
  }
}
