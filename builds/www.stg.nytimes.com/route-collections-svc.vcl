sub recv_route_collections_svc {
  if (req.url.path ~ "^/svc/collections/v1/publish(.*)") {
    set req.http.x-nyt-route = "collections-svc";
    set req.http.x-nyt-backend = "collections_svc";
    call recv_route_collections_svc_filter_querystring;
  }
}

sub recv_route_collections_svc_filter_querystring {
  set req.url = querystring.filter_except(req.url,
    "dom" + querystring.filtersep() +
    "limit" + querystring.filtersep() +
    "page" + querystring.filtersep() +
    "q" + querystring.filtersep() +
    "sort" + querystring.filtersep() +
    "type" + querystring.filtersep() +
    "show_embedded" + querystring.filtersep() +
    "dedupe_hl");
}
