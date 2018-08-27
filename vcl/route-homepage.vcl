sub recv_route_homepage {
    # homepage only serves from canonical hosts
    # all others go to legacy
    if (req.http.var-nyt-canonical-www-host == "true") {
        if (req.url.path == "/") {
          # first check to see if we need to redirect to a different edition
          call recv_route_homepage_edition_redirect;

          set req.http.x-nyt-route = "vi-homepage";
          set req.http.x-nyt-backend = "projectvi_fe";
          set req.http.var-nyt-error-retry = "false";
          set req.http.var-nyt-wf-auth = "true";
          set req.http.x--fastly-project-vi = "1";
          set req.http.var-nyt-send-gdpr = "true";
          set req.url = querystring.filter_except(req.url, "homeTest");
          unset req.http.Authorization;

          call recv_post_method_restricted;
        }

        if (req.url ~ "^/index.html") {
            set req.http.x-nyt-route = "homepage";
            set req.http.x-nyt-backend = "homepage_fe";
            set req.http.var-nyt-wf-auth = "true";
            unset req.http.x--fastly-project-vi;
            set req.http.var-nyt-send-gdpr = "true";
            unset req.http.Authorization;

            call recv_post_method_restricted;
        }
    }
}

sub recv_route_homepage_edition_redirect {
    # redirect HP based on edition
    if (req.http.var-cookie-nyt-edition == "edition|SPANISH"
        && (req.http.x-nyt-route == "homepage" || req.http.x-nyt-route == "vi-homepage")
    ) {
        declare local var.target_url STRING;
        set var.target_url =  "http://" + req.http.host + "/es/" + req.http.x-nyt-orig-querystring;
        error 771 var.target_url;
    }
}

sub error_771_perform_302_redirect {
    if (obj.status == 771) {
        set obj.http.Location = obj.response;
        set obj.status = 302;
        set obj.response = "Found";
        return(deliver);
    }
}

sub hash_route_homepage {

  # if vi allocated, add hash parameters for cache variance
  if (req.http.x-nyt-route == "vi-homepage") {

      # only compute x-nyt-geo-hash on edge pops in shielding scenario
      if(!req.http.x-nyt-shield-auth) {
        call calculate_geo_hash;
      }

      set req.hash += req.http.x-nyt-geo-hash;
      set req.hash += req.http.device_type;
      set req.hash += req.http.x-vi-ssr-www-hp;
  }
}

sub calculate_geo_hash {

	declare local var.geo_lookup_key STRING;
	declare local var.geo_hash STRING;
	declare local var.final_geohash STRING;

	# lookup homepage regional resolution for briefing
	set var.geo_lookup_key = req.http.x-nyt-continent + req.http.x-nyt-country + req.http.x-nyt-region;
	set var.geo_hash = table.lookup(geo_homepage_briefing_map, var.geo_lookup_key, "NOT_MAPPED");
	if (var.geo_hash != "NOT_MAPPED"){
		set var.final_geohash = var.geo_hash;
	} else {
		# lookup by continent + country_code
		set var.geo_lookup_key = req.http.x-nyt-continent + req.http.x-nyt-country;
		set var.geo_hash = table.lookup(geo_homepage_briefing_map, var.geo_lookup_key, "NOT_MAPPED");
		if (var.geo_hash != "NOT_MAPPED"){
			set var.final_geohash = var.geo_hash;
		} else {
			# not found, so default to continent
			set var.final_geohash = req.http.x-nyt-continent;
		}
	}

	set req.http.x-nyt-geo-hash = var.final_geohash + req.http.x-nyt-gmt-offset;
}

sub miss_pass_route_homepage {
  if (req.http.x-nyt-route == "vi-homepage" || req.http.x-nyt-route == "homepage") {
    unset bereq.http.cookie;
  }
}
