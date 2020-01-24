sub recv_route_weekender {
  // weekender application
    if (req.url ~ "^/weekender(\/?)$") {
        set req.http.x-nyt-route = "vi-weekender";
        set req.http.x-nyt-backend = "projectvi_fe";
        set req.http.var-nyt-error-retry = "false";
        set req.http.var-nyt-wf-auth = "true";
        set req.http.var-nyt-send-gdpr = "true";
        set req.url = querystring.remove(req.url);
        unset req.http.Authorization;

        call recv_post_method_restricted;
    }
}

sub miss_pass_route_weekender {
    if (req.http.x-nyt-route == "vi-weekender") {
        unset bereq.http.cookie;
    }
}