sub vcl_recv {
	
	declare local var.ip_override STRING;
  declare local var.geo_timezone STRING;
  declare local var.geo_lookup_key STRING;

	set var.ip_override = regsub(req.http.x-orig-querystring, ".*?.*ip-override=(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*", "\1");
	
	if (var.ip_override != req.http.x-orig-querystring){
		set geoip.ip_override = var.ip_override;
	} else {
		set geoip.ip_override = req.http.Fastly-Client-IP;
	}

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
      <h1>GeoIP Test</h1>
      <h1>IP: "} + geoip.ip_override + {"</h1>
      <table>
        <tr><td>geoip.latitude</td><td>"} + geoip.latitude + {"</td></tr>
        <tr><td>geoip.longitude</td><td>"} + geoip.longitude + {"</td></tr>
        <tr><td>geoip.city</td><td>"} + geoip.city + {"</td></tr>
        <tr><td>geoip.city.latin1</td><td>"} + geoip.city.latin1 + {"</td></tr>
        <tr><td>geoip.city.utf8</td><td>"} + geoip.city.utf8 + {"</td></tr>
        <tr><td>geoip.city.ascii</td><td>"} + geoip.city.ascii + {"</td></tr>
        <tr><td>geoip.continent_code</td><td>"} + geoip.continent_code + {"</td></tr>
        <tr><td>geoip.country_code</td><td>"} + geoip.country_code + {"</td></tr>
        <tr><td>geoip.country_code3</td><td>"} + geoip.country_code3 + {"</td></tr>
        <tr><td>geoip.country_name</td><td>"} + geoip.country_name + {"</td></tr>
        <tr><td>geoip.country_name.ascii</td><td>"} + geoip.country_name.ascii + {"</td></tr>
        <tr><td>geoip.country_name.latin1</td><td>"} + geoip.country_name.latin1 + {"</td></tr>
        <tr><td>geoip.country_name.utf8</td><td>"} + geoip.country_name.utf8 + {"</td></tr>
        <tr><td>geoip.postal_code</td><td>"} + geoip.postal_code + {"</td></tr>
        <tr><td>geoip.region</td><td>"} + geoip.region + {"</td></tr>
        <tr><td>geoip.region.latin1</td><td>"} + geoip.region.latin1 + {"</td></tr>
        <tr><td>geoip.region.utf8</td><td>"} + geoip.region.utf8 + {"</td></tr>
        <tr><td>geoip.region.ascii</td><td>"} + geoip.region.ascii + {"</td></tr>
        <tr><td>geoip.area_code</td><td>"} + geoip.area_code + {"</td></tr>
        <tr><td>geoip.metro_code</td><td>"} + geoip.metro_code + {"</td></tr>
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
