sub recv_route_newsgraphics_gcs {

  if (req.url ~ "^/newsgraphics/" || req.url ~ "^/projects/") {
    set req.http.x-nyt-route = "newsgraphics-gcs";
    set req.http.x-nyt-backend = "gcs_origin";

    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;
  }
}

sub miss_pass_route_newsgraphics_gcs {
  if (req.http.x-nyt-route == "newsgraphics-gcs") {
    call miss_pass_set_bucket_auth_headers;
  }
}

sub fetch_route_newsgraphics_gcs {
  if (req.http.x-nyt-route == "newsgraphics-gcs") {
    # Fake behavior of Amazon's WebsiteRedirectLocation
    if (beresp.http.x-amz-meta-website-redirect-location) {
      error 770 beresp.http.x-amz-meta-website-redirect-location;
    }
  }
}
