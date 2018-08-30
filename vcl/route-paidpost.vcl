sub recv_route_paidpost {
  // paidpost stg/dev moving to VI, prd still remains within nyt5 for the time being
  if (req.http.host ~ "^paidpost([\-a-z0-9]+)?\.(dev\.|stg\.)nytimes.com$"
      && req.url.ext == "html") {
      set req.http.x-nyt-route = "vi-paidpost";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.x--fastly-project-vi = "1";
      set req.http.var-nyt-send-gdpr = "true";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-error-retry = "false";
      set req.url = querystring.remove(req.url);
      unset req.http.Authorization;

      call recv_post_method_restricted;
  } else if (req.http.host ~ "^paidpost([\-a-z0-9]+)?\.nytimes.com$"
      && req.url.ext == "html") {
      set req.http.x-nyt-route = "paidpost";
      set req.http.x-nyt-backend = "paidpost_fe";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";
      set req.url = querystring.remove(req.url);
      unset req.http.Authorization;
  }
}

sub miss_pass_route_paidpost {
  if (req.http.x-nyt-route == "paidpost" || req.http.x-nyt-route == "vi-paidpost") {
    unset bereq.http.cookie;
  }
  if (req.http.x-nyt-route == "vi-paidpost") {
    set bereq.url = "/paidpost" + bereq.url;
  }
}
