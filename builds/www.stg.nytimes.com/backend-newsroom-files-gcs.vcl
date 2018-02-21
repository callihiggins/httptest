sub vcl_recv {
  if (req.http.X-PageType == "newsroom-files-gcs") {
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
  if (req.http.x-pagetype == "newsroom-files-gcs") {
    call miss_pass_set_bucket_auth_headers;
  }
}

sub vcl_pass {
  if (req.http.x-pagetype == "newsroom-files-gcs") {
    call miss_pass_set_bucket_auth_headers;
  }
}
