sub recv_route_timeswire {
  if (req.url ~ "^/timeswire(\/?)$") {
      set req.http.x-nyt-route = "vi-timeswire";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";
      set req.http.x--fastly-project-vi = "1";
      set req.url = querystring.remove(req.url);
  }

}

sub miss_pass_route_timeswire {
  if (req.http.x-nyt-route == "vi-timeswire") {
    unset bereq.http.cookie;
  }
}