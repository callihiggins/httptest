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
    || (req.url.path ~ "^/stillprocessing" || req.url.path ~ "^/still-processing")
    || (req.url.path ~ "^/bookreviewpodcast" || req.url.path ~ "^/book-review-podcast")
    || (req.url.path ~ "^/theargument$" || req.url.path ~ "^/the-argument$")
    || req.url.path ~ "^/popcast"
    || req.url.path ~ "^/dearsugars"
    || (req.url.path ~ "^/modernlovepodcast" || req.url.path ~ "^/modern-love")
    || req.url.path ~ "^/podcasts"
    || (req.url.path ~ "^/thedispatch" || req.url.path ~ "^/the-dispatch" || req.url.path ~ "^/column/the-dispatch" )
    || (req.url.path ~ "^/sugarcalling" || req.url.path ~ "^/sugar-calling")
    || (req.url.path ~ "^/rabbithole" || req.url.path ~ "^/rabbit-hole")
    || req.url.path ~ "^/togetherapart"
    ) {
    set req.http.x-nyt-route = "switchboard";
    set req.http.x-nyt-backend = "switchboard";
    set req.http.var-nyt-send-gdpr = "true";

    if ( req.url.path ~ "^/podcasts" ){
        set req.url = querystring.remove(req.url);
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
