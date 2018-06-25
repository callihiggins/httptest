sub recv_route_switchboard {
  if ( req.url.path ~ "^/movies"
    || req.url.path ~ "^/best-sellers"
    || req.url.path ~ "^/theater"
    || req.url.path ~ "^/restaurants/"
    || req.url.path ~ "^/listings"
    || req.url.path ~ "^/briefing"
    || req.url.path ~ "^/ambriefing"
    || (req.url.path ~ "^/thedaily" && req.url.path !~ "^/thedailyoffer")
  ) {
    set req.http.x-nyt-route = "switchboard";
    set req.http.x-nyt-backend = "switchboard";
    set req.http.var-nyt-send-gdpr = "true";

  }
}

sub miss_pass_route_switchboard {
    if (req.http.x-nyt-route == "switchboard") {
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