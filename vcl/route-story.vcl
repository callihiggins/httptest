sub recv_route_story {
    # stories only serve from canonical www host and alpha host
    if (req.http.var-nyt-canonical-www-host == "true" || req.http.var-nyt-canonical-alpha-host == "true") {
      // Internationalized URLs https://jira.nyt.net/browse/DV-1731
      declare local var.internationalized_url BOOL;
      if (   req.url ~ "^/(a[fryz]|b[egns]|c[aksy]|d[ae]|e[lnotu]|f[abiory]|g[alnux]|h[eiruy]|i[dst]|j[av]|k[akmnou]|l[aitv]|m[gklnrst]|n[beln]|p[alst]|qu|r[mou]|s[aekloqrvwy]|t[aeghlrt]|u[krz]|vi|xh|yi|zh|zh-(CN|HK|TW|hans|hant)|zu)/"
          || req.url.path ~ "^/es/.*\.html$"
          || (  req.url.path ~ "^/es/$"
                  || req.url.path ~ "^/es/section/"
                  || req.url.path ~ "^/es/series/"
                  || req.url.path ~ "^/es/spotlight/"
                  || req.url.path ~ "^/es/news-event/"
                  || req.url.path ~ "^/es/column/"
              )
         ) {
        set var.internationalized_url = true;
      } else {
        set var.internationalized_url = false;
      }

      // These articles are explicitly opted IN to being served by Vi even though the date range they are in typically
      // would route to NYT5 or legacy backend. As the archive migration proceeds URLs can be removed from
      // the whitelist here.
      declare local var.vi_explicit_opt_in BOOL;
      if (
             req.url.path ~ "^/2006/01/22/fashion/sundaystyles/so-he-looked-like-dad-it-was-just-dinner-right.html$"
          || req.url.path ~ "^/2006/01/22/style/modern-love-so-he-looked-like-dad-it-was-just-dinner-right.html$"
          || req.url.path ~ "^/2008/01/13/style/modern-love-take-me-as-i-am-whoever-i-am.html$"
          || req.url.path ~ "^/2011/09/25/style/modern-love-sometimes-its-not-you-or-the-math.html$"
          || req.url.path ~ "^/2006/06/25/style/modern-love-what-shamu-taught-me-about-a-happy-marriage.html$"
          || req.url.path ~ "^/2011/08/21/style/modern-love-my-husband-is-now-my-wife.html$"
          || req.url.path ~ "^/2009/08/02/style/modern-love-those-arent-fighting-words-dear.html$"
          || req.url.path ~ "^/2009/05/17/style/modern-love-somewhere-inside-a-path-to-empathy.html$"
          || req.url.path ~ "^/2006/02/19/fashion/loved-and-lost-its-ok-especially-if-you-win.html$"
        ) {
        set var.vi_explicit_opt_in = true;
      } else {
        set var.vi_explicit_opt_in = false;
      }

      # default route for stories is NYT5
      if (  (req.url ~ "^/(18[5-9][0-9]|19[0-9][0-9]|20[0-9][0-9])/" // Route 1850-future
          || req.url ~ "^/(aponline|reuters)/" // wire sources
          || req.url ~ "^/blog/" // all blogposts
          || var.internationalized_url
          ) && req.url.path !~ "\.amp\.html$"
      ) {

        # Replace space with ? for malformed url's. https://jira.nyt.net/browse/WF-775
        set req.url = regsub(req.url, "\.html\%2520", "\.html?");


        set req.http.x-nyt-route = "article";
        set req.http.x-nyt-backend = "article_fe";
        set req.http.var-nyt-wf-auth = "true";
        set req.http.var-nyt-send-gdpr = "true";

        if (req.http.var-nyt-canonical-alpha-host != "true") {
          set req.url = querystring.filter_except(req.url, "nytapp");
        }

        unset req.http.Authorization;

        call recv_post_method_restricted;

        # `vi_story_opt` cookie - allows newsroom to force NYT5
        #  1 = force vi stories
        #  0 = opt out vi stories
        if (!req.http.x-vi-story-opt && req.http.cookie:vi_story_opt) {
          set req.http.x-vi-story-opt = req.http.cookie:vi_story_opt;
        } else { // if there is no opt-out value, default them to vi
          set req.http.x-vi-story-opt = "1";
        }

        ##############################################################
        # Vi overrides story route based on date range and allocation.
        ##############################################################
        # The articles that are potentially served by the publishing pipeline
        # are limited by a date range of between 1850 to 2005 and no earlier than 2013/01/01. This date is going
        # to be extended in the future to include older articles and the code will
        # be updated accordingly.
        if ((  req.url ~ "^/(aponline/|reuters/)?18[5-9][0-9]|19[0-9][0-9]|200[0-5]|20(1[3-9]|[2-9][0-9])"
            || var.internationalized_url
            || var.vi_explicit_opt_in
          )
          && req.url.path !~ "\.amp\.html$" // exclude amp
          && req.http.x-vi-story-opt != "0" // always out
        ) {
            # if the request was sent to VI and determined
            # to be Incompatible then we don't send to VI again
            if (req.http.var-nyt-vi-story-compatibility == "Incompatible") {
              set req.http.x-nyt-route = "article";
              set req.http.x-nyt-backend = "article_fe";
              set req.http.var-nyt-wf-auth = "true";
              set req.http.var-nyt-send-gdpr = "true";
              if (req.http.var-nyt-canonical-alpha-host != "true") {
                set req.url = querystring.filter_except(req.url, "nytapp");
              }
            } else {
              set req.http.x-nyt-route = "vi-story";
              set req.http.x-nyt-backend = "projectvi_fe";
              set req.http.var-nyt-error-retry = "false";
              set req.http.var-nyt-wf-auth = "true";
              set req.http.var-nyt-send-gdpr = "true";
              if (req.http.var-nyt-canonical-alpha-host != "true") {
                set req.url = querystring.filter_except(req.url, "nytapp");
              }
              call recv_route_vi_static_backup_gcs;
              call recv_abra_allocation;
            }

            call recv_bot_detection;
        }
      }
   }
}

