sub vcl_recv {
	
	declare local var.geo_timezone STRING;
	declare local var.geo_lookup_key STRING;

	# if this request came from NYT IP space and we got an override qparam
	# override the ip to use for testing purposes
	if (req.http.x-nyt-geoip-override && client.ip ~ internal){
		set geoip.ip_override = req.http.x-nyt-geoip-override;
	}

	# we no longer need this, unset it
	unset req.http.x-nyt-geoip-override;

	# try to lookup the TZ with region resolution
	set var.geo_lookup_key = geoip.continent_code + geoip.country_code + geoip.region;
	set var.geo_timezone = table.lookup(geo_tz_map, var.geo_lookup_key, "NOT_MAPPED");
	if (var.geo_timezone != "NOT_MAPPED"){
		set req.http.x-nyt-geo-hash = var.geo_lookup_key;
		set req.http.x-nyt-timezone = var.geo_timezone;
	}

	# only do this if we have country and continent and the TZ was not set previously
	if (geoip.continent_code && geoip.country_code && var.geo_timezone == "NOT_MAPPED") {
		set var.geo_lookup_key = geoip.continent_code + geoip.country_code;
		set var.geo_timezone = table.lookup(geo_tz_map, var.geo_lookup_key, "NOT_MAPPED");
		if (var.geo_timezone != "NOT_MAPPED"){
			set req.http.x-nyt-geo-hash = var.geo_lookup_key;
			set req.http.x-nyt-timezone = var.geo_timezone;
		}
	}

	# only do this if we have continent and the TZ was not set previously
	if (geoip.continent_code && var.geo_timezone == "NOT_MAPPED") {
		set var.geo_timezone = table.lookup(geo_tz_map, geoip.continent_code, "NOT_MAPPED");
		if (var.geo_timezone != "NOT_MAPPED"){
			set req.http.x-nyt-geo-hash = geoip.continent_code;
			set req.http.x-nyt-timezone = var.geo_timezone;
		}
	}

	# set the request headers for the backend
	set req.http.x-nyt-continent = geoip.continent_code;
	set req.http.x-nyt-country = geoip.country_code;
	set req.http.x-nyt-region = geoip.region;

}
