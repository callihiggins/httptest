sub vcl_recv {
  if (req.http.X-PageType == "newsgraphics-gcs") {
    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;
  }
}

sub vcl_miss {
  if (req.http.x-pagetype == "newsgraphics-gcs") {
    call miss_pass_set_bucket_auth_headers;
  }
}

sub vcl_pass {
  if (req.http.x-pagetype == "newsgraphics-gcs") {
    call miss_pass_set_bucket_auth_headers;
  }
}

sub vcl_fetch {
  if (req.http.X-PageType == "newsgraphics-gcs") {
    # Fake behavior of Amazon's WebsiteRedirectLocation
    if (beresp.http.x-amz-meta-website-redirect-location) {
      set req.http.Location = beresp.http.x-amz-meta-website-redirect-location;
      error 761 "Moved Permanently";
    }
  }
}

sub vcl_error {
    if (req.http.X-PageType == "newsgraphics-gcs") {
        # Fake behavior of Amazon's WebsiteRedirectLocation
        if (obj.status == 761) {
          set obj.http.Location = req.http.Location;
          set obj.status = 301;
          return(deliver);
        }
    }
}
