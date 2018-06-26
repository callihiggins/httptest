# rename to geoip_header_init
sub recv_geo_ip {

	declare local var.ip_override STRING;

	# override if restarted since we would have lost the qparam on resrart
	if (req.restarts > 0){
		set var.ip_override = req.http.x-geoip-ip;
	} else {
		set var.ip_override = regsub(req.http.x-nyt-orig-querystring, ".*?.*ip-override=(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*", "\1");
	}

	# check if we got the ip-override param
	if (var.ip_override != req.http.x-nyt-orig-querystring){
		set client.geo.ip_override = var.ip_override;
		# save this in a req header incase we restart
		set req.http.x-geoip-ip = var.ip_override;
	} else {
		set client.geo.ip_override = req.http.Fastly-Client-IP;
		set req.http.x-geoip-ip = req.http.Fastly-Client-IP;
	}

	# set the request headers for the backend
	set req.http.x-nyt-continent = client.geo.continent_code;
	set req.http.x-nyt-country = client.geo.country_code;
	set req.http.x-nyt-region = client.geo.region;
	set req.http.x-nyt-gmt-offset = client.geo.gmt_offset;
	set req.http.x-nyt-latitude = client.geo.latitude;
	set req.http.x-nyt-longitude = client.geo.longitude;
	set req.http.x-nyt-city = client.geo.city;
	set req.http.x-nyt-postal-code = client.geo.postal_code;
}
