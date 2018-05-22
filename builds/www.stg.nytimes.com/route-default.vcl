sub recv_set_default_backend {
  // default is WWW Legacy GKE
  set req.http.x-nyt-backend = "www_legacy_gke";
  set req.http.x-nyt-route = "legacy-gke";
  set req.http.var-nyt-send-gdpr = "true";
}

sub miss_pass_route_default_remove_cookie {
  // legacy backend has no use for the cookie
  if( req.http.x-nyt-route == "legacy-gke") {
    unset bereq.http.cookie;
  }
}
