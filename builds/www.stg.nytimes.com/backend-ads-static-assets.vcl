sub vcl_recv {
  if (req.url.path ~ "^/ads/" && req.http.x-environment ~ "(dev|stg)") {
    set req.http.X-PageType = "ads-static-assets";
    set req.http.x-nyt-backend = "ads-static-assets";
    set req.http.x-nyt-gcs-private-bucket = "nyt-ads-static-assets";
    set req.backend = F_ads_static_assets;
    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;
  }
}

sub vcl_miss {
  if (req.http.X-PageType == "ads-static-assets") {
    set bereq.http.host = req.http.x-nyt-gcs-private-bucket ".storage.googleapis.com";
  }
}

sub vcl_pass {
  if (req.http.X-PageType == "ads-static-assets") {
    set bereq.http.host = req.http.x-nyt-gcs-private-bucket ".storage.googleapis.com";
  }
}
