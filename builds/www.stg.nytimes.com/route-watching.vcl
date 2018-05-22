sub recv_route_watching {

  if (req.http.var-nyt-canonical-www-host) {
      if (   req.url ~ "^/watching$"
          || req.url ~ "^/watching\?"
          || req.url ~ "^/watching/"
          || req.url ~ "^\/\d{4}\/\d{2}\/\d{2}\/watching\/"
      ) {
          if (req.url ~ "^/watching/api/users/") {
              set req.http.x-nyt-route = "watching-nocache";
          } else {
              set req.http.x-nyt-route = "watching";
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
  if (req.http.x-nyt-route == "watching") {
    unset bereq.http.cookie;
  }
}
