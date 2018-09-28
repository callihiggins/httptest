sub recv_route_paidpost {
  // VI/NYT5 routing for paidpost
  // first let's make sure we've got anything to do with paidpost
  if( ( (req.http.var-nyt-canonical-www-host == "true" && req.url ~ "^/paidpost/") ||
    (req.http.host ~ "^paidpost([\-a-z0-9]+)?\.nytimes.com$") ) &&
    req.url.ext == "html")
    {
        // now let's set our base values for either route
        set req.http.var-nyt-send-gdpr = "true";
        set req.http.var-nyt-wf-auth = "true";
        set req.url = querystring.remove(req.url);
        unset req.http.Authorization;
        call recv_post_method_restricted;

        if (req.http.var-nyt-canonical-www-host == "true") {

            // we're in VI land
            set req.http.x-nyt-route = "vi-paidpost";
            set req.http.x-nyt-backend = "projectvi_fe";
            set req.http.var-nyt-error-retry = "false";

        } else {

            // handle the remainder which should be prod
            set req.http.x-nyt-route = "paidpost";
            set req.http.x-nyt-backend = "paidpost_fe";

        }
    }
}

sub miss_pass_route_paidpost {
  if (req.http.x-nyt-route == "paidpost" || req.http.x-nyt-route == "vi-paidpost") {
    unset bereq.http.cookie;
  }
  if (req.http.x-nyt-route == "vi-paidpost" && !req.backend.is_shield) {
    if (req.http.var-nyt-env == "dev" || req.http.var-nyt-env == "stg") {
        set bereq.http.host = "www." + req.http.var-nyt-env + ".nytimes.com";
    } else {
        set bereq.http.host = "www.nytimes.com";
    }
    if(req.url !~ "^/paidpost/") {
        set bereq.url = "/paidpost" + bereq.url;
    }
  }
}
