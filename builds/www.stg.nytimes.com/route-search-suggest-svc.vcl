sub recv_route_search_suggest_svc {
  if (req.url.path ~ "^/svc/suggest(.*)") {
    set req.http.x-nyt-route = "search-suggest";
    set req.http.x-nyt-backend = "search_suggest";
  }
}

sub miss_pass_route_search_suggest {
  if (req.http.x-nyt-route == "search-suggest") {
    unset bereq.http.cookie;
    set bereq.http.X-Api-Key = table.lookup(origin_auth_keys, "search_suggest_svc_ce_key");
	}
}
