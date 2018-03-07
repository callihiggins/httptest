sub recv_route_sitemap {
  if (req.url.path ~ "^/sitemaps/") {
    set req.http.x-pagetype = "sitemap";
    set req.http.x-nyt-backend = "sitemap";
    if (req.http.x-environment == "prd") {
      set req.url = regsub(req.url, "^/sitemaps", "/prd/mars/pub/sitemaps");
    } else {
      set req.url = regsub(req.url, "^/sitemaps", "/stg/mars/pub/sitemaps");
    }
    unset req.http.Cookie;
    unset req.http.X-Cookie;
  }
}

sub miss_pass_route_sitemap {
  if (req.http.x-pagetype == "sitemap") {
    # Any miss logic required?
  }
}
