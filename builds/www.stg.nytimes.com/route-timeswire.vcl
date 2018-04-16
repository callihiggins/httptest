sub recv_route_timeswire {
  if (req.url ~ "^/timeswire(\/?)$") {
      set req.http.X-PageType = "vi-timeswire";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.x-nyt-wf-auth = "true";
      set req.http.x--fastly-project-vi = "1";
  }

}
