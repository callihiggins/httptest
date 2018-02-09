sub vcl_recv {
  if (req.http.X-PageType == "packages-gcs") {
    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;

    # Redirect to https before updating req.http.host header
    if ( !req.http.Fastly-SSL ) {
      call redirect_to_https;
    }
  }
}

sub vcl_miss {
  if (req.http.x-pagetype == "packages-gcs") {
    call miss_pass_set_bucket_auth_headers;
  }
}

sub vcl_pass {
  if (req.http.x-pagetype == "packages-gcs") {
    call miss_pass_set_bucket_auth_headers;
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
