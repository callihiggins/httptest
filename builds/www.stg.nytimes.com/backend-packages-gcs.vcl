sub vcl_recv {
  if ( req.http.X-PageType == "packages-gcs" ) {

    call set_www_packages_gcs_backend;

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
  if (req.http.X-PageType == "packages-gcs") {
    set bereq.http.Authorization = "AWS " table.lookup(newsdev_gcs, "access_key") ":" digest.hmac_sha1_base64(table.lookup(newsdev_gcs, "secret"), "GET" LF LF LF req.http.Date LF "/" req.http.x-gcs-bucket req.url.path);
  }
}

sub vcl_pass {
  if (req.http.X-PageType == "packages-gcs") {
    set bereq.http.Authorization = "AWS " table.lookup(newsdev_gcs, "access_key") ":" digest.hmac_sha1_base64(table.lookup(newsdev_gcs, "secret"), "GET" LF LF LF req.http.Date LF "/" req.http.x-gcs-bucket req.url.path);
  }
}

sub vcl_fetch {
  if ( req.http.X-PageType == "packages-gcs" ) {
    # If objects in the bucket has set Cache-Control: Private
    # override it and set ttl to 1 minute
    # otherwise let it go
    if( beresp.http.Cache-Control ~ "private" ){
      set beresp.http.Cache-Control = "Surrogate-Control: max-age=60"
      set beresp.ttl = 60s;
    }
  }
}

sub set_www_packages_gcs_backend {
  set req.backend = F_packages_gcs;
  set req.http.x-nyt-backend = "packages_gcs";

  if (req.http.x-environment == "dev") {
    set req.http.x-gcs-bucket = "nyt-packages-dev";
  } else if (req.http.x-environment == "stg") {
    set req.http.x-gcs-bucket = "nyt-packages-dev";
  } else {
    set req.http.x-gcs-bucket = "nyt-packages-prd";
  }
}
