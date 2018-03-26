sub recv_route_add_svc {
  if ( req.url.path ~ "^/svc/add/v1/sitesearch.json"
    || req.url.path ~ "^/svc/add/v1/articlesearch.json"
    || req.url.path ~ "^/svc/add/v1/collection.json"
    || req.url.path ~ "^/svc/add/v1/lookup.json"
    || req.url.path ~ "^/svc/add/v1/related.json"
    || req.url.path ~ "^/svc/add/v1/topics.json"
  ) {
    set req.http.x-pagetype = "add-svc";
    set req.http.x-nyt-backend = "add_svc";
    set req.http.X-Api-Key = table.lookup(origin_auth_keys, "svc_add_collections_ce_key");
  }
}
