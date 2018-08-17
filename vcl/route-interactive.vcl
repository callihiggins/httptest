sub recv_route_interactive {
  // interactive years 2014-forever are served by Vi
  // including all variants, canonical and .(embedded|mobile|app)\.html
  if (req.url ~ "^/interactive/magazine/masthead.html" ||
      req.url ~ "^/interactive/20(1[4-9]|[2-9][0-9])/") {
    set req.http.x-nyt-route = "vi-interactive";
    set req.http.var-nyt-wf-auth = "true";
    set req.http.x--fastly-project-vi = "1";
    set req.http.var-nyt-send-gdpr = "true";
    set req.http.x-nyt-backend = "projectvi_fe";
    set req.http.var-nyt-error-retry = "false";
    set req.url = querystring.remove(req.url);
  }
}

sub miss_pass_route_interactive {
  if (req.http.x-nyt-route == "vi-interactive") {
    unset bereq.http.cookie;
  }
}

sub fetch_route_interactive {
  if (req.http.x-nyt-route == "vi-interactive" && beresp.status == 400) {
    set beresp.cacheable = true;
  }
}
