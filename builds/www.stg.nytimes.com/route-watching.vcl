sub recv_route_watching {

  if (req.http.x-nyt-canonical-www-host) {
      if (   req.url ~ "^/watching$"
          || req.url ~ "^/watching\?"
          || req.url ~ "^/watching/"
          || req.url ~ "^\/\d{4}\/\d{2}\/\d{2}\/watching\/"
      ) {
          if (req.url ~ "^/watching/api/users/") {
              set req.http.X-PageType = "watching-nocache";
          } else {
              set req.http.X-PageType = "watching";
          }
          set req.backend = F_beta_watching;
          set req.http.x-nyt-backend = "beta_watching";
          unset req.http.x-nyt-edition;
          unset req.http.x-nyt-s;
          unset req.http.x-nyt-wpab;

          if (req.http.X-PageType == "watching-nocache") {
              set req.http.x-nyt-force-pass = "true";
          }
      }
  }
}

sub hash_route_watching {
    if (req.http.X-PageType == "watching-nocache") {
        if (! req.http.Cookie && req.http.X-Cookie) {
            set req.http.Cookie = req.http.X-Cookie;
            unset req.http.X-Cookie;
        }
    }
}

sub deliver_watching_api_version {
    if (req.http.X-PageType ~ "^watching") {
        set resp.http.X-API-Version = "W2";
    }
}