sub recv_route_ads_static_assets {
  if (req.url.path ~ "^/ads/") {
    set req.http.x-nyt-route = "ads-static-assets";
    set req.http.x-nyt-backend = "gcs_origin";
    unset req.http.Cookie;
    unset req.http.X-Cookie;
  }
}

sub miss_pass_route_ads_static_assets {
  if (req.http.x-nyt-route == "ads-static-assets") {
    call miss_pass_set_bucket_auth_headers;
  }
}
