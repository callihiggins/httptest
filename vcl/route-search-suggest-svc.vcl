sub recv_route_search_suggest_svc {
  if (req.url.path ~ "^/svc/suggest(.*)") {

    if (req.url.path ~ "^/svc/suggest/v1/homepage$") {
      set req.url = "/svc/add/v1/deprecatedsuggest.json?" + req.url.qs;
      set req.http.x-nyt-route = "add-svc";
      set req.http.x-nyt-backend = "add_svc";
    } else {
      set req.http.x-nyt-route = "search-suggest";
      set req.http.x-nyt-backend = "search_suggest";
    }

    call recv_route_search_suggest_filter_querystring;
  }
}

sub miss_pass_route_search_suggest {
  if (req.http.x-nyt-route == "search-suggest") {
    unset bereq.http.cookie;
    set bereq.http.X-Api-Key = table.lookup(origin_auth_keys, "search_suggest_svc_ce_key");
	}
}

sub recv_route_search_suggest_filter_querystring {
  set req.url = querystring.filter_except(req.url,
    "query" + querystring.filtersep() +
    "filter" + querystring.filtersep() +
    "max");
}
