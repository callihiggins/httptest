# owner: Search team
# slack: #search
sub recv_route_add_svc {
  if ( req.url.path ~ "^/svc/add/v1/sitesearch.json"
    || req.url.path ~ "^/svc/add/v1/articlesearch.json"
    || req.url.path ~ "^/svc/add/v1/collection.json"
    || req.url.path ~ "^/svc/add/v1/lookup.json"
    || req.url.path ~ "^/svc/add/v1/related.json"
    || req.url.path ~ "^/svc/add/v1/topics.json"
  ) {
    set req.http.x-nyt-route = "add-svc";
    set req.http.x-nyt-backend = "add_svc";
    unset req.http.Authorization;
    call recv_post_method_restricted;
  }
}

sub miss_pass_route_add_svc {
    if (req.http.x-nyt-route == "add-svc") {
      set bereq.http.X-Api-Key = table.lookup(origin_auth_keys, "svc_add_collections_ce_key");
    }
}

sub deliver_add_svc_access_control {
  if (req.http.x-nyt-route == "add-svc") {
    set resp.http.Access-Control-Allow-Origin = "*";
  }
}
