sub recv_route_alpha {
  if (
      req.http.var-nyt-canonical-alpha-host == "true"
      && req.http.x-nyt-route != "vi-assets"
      && (req.http.x-nyt-nyhq-access == "1" || req.http.x-nyt-staging-only-access == "1")
    ) {
    // Add preview ACL

    // *.preview.nytimes.com and *.test.nytimes.com don't support https (not in certificate), so don't redirect
    if (req.http.host ~ "\.preview\.") {
      // Set header for Cloud Endpoints
      set req.http.X-Api-Key = table.lookup(origin_auth_keys, "ce_api_key_prd");
      set req.http.x-nyt-backend = "alpha_preview";
      set req.http.var-nyt-force-pass = "true";
      set req.http.var-skip-ssl = "true";
    }

    if (req.http.host ~ "\.test\.") {
      set req.http.X-Api-Key = table.lookup(origin_auth_keys, "ce_api_key_dev");
      set req.http.x-nyt-backend = "alpha_test";
      set req.http.var-nyt-force-pass = "true";
      set req.http.var-skip-ssl = "true";
    }

    // redirect to https always
    if (req.http.var-skip-ssl != "true" && !req.http.Fastly-SSL) {
      set req.http.X-Redirect-URL = "https://" + req.http.host + req.url;
      unset req.http.var-skip-ssl;
      error 770 req.http.X-Redirect-Url;
    }

    if (req.http.var-nyt-env == "dev") {
      set req.http.X-Api-Key = table.lookup(origin_auth_keys, "ce_api_key_dev");
      set req.http.x-nyt-backend = "alpha_fe";
    } else if (req.http.var-nyt-env == "stg") {
      set req.http.X-Api-Key = table.lookup(origin_auth_keys, "ce_api_key_dev");
      set req.http.x-nyt-backend = "alpha_fe";
    } else {
      set req.http.X-Api-Key = table.lookup(origin_auth_keys, "ce_api_key_prd");
      set req.http.x-nyt-backend = "alpha_fe";
    }

    # use a test backend for alpha.test, targeted briefings needs this
    if (req.http.host == "alpha-test.stg.nytimes.com" || req.http.host == "apple-test.dev.nytimes.com"){
      set req.http.x-nyt-backend = "alpha_test";
    }

    if (   req.url ~ "^/column/"
        || req.url ~ "^/issue/"
        || req.url ~ "^/series/"
        || req.url ~ "^/news-event/"
        || req.url ~ "^/section/"
        || req.url ~ "^/spotlight/"
    ) {
      set req.http.x-nyt-route = "collection";
    }

    if (req.url ~ "^/.info") {
      set req.http.var-nyt-wf-auth = "true";
      set req.http.x-nyt-route = "vi-info";
    }

    // dev
    if (req.http.host == "apple.dev.nytimes.com" || req.http.host == "alpha.dev.nytimes.com") {
      set req.http.var-nyt-force-pass = "true";
      set req.http.x-nyt-backend = "alpha_fe";
    }

    // preview
    if (req.http.host ~ "^alpha-preview" || req.http.host ~ "^apple-preview" ) {
      # if the request was sent to VI and determined
      # to be Incompatible then we don't send to VI again
      if (req.http.x-pre-restart-status == "Incompatible") {
        set req.http.var-nyt-wf-auth = "true";
        set req.http.var-nyt-send-gdpr = "true";
        unset req.http.Authorization;

        if (req.http.x-nyt-route == "collection") {
          set req.http.x-nyt-backend = "collection_fe";
        } else {
          set req.http.x-nyt-backend = "article_fe";
        }
      } else {
        set req.http.x-nyt-backend = "alpha_preview";
        set req.http.var-nyt-force-pass = "true";
      }
    }

    // Dont cache any pages that have this header
    if (req.http.x-nyt-vi-nocache == "true") {
      set req.http.var-nyt-force-pass = "true";
    }

    if (req.request != "HEAD" && req.request != "GET" && req.request != "FASTLYPURGE") {
      set req.http.var-nyt-force-pass = "true";
    }

    call recv_post_method_restricted;
  }
}

sub hash_route_alpha {
  if (req.http.var-nyt-canonical-alpha-host == "true" && req.http.x-nyt-route != "vi-assets") {
    set req.hash += req.http.device_type;

    # we need to fragment the cache for incompatible restart requests
    if (req.http.x-pre-restart-status) {
      set req.hash += req.http.x-pre-restart-status;
    }

    # create new hashes based on geo if rendering home
    # alpha-test.stg.nytimes.com FEATURE FLAG FOR NOW
    if(req.http.x-nyt-geo-hash
        && req.url.path ~ "^/$"
        && req.http.host == "alpha-test.stg.nytimes.com"){
        set req.hash += req.http.x-nyt-geo-hash;
    }

    return(hash);
  }
}

sub fetch_route_alpha {
  if (req.http.var-nyt-canonical-alpha-host == "true" && req.http.x-nyt-route != "vi-assets") {
    // equivalent to setting grace mode
    set beresp.stale_if_error = 86400s; // 1 day
    // allow serving stale while latest content is being generated
    set beresp.stale_while_revalidate = 30s;

    if ((beresp.status == 500 || beresp.status == 503) && req.restarts < 1 && (req.request == "GET" || req.request == "HEAD")) {
      restart;
    }

    if (beresp.http.Expires || beresp.http.Surrogate-Control ~ "max-age" || beresp.http.Cache-Control ~ "(s-maxage|max-age)") {
      # keep the ttl here
    } else {
      # apply the default ttl
      set beresp.ttl = 3600s;
    }
  }
}

sub deliver_route_alpha {
  if (req.http.var-nyt-canonical-alpha-host == "true" && req.http.x-nyt-route != "vi-assets") {
    if (resp.status >= 500 && resp.status < 600) {
      // restart if the stale object is available
      if (stale.exists) {
        restart;
      }
    }

    if (fastly_info.state ~ "HIT-STALE") {
      set resp.http.X-NYT-Served = "stale";
    }
    set resp.http.x-nyt-backend = req.http.x-nyt-backend;
    set resp.http.device_type = req.http.device_type;
    set resp.http.X-NYT-Device-Type = req.http.X-NYT-Device-Type;
    set resp.http.Device-Type = req.http.Device-Type;
    set resp.http.DeviceType = req.http.DeviceType;

    if (req.http.host == "alpha-test.stg.nytimes.com") {
      set resp.http.x-nyt-continent = req.http.x-nyt-continent;
      set resp.http.x-nyt-country = req.http.x-nyt-country;
      set resp.http.x-nyt-region = req.http.x-nyt-region;
      set resp.http.x-nyt-timezone = req.http.x-nyt-timezone;
    }

    // Preview (newsroom preview) needs to support
    // fallback logic also for incompatible articles
    if (
        req.http.host == "alpha-preview.nytimes.com"
      || req.http.host == "alpha-preview.stg.nytimes.com"
      || req.http.host == "alpha-preview.dev.nytimes.com"
      || req.http.host ~ "^apple"
    ) {
      # if the response was not compatible with VI we
      # restart the request and signal that this happened
      if (resp.http.x-vi-compatibility == "Incompatible") {
          set req.http.x-pre-restart-status = "Incompatible";
          unset resp.http.x-vi-compatibility;
          return (restart);
      }

      if (resp.http.x-vi-collection-compatibility == "Incompatible") {
          set req.http.x-pre-restart-status = "Incompatible";
          unset resp.http.x-vi-collection-compatibility;
          return (restart);
      }
    }
  }
}