sub recv_route_amp {
  // Route amp articles
  if ((req.http.var-nyt-canonical-www-host == "true"
        &&  (req.url ~ "^/(18[5-9][0-9]|19[0-9][0-9]|20[0-9][0-9])/" || req.url ~ "^/interactive")
        &&   req.url.path ~ "\.amp\.html$"
        )
      || req.url ~ "^/apple-news/"
      || (req.http.var-nyt-canonical-www-host == "true"
            && req.url ~ "^/(a[fryz]|b[egns]|c[aksy]|d[ae]|e[lnostu]|f[abiory]|g[alnux]|h[eiruy]|i[dst]|j[av]|k[akmnou]|l[aitv]|m[gklnrst]|n[beln]|p[alst]|qu|r[mou]|s[aekloqrvwy]|t[aeghlrt]|u[krz]|vi|xh|yi|zh|zh-(CN|HK|TW|hans|hant)|zu)/"
            && req.url.path ~ "\.amp\.html$"
         )
  ) {
    set req.http.x-nyt-route = "amp";
    set req.http.x-nyt-backend = "amp";
    set req.url = querystring.filter_except(req.url, "0p19G" + querystring.filtersep() + "isSwgTest");
    if (req.http.User-Agent ~ "DU-apple-news" && req.url ~ "^/apple-news/") {
      set req.http.var-nyt-force-pass = "true";
    } else if (client.ip !~ googlebot && client.ip !~ botify && req.http.x-nyt-nyhq-access != "1" && req.http.x-nyt-staging-only-access != "1") {
      // in supporting google's live-list fix, no longer bypass the fastly cache https://jira.nyt.net/browse/STORY-5114
      declare local var.amp_redirect_target STRING;
      set var.amp_redirect_target = "https://" + req.http.host + regsub(req.url, "\.amp\.html","\.html");
      error 755 var.amp_redirect_target;
    }
  }

  // Route live blog traffic to amp
  if (  (req.http.var-nyt-canonical-www-host == "true"
      || req.http.var-nyt-canonical-alpha-host == "true")
      && req.url ~ "^/live/2019/"
  ) {
    set req.http.x-nyt-route = "amp";
    set req.http.x-nyt-backend = "amp";
  }
}

