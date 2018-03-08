sub recv_route_sitemap {
  if (req.url.path ~ "^/sitemaps/") {
    set req.http.x-pagetype = "sitemap";
    set req.http.x-nyt-backend = "sitemap";
    if (req.http.x-environment == "prd") {
      set req.url = regsub(req.url, "^", "/prd/mars/pub");
    } else {
      set req.url = regsub(req.url, "^", "/stg/mars/pub");
    }
    set req.http.x-foo-bar = req.url;
  }
}

sub miss_pass_route_sitemap {
  if (req.http.x-pagetype == "sitemap") {
    # Any miss logic required?
  }
}
