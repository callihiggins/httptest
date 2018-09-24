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
          set req.http.var-nyt-send-gdpr = "true";
          set req.url = querystring.filter_except(req.url, "homeTest");
          unset req.http.Authorization;

          call recv_post_method_restricted;
          call recv_homepage_abra_allocation;
        }

        if (req.url ~ "^/index.html") {
            set req.http.x-nyt-route = "homepage";
            set req.http.x-nyt-backend = "homepage_fe";
            set req.http.var-nyt-wf-auth = "true";
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
      set req.hash += req.http.x-vi-abtest-www-hp;
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

sub recv_homepage_abra_allocation {
  # Vi Home page A/B testing logic
  # TODO: move this into an abra.vcl when we come up with a more generic
  # solution for Fastly-enabled A/B testing that all of Vi can use.

  # only if this execution is not on the shield pop in a shielding scenario
  if (!req.http.x-nyt-shield-auth) {
    declare local var.hash STRING;
    declare local var.p INTEGER;
    declare local var.test_group STRING;

    # This code hashes the nyt-a cookie with the ABRA test name into an integer
    # between 0 to 2^32 - 1, which is used to determine a user's allocation.
    # For this example, the ABRA test name is `HOME_media_emphasis`. For this test,
    # we'll allocate 2% of users into the test, and do a 50/50 split of control/variant
    # within the test. The remaining 98% of users will be outside the test. Our variants are:
    # - `O_control`. Receives 1% of traffic (values 0 <= p < floor(0.01 * 2^32)).
    # - `1_variant`. Receives 1% of traffic (values floor(0.01 * 2^32) <= p < floor(0.02 * 2^32)).
    # - `2_unallocated`. Receives 98% of traffic (values floor(0.02 * 2^32) <= p < floor(1.00 * 2^32)).
    set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " HOME_media_emphasis");
    set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
    set var.p = std.strtol(var.hash, 16);

    if (var.p < 0042949672) { # floor(0.01 * 2^32)
      set var.test_group = "0_control";
    } else if (var.p < 0085899345) { # floor(0.02 * 2^32)
      set var.test_group = "1_variant";
    } else {
      set var.test_group = "2_unallocated";
    }

    # We pass a generically-named header `x-vi-abtest-www-hp` to the Vi server, which
    # implements the A/B test branching logic. This value is not picked up by ABRA, so we
    # do not need to change it for every test. The ABRA test name and variant names
    # should change on a per-test basis.
    set req.http.x-vi-abtest-www-hp = var.test_group;
  }
}

sub miss_pass_route_homepage {
  if (req.http.x-nyt-route == "vi-homepage" || req.http.x-nyt-route == "homepage") {
    unset bereq.http.cookie;
  }
}

sub deliver_homepage_set_debug_header {
  # only if this execution is not on the shield pop in a shielding scenario
  if (!req.http.x-nyt-shield-auth && req.http.x-nyt-route == "vi-homepage") {
    # for debugging and automated tests:
    if (req.http.x-nyt-debug ~ "." && (req.http.x-nyt-nyhq-access || req.http.x-nyt-staging-only-access)) {
      set resp.http.x-nyt-debug-req-http-x-vi-abtest-www-hp = req.http.x-vi-abtest-www-hp;
    }
  }
}
