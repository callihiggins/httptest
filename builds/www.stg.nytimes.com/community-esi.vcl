# esi for cacheable jsonp request for community

sub vcl_recv {
	
	if (req.url == "/esi/jsonp-callback") {
		# pull the callback parameter from the topmost ESI parent
		set req.http.x-community-callback = regsub(req.topurl,
                             //"^.*[\?&]callback=([a-zA-Z0-9_][\w\[\]\._]*)(&|$)",
                             "^.*[\?&]callback=([a-zA-Z0-9_]+[^&]+).*$",
                             "\1");
		error 900 "JSONP ESI";
	}

}

sub vcl_error {
	if (obj.status == 900) {
		set obj.status = 200;
		set obj.response = "OK";
		set obj.http.X-API-Version = "C";
		# We add an empty comment at the start in order to
		# protect against content sniffing attacks.
		# See https://miki.it/blog/2014/7/8/abusing-jsonp-with-rosetta-flash/
		synthetic "/**/ " urldecode(req.http.x-community-callback);
		return (deliver);
	}
}