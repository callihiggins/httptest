sub recv_route_timeswire {
  if (req.url ~ "^/timeswire(\/?)$") {
      set req.http.x-nyt-route = "vi-timeswire";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";
      set req.http.x--fastly-project-vi = "1";
  }

}

sub miss_pass_route_timeswire {
  if (req.http.x-nyt-route == "vi-timeswire") {
    unset bereq.http.cookie;
  }
}
