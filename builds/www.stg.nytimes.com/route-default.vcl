sub recv_set_default_backend {
  // default is WWW Legacy GKE
  set req.http.x-nyt-backend = "www_legacy_gke";
  set req.http.X-PageType = "legacy-gke";
}

sub recv_route_default_remove_cookie {
  // legacy backend has no use for the cookie
  if( req.http.x-pagetype == "legacy-gke") {
    unset req.http.Cookie;
    unset req.http.X-Cookie;
  }
}
