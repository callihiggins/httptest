sub recv_set_default_backend {
  set req.http.x-nyt-backend = "www_legacy_gke";
  set req.http.x-nyt-route = "legacy-gke";
  set req.http.var-nyt-send-gdpr = "true";
  unset req.http.Authorization;

  # TODO: there are most likely many more legacy routes that can remove/filter qparams
  if (req.url ~ "^/svc/comscore/" ||
      req.url ~ "^/services/xml/") {
    set req.url = querystring.remove(req.url);
  }
}

sub miss_pass_route_default_remove_cookie {
  // legacy backend has no use for the cookie
  if( req.http.x-nyt-route == "legacy-gke") {
    unset bereq.http.cookie;
    // This is needed for DV-4865, to avoid the origin redirect
    if (req.http.host == "nytimes.com") {
      set bereq.http.host = "www.nytimes.com";
    }
  }
}
