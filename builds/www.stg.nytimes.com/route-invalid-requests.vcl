sub recv_route_uncachable_methods {
  // Requests types that we shouldnt cache
  if (req.request != "HEAD" && req.request != "GET" && req.request != "FASTLYPURGE") {
    set req.http.x-nyt-force-pass = "true";
  }
}

sub recv_route_invalid_urls {
  // URIs not accessible via Varnish VIPs
  if (   req.url ~ "^/svc/web-shell/"
      || req.url ~ "^/svc/web-products/shell/"
      || req.url ~ "^/apc-stats/"
      || req.url ~ "^/phpinfo/"
      || req.url ~ "\.php$"
  ) {
      set req.url = "/404.html";
  }
}
