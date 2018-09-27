sub recv_route_get_started {
  if (   req.url ~ "^/get-started/"
        || req.url ~ "^/get-started?"
        || req.url ~ "^/get-started$"
    ) {
      set req.http.x-nyt-route = "vi-get-started";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-error-retry = "false";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";
      unset req.http.Authorization;

      call recv_post_method_restricted;
  }
}

sub miss_pass_route_get_started {
  if (req.http.x-nyt-route == "vi-get-started") {
    unset bereq.http.cookie;
  }
}
