sub recv_route_newsdev_gcs {
  if (     req.url ~ "^/interactive/projects/"
        || req.url ~ "^/roomfordebate"
        || req.url ~ "^/editorial-standards" ) {

    set req.http.x-nyt-route = "newsdev-gcs";
    set req.http.x-nyt-backend = "gcs_origin";

    unset req.http.cookie;
    unset req.http.x-cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;

    # Redirect to https before updating req.http.host header
    if ( !req.http.Fastly-SSL ) {
      call redirect_to_https;
    } 
  }
}

sub fetch_route_newsdev_gcs {
  if (req.http.x-nyt-route == "newsdev-gcs") {

    # Fake behavior of Amazon's WebsiteRedirectLocation
    if (beresp.http.x-amz-meta-website-redirect-location) {
      error 770 beresp.http.x-amz-meta-website-redirect-location;
    }

    # stale-while-revalidate override
    set beresp.http.x-nyt-stale-while-revalidate = "30";

    # GCS 404's are private; max-age=0 override that for this route
    # so that it uses the default TTL for 404's
    if(beresp.status == 404){
      unset beresp.http.cache-control;
    }
  }
}

sub miss_pass_route_newsdev_gcs {

  if (req.http.x-nyt-route == "newsdev-gcs") {
    if(!req.backend.is_shield) {
        set bereq.url = regsub(bereq.url, "^/images/", "/");
        call miss_pass_set_bucket_auth_headers;
    }
  }
}
