sub recv_route_esi_jsonp_callback {

  if (req.url == "/esi/jsonp-callback") {
    # pull the callback parameter from the topmost ESI parent
    set req.http.x-pagetype = "esi-jsonp";
    set req.http.x-nyt-backend = "synthetic-response";
    set req.http.x-nyt-jsonp-callback = regsub(req.topurl,
                             //"^.*[\?&]callback=([a-zA-Z0-9_][\w\[\]\._]*)(&|$)",
                             "^.*[\?&]callback=([a-zA-Z0-9_]+[^&]+).*$",
                             "\1");
    error 900 "JSONP ESI";
  }

}

sub error_route_esi_jsonp_callback {

  # this error code is used for jsonp callback caching
  # it will insert the original callback into the response
  if (obj.status == 900) {
    set obj.status = 200;
    set obj.response = "OK";
    # We add an empty comment at the start in order to
    # protect against content sniffing attacks.
    # See https://miki.it/blog/2014/7/8/abusing-jsonp-with-rosetta-flash/
    synthetic "/**/ " urldecode(req.http.x-nyt-jsonp-callback);
    return (deliver);
  }

}
