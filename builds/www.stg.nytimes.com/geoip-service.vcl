sub vcl_recv {
	
	declare local var.ip_override STRING;
  declare local var.geo_timezone STRING;
  declare local var.geo_lookup_key STRING;

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

  # try to lookup the TZ with region resolution
  set var.geo_lookup_key = client.geo.continent_code + client.geo.country_code + client.geo.region;
  set var.geo_timezone = table.lookup(geo_tz_map, var.geo_lookup_key, "NOT_MAPPED");
  if (var.geo_timezone != "NOT_MAPPED"){
    set req.http.x-nyt-geo-hash = var.geo_lookup_key;
    set req.http.x-nyt-timezone = var.geo_timezone;
  }

  # only do this if we have country and continent and the TZ was not set previously
  if (client.geo.continent_code && client.geo.country_code && var.geo_timezone == "NOT_MAPPED") {
    set var.geo_lookup_key = client.geo.continent_code + client.geo.country_code;
    set var.geo_timezone = table.lookup(geo_tz_map, var.geo_lookup_key, "NOT_MAPPED");
    if (var.geo_timezone != "NOT_MAPPED"){
      set req.http.x-nyt-geo-hash = var.geo_lookup_key;
      set req.http.x-nyt-timezone = var.geo_timezone;
    }
  }

  # only do this if we have continent and the TZ was not set previously
  if (client.geo.continent_code && var.geo_timezone == "NOT_MAPPED") {
    set var.geo_timezone = table.lookup(geo_tz_map, client.geo.continent_code, "NOT_MAPPED");
    if (var.geo_timezone != "NOT_MAPPED"){
      set req.http.x-nyt-geo-hash = client.geo.continent_code;
      set req.http.x-nyt-timezone = var.geo_timezone;
    }
  }

  # set the request headers for the backend
  set req.http.x-nyt-continent = client.geo.continent_code;
  set req.http.x-nyt-country = client.geo.country_code;
  set req.http.x-nyt-region = client.geo.region;

	# geoip test service error call
	if ( client.ip ~ internal) {
		if (req.url ~ "^/svc/web-products/geoip-test.html") {
		  error 949 "uadiag";
		}
	}
}
 
sub vcl_error {

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
