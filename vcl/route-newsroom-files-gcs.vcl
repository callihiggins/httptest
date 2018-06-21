sub recv_route_newsroom_files_gcs {
  if ( req.url ~ "^/files/" ) {
    set req.http.x-nyt-route = "newsroom-files-gcs";
    set req.http.x-nyt-backend = "gcs_origin";
    set req.url = querystring.remove(req.url);

    # these pages are ready for HTTPS
    if ( !req.http.Fastly-SSL ) {
      call redirect_to_https;
    }
  }
}

sub miss_pass_route_newsroom_files_gcs {
  if (req.http.x-nyt-route == "newsroom-files-gcs") {
    unset bereq.http.cookie;
    call miss_pass_set_bucket_auth_headers;
  }
}
