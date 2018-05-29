# defining routes for cms static assets

sub recv_route_cms_static_assets {
    
    if (req.http.var-nyt-canonical-www-host == "true") {

        if (req.url.path ~ "^/images/") {
            set req.http.x-nyt-route = "cms-static-assets";
            set req.http.x-nyt-backend = "gcs_origin";
            set req.url = querystring.remove(req.url);
        }
    }
}

sub miss_pass_route_cms_static_assets {

  if (req.http.x-nyt-route == "cms-static-assets") {

    unset bereq.http.cookie;

    # the bucket does not contain the /images/ prefix
    if(!req.backend.is_shield) {
        set bereq.url = regsub(bereq.url, "^/images/", "/");
        call miss_pass_set_bucket_auth_headers;
    }

  }
}
