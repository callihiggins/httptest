sub recv_route_newsdev_gcs {
  if ((req.url ~ "^/interactive/projects/" && req.url !~ "^/interactive/projects/well/healthy-recipes/recipes/")
        || req.url ~ "^/roomfordebate/?"
        || req.url ~ "^/fashion/runway"
        || req.url ~ "^/editorial-standards"
  ) {
    set req.http.x-nyt-route = "newsdev-gcs";
    set req.http.x-nyt-backend = "gcs_origin";
    set req.http.var-nyt-send-gdpr = "true";
    set req.url = querystring.remove(req.url);

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

    # If the gcs object returns a 404, serve a custom 404 error page
    if (resp.status == 404 && req.restarts < 1) {
      set req.http.var-nyt-404-url = "/interactive/projects/404.html";
      call deliver_custom_404_error;
    }
    # Since the custom 404 page is successfully found,
    # restore the original status code
    if (req.http.var-nyt-404-url && req.restarts > 0) {
      set resp.status = 404;
    }

  }
}
