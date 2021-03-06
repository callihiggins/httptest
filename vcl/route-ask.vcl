sub recv_route_ask {
  if (req.url ~ "^/ask") {
    set req.http.x-nyt-route = "ask";
    set req.http.x-nyt-backend = "projectvi_fe";
    set req.http.var-nyt-error-retry = "false";
    set req.http.var-nyt-wf-auth = "true";
    set req.http.var-nyt-send-gdpr = "true";
    unset req.http.Authorization;

    call recv_post_method_restricted;
  }
}

sub miss_pass_route_ask {
  if (req.http.x-nyt-route == "ask") {
    unset bereq.http.cookie;
  }
}
