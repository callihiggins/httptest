sub vcl_recv {
  if (req.http.x-environment == "stg" && req.url ~ "^/interactive/projects/") {
    set req.http.X-PageType = "newsdev-gcs";
    call set_newsdev_gcs_backend;

    set req.grace = 24h;
    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;

    # Configure access to Cloud Storage
    set req.http.Date = now;
    set req.http.Authorization = "AWS " table.lookup(newsdev_gcs, "access_key") ":" digest.hmac_sha1_base64(table.lookup(newsdev_gcs, "secret"), req.request LF LF LF req.http.Date LF "/" req.http.x-gcs-bucket req.url.path);
    set req.http.host = req.http.x-gcs-bucket ".storage.googleapis.com";
  }
}

sub vcl_fetch {
  if (req.http.X-PageType == "newsdev-gcs") {
    # Fake behavior of Amazon's WebsiteRedirectLocation
    if (beresp.http.x-amz-meta-website-redirect-location) {
      set req.http.Location = beresp.http.x-amz-meta-website-redirect-location;
      error 761 "Moved Temporarily";
    }

    // use very short cache TTL for HTTP 4XXs
    if (beresp.status >= 400 && beresp.status < 500) {
      set beresp.ttl = 3s;
    }

    if (beresp.status >= 500) {
      /* deliver stale if the object is available */
      if (stale.exists) {
        return(deliver_stale);
      }
      return(restart);
    }

    # set beresp.grace = 86400s; # equivalent to next line
    set beresp.stale_if_error = 86400s;
    set beresp.stale_while_revalidate = 30s;
  }
}

sub vcl_error {
  if (req.http.X-PageType == "newsdev-gcs") {
    # Fake behavior of Amazon's WebsiteRedirectLocation
    if (obj.status == 761) {
      set obj.http.Location = req.http.Location;
      set obj.status = 301;
      return(deliver);
    }
  }
}

sub set_newsdev_gcs_backend {
  if (req.http.x-environment == "dev") {
    set req.backend = newsdev_gcs_stg;
    set req.http.x-gcs-bucket = "nytint-stg-www";
  } else if (req.http.x-environment == "stg") {
    set req.backend = newsdev_gcs_stg;
    set req.http.x-gcs-bucket = "nytint-stg-www";
  } else {
    set req.backend = newsdev_gcs_prd;
    set req.http.x-gcs-bucket = "nytint-prd-www";
  }
}