sub miss_pass_route_amp {
  if (req.http.x-nyt-route == "amp") {
      if (req.http.var-nyt-env != "prd") {
          set bereq.http.host = "amp-dot-nyt-wfvi-dev.appspot.com";
      } else {
          set bereq.http.host = "amp-dot-nyt-wfvi-prd.appspot.com";
      }
  }
}

// This could also be 770 should it be?
sub error_755_amp_redirect {
  if (obj.status == 755) {
      set obj.http.Location = obj.response;
      set obj.status = 302;
      set obj.response = "Moved Temporarily";
      return(deliver);
  }
}

sub deliver_route_story_restart_indicators {

    if (req.http.x-nyt-route == "vi-story" || req.http.x-nyt-route == "article") {
        call deliver_bot_detection;
    }

    # if the response was not compatible with VI we
    # restart the request and signal that this happened
    if (resp.http.x-vi-compatibility == "Incompatible") {
        set req.http.var-nyt-vi-story-compatibility = "Incompatible";
        unset resp.http.x-vi-compatibility;
        set req.url = req.http.x-nyt-original-url;
        set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " vi-Incompatible", "vi-Incompatible");
        set req.http.var-nyt-surrogate-key = resp.http.var-nyt-surrogate-key;
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

  if (req.http.x-nyt-route == "vi-story" || req.http.x-nyt-route == "article") {
    set req.hash += req.http.x-vi-story-opt;

    // need to vary based on phone/mobile since some stories are OK on phones for vi
    // but should go to NYT5 on desktop or non-mobile
    if (req.http.device_type ~ "phone" && req.http.x-nyt-route == "vi-story") {
      set req.hash += "phone";
    } else {
      set req.hash += "non-phone";
    }

    # if a request was restarted from VI due to Incompatiblity
    # append to the hash to keep a separate key
    if (req.http.var-nyt-vi-story-compatibility) {
      set req.hash += req.http.var-nyt-vi-story-compatibility;
    }

    # vary on abra test allocation
    set req.hash += req.http.var-story-abtest-variation;
  }
}

sub fetch_route_story {

  if (req.http.x-nyt-route == "vi-story" || req.http.x-nyt-route == "article") {
    call fetch_bot_detection;
  }

  # remove x-varnishcacheduriation from non-2xx responses from NYT5
  # 404's were being cached for 900 seconds
  if (req.http.x-nyt-route == "article" && beresp.status > 299) {
    unset beresp.http.x-varnishcacheduration;
  }

  if (req.http.x-nyt-route == "vi-story" && beresp.status == 400) {
    set beresp.cacheable = true;
  }

  # if the response was from vi and incompatible
  # save off the Surrogate-Key so we can add it to the NYT5 cache object
  if (beresp.http.x-vi-compatibility == "Incompatible") {
    set beresp.http.var-nyt-surrogate-key = beresp.http.Surrogate-Key;
  }

  # if we restarted this transaction because it was incompatible with vi
  # add the Surrogate-Key we saved into the cache object
  if (req.http.var-nyt-vi-story-compatibility == "Incompatible") {
    set beresp.http.Surrogate-Key = req.http.var-nyt-surrogate-key;
  }
}

sub miss_pass_route_story {
  if (!req.backend.is_shield) {
    if (req.http.x-nyt-route == "article" || req.http.x-nyt-route == "vi-story") {
      unset bereq.http.cookie;
      call miss_pass_bot_detection;
    }
  }
}
