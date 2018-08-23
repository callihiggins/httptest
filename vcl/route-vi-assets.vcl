sub recv_route_vi_assets {
  if (req.url ~ "^/vi-assets/") {
    set req.http.x-nyt-route = "vi-assets";
    set req.http.x-nyt-backend = "gcs_origin";
    set req.url = querystring.remove(req.url);

    call recv_post_method_restricted;
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

sub deliver_route_vi_assets_access_control {
  // https://jira.nyt.net/browse/STORY-4223
  if (req.http.x-nyt-route == "vi-assets" && req.url ~ "fonts-[a-f0-9]+\.css") {
    set resp.http.Access-Control-Allow-Origin = "*";
  }
}
