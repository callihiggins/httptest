sub recv_route_newsdev_gcs {
  if (     req.url ~ "^/interactive/projects/"
        || req.url ~ "^/roomfordebate"
        || req.url ~ "^/editorial-standards" ) {

    set req.http.x-nyt-route = "newsdev-gcs";
    set req.http.x-nyt-backend = "gcs_origin";
    set req.http.var-nyt-send-gdpr = "true";

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
  }
}

sub miss_pass_route_newsdev_gcs {

  if (req.http.x-nyt-route == "newsdev-gcs") {
    unset bereq.http.cookie;

    if(!req.backend.is_shield) {
        set bereq.url = regsub(bereq.url, "^/images/", "/");
        call miss_pass_set_bucket_auth_headers;
    }
  }
}

sub deliver_route_newsdev_gcs_error {
  if (req.http.x-nyt-route == "newsdev-gcs") {
    # This GCS backend is private so the 404 page cannot be configured
    # and is xml, so load a custom 404 by restarting the request
    # By restarting the request with an additional header that is
    # handled by the receiver
    if (resp.status == 404 && req.restarts < 1) {
      set req.http.x-nyt-gcs-404 = "true";
      set req.url = "/interactive/projects/404.html";
      restart;
    }

    # Since the custom 404 page is successfully found,
    # restore the original status code
    if (req.http.x-nyt-gcs-404 && req.restarts > 0) {
      set resp.status = 404;
    }
  }
}
