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
