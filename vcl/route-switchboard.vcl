sub recv_route_switchboard {

  if ( req.url.path ~ "^/movies"
    || req.url.path ~ "^/best-sellers"
    || req.url.path ~ "^/theater"
    || req.url.path ~ "^/restaurants/"
    || req.url.path ~ "^/listings"
    || req.url.path ~ "^/briefing"
    || req.url.path ~ "^/ambriefing"
    || (req.url.path ~ "^/thedaily" && req.url.path !~ "^/thedaily(offer|listener)")
    || req.url.path ~ "^/the-daily"
    || req.url.path ~ "^/theweekly"
    || req.url.path ~ "^/the-weekly"
    || req.url.path ~ "^/weekly"
    || (req.url.path ~ "^/stillprocessing" || req.url.path ~ "^/still-processing")
    || (req.url.path ~ "^/bookreviewpodcast" || req.url.path ~ "^/book-review-podcast")
    || (req.url.path ~ "^/theargument" || req.url.path ~ "^/the-argument")
    || req.url.path ~ "^/popcast"
    || req.url.path ~ "^/dearsugars"
    || (req.url.path ~ "^/modernlovepodcast" || req.url.path ~ "^/modern-love")
    || req.url.path ~ "^/podcasts"
    || (req.url.path ~ "^/thedispatch" || req.url.path ~ "^/the-dispatch" || req.url.path ~ "^/column/the-dispatch" )
    ) {
    set req.http.x-nyt-route = "switchboard";
    set req.http.x-nyt-backend = "switchboard";
    set req.http.var-nyt-send-gdpr = "true";

    if ( req.url.path ~ "^/podcasts" ){
        set req.url = querystring.remove(req.url);
        }
    }
}

sub recv_switchboard_choose_backend {
  if (req.http.x-nyt-route == "switchboard") {
    if (req.http.var-nyt-env == "prd") {
        // this is a double check, any conditional where the variable is unset (so the header is not there)
        // will be an automatic False, with the outer negation this will also be False if the header is present and set
        // to the fallback string
        // https://docs.fastly.com/vcl/operators/#comparison-operators
        if (!req.http.x-nyt-force-backend == "fallback")  {
            if (randombool(1,100)) {
                set req.http.x-nyt-force-backend = "origin";
            }
        }
    }
  }
}

sub recv_switchboard_set_backend {
  if (req.http.x-nyt-route == "switchboard") {
    if (req.http.var-nyt-env == "prd") {
      if (req.http.x-nyt-force-backend == "origin") {
        # bypass the cache if the backend is forced to be the origin
        set req.http.var-nyt-force-pass = "true";
        set req.backend = F_switchboard_origin;
      } else {
        set req.backend = F_switchboard_fallback;
        set req.http.x-nyt-backend = "switchboard_fallback";
      }
    } else if (req.http.var-nyt-env == "stg" || req.http.var-nyt-env == "dev") {
        set req.backend = F_switchboard_origin;
    }
  }
}

sub miss_pass_route_switchboard {

    declare local var.ce_name STRING;
    // the keys were created with the env name in the key, other services will
    // have a standard name in each env
    set var.ce_name = "sb_ce_api_key";

    if (req.http.x-nyt-route == "switchboard") {
      set bereq.http.X-Api-Key = table.lookup(origin_auth_keys, var.ce_name);
      unset bereq.http.cookie;

      # fix the origin host for the www.sandbox services
      # switchboard doesn't honor the www-[a-z0-9]+ sandbox host pattern
      if (    !req.backend.is_shield
          &&  req.http.host ~ "^www-[a-z0-9]+\.(dev|stg)\.nytimes\.com$"
          &&  req.http.var-nyt-env != "prd") {

          set bereq.http.host = "www." + req.http.var-nyt-env + ".nytimes.com";
      }
    }
}
