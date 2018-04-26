sub recv_route_sitemap {
  if (req.url.path ~ "^/sitemaps/") {
    set req.http.x-nyt-route = "sitemap";
    set req.http.x-nyt-backend = "sitemap";
  }
}

sub miss_pass_route_sitemap {
  if (req.http.x-nyt-route == "sitemap") {
    set bereq.http.host = "search.ec2.nytimes.com.s3.amazonaws.com";
    if (req.http.x-environment == "prd") {
      set bereq.url = "/prd/mars/pub" req.url;
    } else {
      set bereq.url = "/stg/mars/pub" req.url;
    }
  }
}
