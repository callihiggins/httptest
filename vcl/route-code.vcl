sub recv_route_code {
  if (req.url ~ "^/code/"
        || req.url ~ "^/code?"
        || req.url ~ "^/code$"
    ) {
      set req.http.x-nyt-route = "vi-code";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-error-retry = "false";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";
      unset req.http.Authorization;

      call recv_route_code_filter_querystring;
  }
}

sub miss_pass_route_code {
  if (req.http.x-nyt-route == "vi-code") {
    unset bereq.http.cookie;
  }
}

sub recv_route_code_filter_querystring {
  set req.url = querystring.filter_except(req.url, "gift_code");
}
