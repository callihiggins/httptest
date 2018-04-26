sub recv_route_newsroom_files_gcs {
  if ( req.url ~ "^/files/" ) {
    set req.http.x-nyt-route = "newsroom-files-gcs";
    set req.http.x-nyt-backend = "gcs_origin";
    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;

    # these pages are ready for HTTPS
    if ( !req.http.Fastly-SSL ) {
      call redirect_to_https;
    }
  }
}

sub miss_pass_route_newsroom_files_gcs {
  if (req.http.x-nyt-route == "newsroom-files-gcs") {
    call miss_pass_set_bucket_auth_headers;
  }
}
