sub recv_route_weddings {
  if (req.url ~ "^/style/weddings/announcements") {
      set req.http.x-nyt-route = "vi-weddings";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-send-gdpr = "true";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.x--fastly-project-vi = "1";
      set req.url = querystring.remove(req.url);
  }
}

sub miss_pass_route_weddings {
  if (req.http.x-nyt-route == "vi-weddings") {
    unset bereq.http.cookie;
  }
}
