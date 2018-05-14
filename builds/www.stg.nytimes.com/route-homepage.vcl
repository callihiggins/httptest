sub recv_route_homepage {

    # homepage only serves from canonical hosts
    # all others go to legacy
    if (req.http.x-nyt-canonical-www-host == "true") {
    
        # NYT5 is the default HP route
        if (   req.url.path == "/" || req.url ~ "^/index.html"
        ) {
            set req.http.x-nyt-route = "homepage";
            set req.http.x-nyt-backend = "homepage_fe";
            set req.http.var-nyt-wf-auth = "true";
            unset req.http.x--fastly-project-vi;
            set req.http.var-nyt-send-gdpr = "true";
        }



        ##############################################################
        # Vi overrides home route based on allocation and opt-out
        # see vi-allocation.vcl
        ##############################################################
        if (
          # homepage
          # - in a test group and not opted out
          # - or internal traffic and not opted out
          # - or this is a shield pop and the edge pop allocated the user to vi
          #
          # TODO: Vi currently serves a 404 for "/index.html", NYT5 redirects it to "/" Fix this before 100% Vi
          #
          req.url.path == "/"
              && (
                (req.http.x--fastly-vi-test-group ~ "^[abdef]" && req.http.cookie:vi_www_hp_opt != "0")
                || req.http.cookie:vi_www_hp_opt == "1"
                || (req.http.x-nyt-internal-access == "1" && req.http.cookie:vi_www_hp_opt != "0")
                # this is set if this is a shield pop and the edge allocated vi
                || (req.http.x-nyt-shield-auth && req.http.x-nyt-vi-alloc-edge == "true")
              )
          ) {
          set req.http.x-nyt-route = "vi-homepage";
          set req.http.x-nyt-backend = "projectvi_fe";
          set req.http.var-nyt-wf-auth = "true";
          set req.http.x--fastly-project-vi = "1";
          set req.http.var-nyt-send-gdpr = "true";
        }
    }
}

sub hash_route_homepage {

  # if vi allocated, add hash parameters for cache variance
  if (req.http.x-nyt-route == "vi-homepage") {
      set req.hash += req.http.x-nyt-geo-hash;
      set req.hash += req.http.device_type;
      set req.hash += req.http.x-vi-ssr-www-hp;
  }
}
