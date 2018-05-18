sub recv_route_story {

    # stories only serve from canonical www host
    if (req.http.var-nyt-canonical-www-host == "true") {

      # default route for stories is NYT5
      if (   req.url ~ "^/(18[5-9][0-9]|19[0-9][0-9]|20[0-9][0-9])/" // Route 1850-future
          || req.url ~ "^/(aponline|reuters)/" // wire sources
          || req.url ~ "^/blog/" // all blogposts
      ) {
          set req.http.x-nyt-route = "article";
          set req.http.x-nyt-backend = "article_fe";
          set req.http.var-nyt-wf-auth = "true";
          unset req.http.x--fastly-project-vi;
          set req.http.var-nyt-send-gdpr = "true";

        ##############################################################
        # Vi overrides story route based on date range and allocation.
        # see vi-allocation.vcl
        ##############################################################
        #
        # The articles that are potentially served by the publishing pipeline
        # are limited by a date range of no earlier than 2014/01/01. This date is going
        # to be extended in the future to include older articles and the code will
        # be updated accordingly.
        if (
             req.url ~ "^/(aponline/|reuters/)?201[4-9]"
          && req.url.path !~ "\.amp\.html$" // exclude amp
          && req.url.path != "/2018/05/18/us/school-shooting-santa-fe-texas.html"
          && (
              req.http.x--fastly-vi-test-group-story ~ "^[a]"
              || req.http.x--fastly-vi-story-opt == "1" // always in
              || req.url ~ "^/20[1-9][4-9]/\d+/\d+/opinion/"
              # this is set if this is a shield pop and the edge allocated vi
              || (req.http.x-nyt-shield-auth && req.http.x-nyt-vi-alloc-edge == "true")
          )
          && req.http.x--fastly-vi-story-opt != "0" // always out
        ) {
            # if the request was sent to VI and determined
            # to be Incompatible then we don't send to VI again
            if (req.http.x-pre-restart-status == "Incompatible") {
                set req.http.x-nyt-route = "article";
                set req.http.x-nyt-backend = "article_fe";
                set req.http.var-nyt-wf-auth = "true";
                unset req.http.x--fastly-project-vi;
                set req.http.var-nyt-send-gdpr = "true";
            } else {
              set req.http.x-nyt-route = "vi-story";
              set req.http.x-nyt-backend = "projectvi_fe";
              set req.http.var-nyt-wf-auth = "true";
              set req.http.x--fastly-project-vi = "1";
              set req.http.var-nyt-send-gdpr = "true";
            }
        } else {
            # if the request was sent to NYT5 and determined
            # to be an OAK article don't send to NYT5 again
            if (req.http.x-pre-restart-cms-format == "oak") {
              set req.http.x-nyt-route= "vi-story";
              set req.http.x-nyt-backend = "projectvi_fe";
              set req.http.var-nyt-wf-auth = "true";
              set req.http.x--fastly-project-vi = "1";
              set req.http.var-nyt-send-gdpr = "true";
            } else {
                set req.http.x-nyt-route = "article";
                set req.http.x-nyt-backend = "article_fe";
                set req.http.var-nyt-wf-auth = "true";
                unset req.http.x--fastly-project-vi;
                set req.http.var-nyt-send-gdpr = "true";
            }
         }
      }
   }
}

sub deliver_route_story_restart_indicators {

    # if the response was not compatible with VI we
    # restart the request and signal that this happened
    if (resp.http.x-vi-compatibility == "Incompatible") {
        set req.http.x-pre-restart-status = "Incompatible";
        unset resp.http.x-vi-compatibility;
        set req.url = req.http.X-OriginalUri;
        set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " vi-Incompatible", "vi-Incompatible");
        set req.http.var-nyt-surrogate-key = resp.http.var-nyt-surrogate-key;
        return (restart);
    }

    # if the response was from NYT5 but this is an OAK article
    # we restart the request and signal that this happened
    if (resp.http.x-cms-format == "oak") {
        set req.http.x-pre-restart-cms-format = "oak";
        unset resp.http.x-cms-format;
        set req.url = req.http.X-OriginalUri;
        set req.http.x-nyt-restart-reason = if (req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " Oak-content", "Oak-content");
        return (restart);
    }
}

sub deliver_route_story_us_cookie {
    # if the client is in the United Sates and we determine this is a story page
    # set a cookie indicating this is a user in the United States
    # otherwise, set a cookie indicating the user is not in the United States
    if (req.http.x-nyt-country == "US" && req.http.x-nyt-route == "vi-story") {
        add resp.http.Set-Cookie =
            "nyt-us=1; "+
            "Expires=" + time.add(now, 6h) + "; "+
            "Path=/; "+
            "Domain=.nytimes.com";
    } else if (req.http.x-nyt-route == "vi-story") {
        add resp.http.Set-Cookie =
            "nyt-us=0; "+
            "Expires=" + time.add(now, 6h) + "; "+
            "Path=/; "+
            "Domain=.nytimes.com";
    }
}

sub hash_route_story {

  # if an article was allocated to vi or incompatible or even oak
  # the content the end user sees for the URL does not vary based on any vi alloc
  # so we will ALWAYS use the same cache hash for those URLs as there is no variance
  # for these forced situations
  # we need to keep the hash in sync between the shield and edge for hit ratio

  if (   req.http.x-nyt-route == "vi-story"              # allocated to vi
      || req.http.x-nyt-vi-alloc-edge == "true"          # allocated to vi at the edge in a shielding scenario
      || req.http.x-pre-restart-cms-format == "oak"      # restarted due to oak content
      || req.http.x-pre-restart-status == "Incompatible" # restarted due to vi incompatibility
      ) {

    set req.hash += req.http.x--fastly-vi-test-group-story;
  }

  # if a request was restarted from VI due to Incompatiblity
  # append to the hash to keep a separate key
  if (req.http.x-pre-restart-status){
   set req.hash += req.http.x-pre-restart-status;
  }

  # if a request was restarted from NYT5 due to being an OAK Article
  # append to the hash to keep a separate key
  if (req.http.x-pre-restart-cms-format){
   set req.hash += req.http.x-pre-restart-cms-format;
  }
}

sub fetch_route_story {
  # remove x-varnishcacheduriation from non-2xx responses from NYT5
  # 404's were being cached for 900 seconds
  if (req.http.x-nyt-route == "article" && beresp.status > 299) {
    unset beresp.http.x-varnishcacheduration;
  }

  # if the response was from vi and incompatible
  # save off the Surrogate-Key so we can add it to the NYT5 cache object
  if (beresp.http.x-vi-compatibility == "Incompatible") {
    set beresp.http.var-nyt-surrogate-key = beresp.http.Surrogate-Key;
  }

  # if we restarted this transaction because it was incompatible with vi
  # add the Surrogate-Key we saved into the cache object
  if (req.http.x-pre-restart-status == "Incompatible") {
    set beresp.http.Surrogate-Key = req.http.var-nyt-surrogate-key;
  }

}
