sub recv_route_story {

    # stories only serve from canonical www host
    if (req.http.x-nyt-canonical-www-host == "true") {

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
          && (
              req.http.x--fastly-vi-test-group-story ~ "^[a]"
              || req.http.x--fastly-vi-story-opt == "1" // always in
              || req.url ~ "^/20[1-9][4-9]/\d+/\d+/opinion/" // 2014-future and opinion
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
        set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " vi-Incompatible", "vi-Incompatible");
        return (restart);
    }

    # if the response was from NYT5 but this is an OAK article
    # we restart the request and signal that this happened
    if (resp.http.x-cms-format == "oak") {
        set req.http.x-pre-restart-cms-format = "oak";
        unset resp.http.x-cms-format;
        set req.http.x-nyt-restart-reason = if (req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " Oak-content", "Oak-content");
        return (restart);
    }
}

sub hash_route_story {

  # cache variance for articles allocated to vi
  if (req.http.x-nyt-route == "vi-story") {
    set req.hash += req.http.x--fastly-vi-test-group-story;
  }


  # TODO: questioning if these two below hash mods need to exist..

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
