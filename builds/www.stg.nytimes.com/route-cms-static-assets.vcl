# defining routes for cms static assets

sub recv_route_cms_static_assets {
    
    if (req.http.x-nyt-canonical-www-host == "true") {

        if (req.url.path ~ "^/images/") {

            # feature flag this route for dev/stg only for now
            if (req.http.x-environment != "prd") {
                set req.http.x-pagetype = "cms-static-assets";
                set req.http.x-nyt-backend = "gcs_origin";
            }
        }
    }
}

sub miss_pass_route_cms_static_assets {

  if (req.http.x-pagetype == "cms-static-assets") {

    # the bucket does not contain the /images/ prefix
    if(!req.backend.is_shield) {
        set bereq.url = regsub(bereq.url, "^/images/", "/");
        call miss_pass_set_bucket_auth_headers;
    }

  }

}
