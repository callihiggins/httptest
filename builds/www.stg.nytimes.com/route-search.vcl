sub recv_route_search {
  if (req.url ~ "^/search") {
      set req.http.x-nyt-route = "vi-search";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.x-nyt-wf-auth = "true";
      set req.http.x--fastly-project-vi = "1";
  }
}
