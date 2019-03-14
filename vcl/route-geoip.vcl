sub recv_route_geoip_svc {
  # geoip test service error call
	if (req.http.x-nyt-nyhq-access == "1") {
		if (req.url ~ "^/svc/web-products/geoip-test.html") {
			error 949;
		}
	}
}

sub error_949_geo_debug_svc {

	# html geoip response
	if (obj.status == 949) {
		set obj.status = 200;
		set obj.response = "OK";
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
				<tr><td>Geo Hash Value</td><td>"} + if(req.http.x-nyt-geo-hash, req.http.x-nyt-geo-hash, "No Mapping Avail") + {"</td></tr>
			</table>
			</pre>
			</body>
			</html>"};
		return(deliver);
	}
}
