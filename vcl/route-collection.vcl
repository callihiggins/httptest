sub recv_route_collection {
  if (   req.url ~ "^/by/"
      || req.url ~ "^/reviews/dining/map"
      || req.url ~ "^/reviews?"
      || req.url ~ "^/reviews$"
      || req.url ~ "^/topic/organization/"
      || req.url ~ "^/upshot"
  ) {
      set req.http.x-nyt-route = "collection";
      set req.http.x-nyt-backend = "collection_fe";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";

      if (req.http.var-nyt-canonical-alpha-host != "true") {
        set req.url = querystring.filter_except(req.url, "nytapp");
      }

      unset req.http.Authorization;

      call recv_post_method_restricted;
  }

  if (req.url ~ "^/saved/" || req.url ~ "^/saved\?" || req.url ~ "^/saved$") {
    if (req.http.var-nyt-env == "prd") {
      set req.http.x-nyt-route = "collection";
      set req.http.x-nyt-backend = "collection_fe";
    } else {
      set req.http.x-nyt-route = "vi-collection";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-error-retry = "false";
    }
    set req.http.var-nyt-wf-auth = "true";
    set req.http.var-nyt-send-gdpr = "true";
    if (req.http.var-nyt-canonical-alpha-host != "true") {
      set req.url = querystring.filter_except(req.url, "nytapp");
    }
    unset req.http.Authorization;
    call recv_post_method_restricted;
  }

  # route selected collections to VI first.
  if (   (req.url ~ "^/column/" && req.url !~ "^/column/the-dispatch" && req.url !~ "^/column/the-weekly" && req.url !~ "^/column/theweekly")
      || req.url ~ "^/issue/"
      || req.url ~ "^/topic/subject/"
      || req.url ~ "^/topic/destination/"
      || req.url ~ "^/topic/company"
      || req.url ~ "^/topic/person/"
      || req.url ~ "^/series/"
      || req.url ~ "^/news-event/"
      || (req.url ~ "^/section/" && req.url !~ "^/section/the-weekly")
      || req.url ~ "^/spotlight/"
      || req.url ~ "^/reviews/theater"
      || req.url ~ "^/reviews/movies"
      || (req.url ~ "^/reviews/dining" && req.url !~ "^/reviews/dining/map")
  ) {
    # if the request was sent to VI and determined
    # to be Incompatible then we don't send to VI again
    if (req.http.x-pre-restart-status == "Incompatible") {
        set req.http.x-nyt-route = "collection";
        set req.http.x-nyt-backend = "collection_fe";
        set req.http.var-nyt-wf-auth = "true";
        set req.http.var-nyt-send-gdpr = "true";

        if (req.http.var-nyt-canonical-alpha-host != "true") {
          set req.url = querystring.filter_except(req.url, "nytapp");
        }

        unset req.http.Authorization;
        call recv_post_method_restricted;
    } else {
      set req.http.x-nyt-route = "vi-collection";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-error-retry = "false";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";

      if (req.http.var-nyt-canonical-alpha-host != "true") {
        set req.url = querystring.filter_except(req.url, "nytapp");
      }

      unset req.http.Authorization;

      call recv_post_method_restricted;
    }

    # RealEstate: Route to the Real Estate backend
    if (req.url ~ "^/section/realestate/commercial") {
      if (req.http.var-nyt-env == "dev") {
        set req.http.x-nyt-backend = "realestate_fe";
      } else {
        set req.http.x-nyt-backend = "realestate_fe_vi";
      }
    }
  }
}

sub deliver_route_collection_restart_indicators {
    # if the response was not compatible with VI we
    # restart the request and signal that this happened
    if (resp.http.x-vi-collection-compatibility == "Incompatible") {
        set req.http.x-pre-restart-status = "Incompatible";
        unset resp.http.x-vi-collection-compatibility;
        set req.url = req.http.x-nyt-original-url;
        set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " vi-collection-Incompatible", "vi-collection-Incompatible");
        set req.http.var-nyt-surrogate-key = resp.http.var-nyt-surrogate-key;
        return (restart);
    }
}

sub hash_route_collection {
  # if a request was restarted from VI due to Incompatiblity
  # append to the hash to keep a separate key
  if (req.http.x-pre-restart-status){
    set req.hash += req.http.x-pre-restart-status;
  }
}

sub fetch_route_collection {
  # remove x-varnishcacheduriation from non-2xx responses from NYT5
  # 404's were being cached for 900 seconds
  if (req.http.x-nyt-route == "collection" && beresp.status > 299) {
    unset beresp.http.x-varnishcacheduration;
  }

  if (req.http.x-nyt-route == "vi-collection" && beresp.status == 400) {
    set beresp.cacheable = true;
  }

  # if the response was from vi and incompatible
  # save off the Surrogate-Key so we can add it to the NYT5 cache object
  if (beresp.http.x-vi-collection-compatibility == "Incompatible") {
    set beresp.http.var-nyt-surrogate-key = beresp.http.Surrogate-Key;
  }

  # if we restarted this transaction because it was incompatible with vi
  # add the Surrogate-Key we saved into the cache object
  if (req.http.x-pre-restart-status == "Incompatible") {
    set beresp.http.Surrogate-Key = req.http.var-nyt-surrogate-key;
  }
}

sub miss_pass_route_collection {
  if (req.http.x-nyt-route == "collection" || req.http.x-nyt-route == "vi-collection" ) {
    unset bereq.http.cookie;
  }
}
