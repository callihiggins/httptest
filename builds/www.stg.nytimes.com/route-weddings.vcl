sub recv_route_weddings {
  if (req.url ~ "^/style/weddings/announcements") {
      set req.http.X-PageType = "vi-weddings";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.x-nyt-wf-auth = "true";
      set req.http.x--fastly-project-vi = "1";
  }
}
