sub vcl_recv {
  if ( req.http.X-PageType != "newsdev-gke" && (
       req.url ~ "^/interactive/projects/"
    || req.url ~ "^/roomfordebate"
    || req.url ~ "^/editorial-standards" )) {

    set req.http.X-PageType = "newsdev-gcs";
    call set_newsdev_gcs_backend;

    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;

    # Redirect to https before updating req.http.host header
    if ( !req.http.Fastly-SSL ) {
      call redirect_to_https;
    }

    # Configure access to Cloud Storage
    set req.http.Date = now;
    set req.http.host = req.http.x-gcs-bucket ".storage.googleapis.com";
  }
}

sub vcl_miss {
  if (req.http.X-PageType == "newsdev-gcs") {
    set bereq.http.Authorization = "AWS " table.lookup(newsdev_gcs, "access_key") ":" digest.hmac_sha1_base64(table.lookup(newsdev_gcs, "secret"), "GET" LF LF LF req.http.Date LF "/" req.http.x-gcs-bucket req.url.path);
  }
}

sub vcl_pass {
  if (req.http.X-PageType == "newsdev-gcs") {
    set bereq.http.Authorization = "AWS " table.lookup(newsdev_gcs, "access_key") ":" digest.hmac_sha1_base64(table.lookup(newsdev_gcs, "secret"), "GET" LF LF LF req.http.Date LF "/" req.http.x-gcs-bucket req.url.path);
  }
}

sub vcl_fetch {
  if (req.http.X-PageType == "newsdev-gcs") {

    # Fake behavior of Amazon's WebsiteRedirectLocation
    if (beresp.http.x-amz-meta-website-redirect-location) {
      set req.http.Location = beresp.http.x-amz-meta-website-redirect-location;
      error 761 "Moved Permanently";
    }

    # stale-while-revalidate override
    set beresp.http.x-nyt-stale-while-revalidate = "30";
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

  set req.backend = F_newsdev_gcs;
  set req.http.x-nyt-backend = "newsdev_gcs";

  if (req.http.x-environment == "dev") {
    set req.http.x-gcs-bucket = "nytint-stg-www";
  } else if (req.http.x-environment == "stg") {
    set req.http.x-gcs-bucket = "nytint-stg-www";
  } else {
    set req.http.x-gcs-bucket = "nytint-prd-www";
  }
}
