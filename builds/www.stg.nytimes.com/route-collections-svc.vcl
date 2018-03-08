sub recv_route_collections_svc {
  if (req.url.path ~ "^/svc/collections/v1/publish(.*)") {
    set req.http.x-pagetype = "collections-svc";
    set req.http.x-nyt-backend = "collections_svc";
  }
}
