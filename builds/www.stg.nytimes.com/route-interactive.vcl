sub recv_route_interactive {
  // interactive years 2014-forever are served by Vi
  // including all variants, canonical and .(embedded|mobile|app)\.html
  if (req.url ~ "^/interactive/20(1[4-9]|[2-9][0-9])/") {
    set req.http.x-nyt-route = "vi-interactive";
    set req.http.var-nyt-wf-auth = "true";
    set req.http.x--fastly-project-vi = "1";
    set req.http.X-SendGDPR = "true";
    set req.http.x-nyt-backend = "projectvi_fe";
  }
}
