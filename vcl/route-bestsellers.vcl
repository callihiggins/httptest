sub recv_route_bestsellers {
  // Route bestseller application on dev/stg to Vi
  if (req.http.var-nyt-env != "prd") {
    if (   req.url ~ "^/books/best-sellers/"
        || req.url ~ "^/books/best-sellers?"
        || req.url ~ "^/books/best-sellers$"
    ) {
      set req.http.x-nyt-route = "vi-bestsellers";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-error-retry = "false";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";
      set req.url = querystring.remove(req.url);
      unset req.http.Authorization;

      call recv_post_method_restricted;
    }
  }
}

sub miss_pass_route_bestsellers {
  if (req.http.x-nyt-route == "vi-bestsellers") {
    unset bereq.http.cookie;
  }
}
