sub recv_geo_ip {

	declare local var.ip_override STRING;
	declare local var.geo_timezone STRING;
	declare local var.geo_lookup_key STRING;
	declare local var.geo_hash STRING;
	declare local var.final_timezone STRING;
	declare local var.final_geohash STRING;

	# override if restarted since we would have lost the qparam on resrart
	if (req.restarts > 0){
		set var.ip_override = req.http.x-geoip-ip;
	} else {
		set var.ip_override = regsub(req.http.x-orig-querystring, ".*?.*ip-override=(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*", "\1");
	}

	# check if we got the ip-override param
	if (var.ip_override != req.http.x-orig-querystring){
		set client.geo.ip_override = var.ip_override;
		# save this in a req header incase we restart
		set req.http.x-geoip-ip = var.ip_override;
	} else {
		set req.http.x-geoip-ip = req.http.Fastly-Client-IP;
	}

	# try to lookup timezone and geohash with region resolution
	set var.geo_lookup_key = client.geo.continent_code + client.geo.country_code + client.geo.region;
	set var.geo_hash = table.lookup(geo_consolidation_map, var.geo_lookup_key, "NOT_MAPPED");
	set var.geo_timezone = table.lookup(geo_tz_map, var.geo_lookup_key, "NOT_MAPPED");

	if (var.geo_timezone != "NOT_MAPPED"){
		set var.final_timezone = var.geo_timezone;
	}
	if (var.geo_hash != "NOT_MAPPED"){
		set var.final_geohash = var.geo_hash;
	}

	# try to lookup timezone and geohash with country resolution
	set var.geo_lookup_key = client.geo.continent_code + client.geo.country_code;
	set var.geo_hash = table.lookup(geo_consolidation_map, var.geo_lookup_key, "NOT_MAPPED");
	set var.geo_timezone = table.lookup(geo_tz_map, var.geo_lookup_key, "NOT_MAPPED");

	if (var.geo_timezone != "NOT_MAPPED"){
		set var.final_timezone = var.geo_timezone;
	}
	if (var.geo_hash != "NOT_MAPPED"){
		set var.final_geohash = var.geo_hash;
	}

	# try to lookup timezone and geohash with continent resolution
	set var.geo_lookup_key = client.geo.continent_code;
	set var.geo_hash = table.lookup(geo_consolidation_map, var.geo_lookup_key, "NOT_MAPPED");
	set var.geo_timezone = table.lookup(geo_tz_map, var.geo_lookup_key, "NOT_MAPPED");

	if (var.geo_timezone != "NOT_MAPPED"){
		set var.final_timezone = var.geo_timezone;
	}
	if (var.geo_hash != "NOT_MAPPED"){
		set var.final_geohash = var.geo_hash;
	}

	if (var.final_geohash && var.final_timezone){
		set var.final_geohash = var.final_geohash + var.final_timezone;
	}

	if (var.final_geohash) {
		set req.http.x-nyt-geo-hash = var.final_geohash;
	}

	if (var.final_timezone) {
		set req.http.x-nyt-timezone = var.final_timezone;
	}

	# set the request headers for the backend
	set req.http.x-nyt-continent = client.geo.continent_code;
	set req.http.x-nyt-country = client.geo.country_code;
	set req.http.x-nyt-region = client.geo.region;
	set req.http.x-nyt-gmt-offset = client.geo.gmt_offset;

	# geoip test service error call
	# TODO: break into route
	if (req.http.x-nyt-internal-access) {
		if (req.url ~ "^/svc/web-products/geoip-test.html") {
			error 949 "uadiag";
		}
	}
}

sub error_949_geo_debug_svc {

	# html geoip response
	if (obj.status == 949) {
		set obj.status = 200;
		set obj.http.Content-Type = "text/html; charset=utf-8";
		synthetic
			{"<html><title>GeoIP Test Service</title>
			<style>
			table {
					font-family: Arial;
			}
			tr > td {
					padding: 4px;
			}
			td:first-child {
					color: #fff;
					background-color: #000;
			}
			td:last-child {
					border-bottom: 1px dotted #000;
			}
			</style>
			<body>
			<h1>GeoIP Test</h1> <a href="https://docs.fastly.com/guides/vcl/geolocation-related-vcl-features.html">Fastly's Documentation</a>
			<h1>IP: "} + req.http.x-geoip-ip + {"</h1>
			<table>
				<tr><td>client.geo.latitude</td><td>"} + client.geo.latitude + {"</td></tr>
				<tr><td>client.geo.longitude</td><td>"} + client.geo.longitude + {"</td></tr>
				<tr><td>client.geo.city</td><td>"} + client.geo.city + {"</td></tr>
				<tr><td>client.geo.city.utf8</td><td>"} + client.geo.city.utf8 + {"</td></tr>
				<tr><td>client.geo.continent_code</td><td>"} + client.geo.continent_code + {"</td></tr>
				<tr><td>client.geo.country_code</td><td>"} + client.geo.country_code + {"</td></tr>
				<tr><td>client.geo.country_code3</td><td>"} + client.geo.country_code3 + {"</td></tr>
				<tr><td>client.geo.country_name</td><td>"} + client.geo.country_name + {"</td></tr>
				<tr><td>client.geo.country_name.utf8</td><td>"} + client.geo.country_name.utf8 + {"</td></tr>
				<tr><td>client.geo.postal_code</td><td>"} + client.geo.postal_code + {"</td></tr>
				<tr><td>client.geo.region</td><td>"} + client.geo.region + {"</td></tr>
				<tr><td>client.geo.area_code</td><td>"} + client.geo.area_code + {"</td></tr>
				<tr><td>client.geo.metro_code</td><td>"} + client.geo.metro_code + {"</td></tr>
				<tr><td>client.geo.gmt_offset</td><td>"} + client.geo.gmt_offset + {"</td></tr>
				<tr><td>client.geo.conn_speed</td><td>"} + client.geo.conn_speed + {"</td></tr>
				<tr><td>client.as.number</td><td>"} + client.as.number + {"</td></tr>
				<tr><td>client.as.name</td><td>"} + client.as.name + {"</td></tr>
				<tr><td>server.region</td><td>"} + server.region + {"</td></tr>
				<tr><td>server.datacenter</td><td>"} + server.datacenter + {"</td></tr>
				<tr><td>Mapped Timezone</td><td>"} + if(req.http.x-nyt-timezone, req.http.x-nyt-timezone, "No Mapping Avail") + {"</td></tr>
				<tr><td>Geo Hash Value</td><td>"} + if(req.http.x-nyt-geo-hash, req.http.x-nyt-geo-hash, "No Mapping Avail") + {"</td></tr>
			</table>
			</pre>
			</body>
			</html>"};
		return(deliver);
	}

}