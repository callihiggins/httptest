sub recv_route_ask {
  if (req.url ~ "^/ask" && req.http.var-nyt-env != "prd") {
    set req.http.x-nyt-route = "ask";
    set req.http.x-nyt-backend = "projectvi_fe";
    set req.http.var-nyt-wf-auth = "true";
    set req.http.var-nyt-send-gdpr = "true";
    set req.http.x--fastly-project-vi = "1";
  }
}
