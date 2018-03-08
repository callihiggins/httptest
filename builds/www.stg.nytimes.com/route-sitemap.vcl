sub recv_route_sitemap {
  if (req.url.path ~ "^/sitemaps/") {
    set req.http.x-pagetype = "sitemap";
    set req.http.x-nyt-backend = "sitemap";
    if (req.http.x-environment == "prd") {
      set req.url = "/prd/mars/pub" req.url;
    } else {
      set req.url = "/stg/mars/pub" req.url;
    }
    set req.http.x-nyt-sitemap-url = req.url;
  }
}

sub miss_pass_route_sitemap {
  if (req.http.x-pagetype == "sitemap") {
    set bereq.http.host = "search.ec2.nytimes.com.s3.amazonaws.com";
  }
}
