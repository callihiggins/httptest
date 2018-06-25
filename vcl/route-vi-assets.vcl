sub recv_route_vi_assets {
  if (req.url ~ "^/vi-assets/") {
    set req.http.x-nyt-route = "vi-assets";
    set req.http.x-nyt-backend = "gcs_origin";
    set req.url = querystring.remove(req.url);
  }
}

sub miss_pass_route_vi_assets {
  if (req.http.x-nyt-route == "vi-assets") {
    unset bereq.http.cookie;

    if(!req.backend.is_shield) {
      set bereq.url = regsub(bereq.url, "^/vi-assets/", "/");
      call miss_pass_set_bucket_auth_headers;
    }
  }
}