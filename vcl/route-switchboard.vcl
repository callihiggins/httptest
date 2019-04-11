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
    ) {
    set req.http.x-nyt-route = "switchboard";
    set req.http.x-nyt-backend = "switchboard";
    set req.http.var-nyt-send-gdpr = "true";
        if ( req.url.path ~ "^/podcasts" ){
            set req.url = querystring.remove(req.url);
        }
    }

    ## TODO need logic for the API requests?

    ## TODO where are the other nginx subdomains? (do they have these headers?)

    ## TODO where does query.nytimes.com get handled?
    ## there is a conf/httpd/vhosts.d/3_query.nytimes.com.conf in www-legacy
    ## does not have an obvious pointer to SB?
    ## TOODO does it go through the www-legacy backend?
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
