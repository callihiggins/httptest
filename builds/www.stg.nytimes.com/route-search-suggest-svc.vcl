sub recv_route_search_suggest_svc {
  if (req.url.path ~ "^/svc/suggest(.*)") {
    set req.http.x-pagetype = "search-suggest";
    set req.http.x-nyt-backend = "search_suggest";
    unset req.http.Cookie;
    unset req.http.X-Cookie;
  }
}

sub miss_pass_route_search_suggest {
	if (req.http.x-pagetype == "search-suggest"){
		set bereq.http.X-Api-Key = table.lookup(origin_auth_keys, "search_suggest_svc_ce_key");
	}
}