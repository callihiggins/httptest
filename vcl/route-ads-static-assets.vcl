sub recv_route_ads_static_assets {
  if (req.url.path ~ "^/ads/") {
    set req.http.x-nyt-route = "ads-static-assets";
    set req.http.x-nyt-backend = "gcs_origin";
    set req.url = querystring.remove(req.url);
    unset req.http.Authorization;
    call recv_post_method_restricted;
  }
}

sub miss_pass_route_ads_static_assets {
  if (req.http.x-nyt-route == "ads-static-assets") {
    unset bereq.http.Cookie;
    call miss_pass_set_bucket_auth_headers;
  }
}
