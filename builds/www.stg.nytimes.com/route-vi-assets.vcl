sub recv_route_vi_assets {
  if (req.url ~ "^/vi-assets/") {
    set req.http.X-PageType = "vi-assets";
    set req.http.x-nyt-backend = "gcs_origin";
  }
}

sub miss_pass_route_vi_assets {
  if (req.http.X-PageType == "vi-assets") {
    if(!req.backend.is_shield) {
      set bereq.url = regsub(bereq.url, "^/vi-assets/", "/");
      call miss_pass_set_bucket_auth_headers;
    }
  }
}