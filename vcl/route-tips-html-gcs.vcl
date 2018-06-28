sub recv_route_tips_html_gcs {
  if ( req.url ~ "^/tips" ) {
    set req.http.x-nyt-route = "tips-html-gcs";
    set req.http.x-nyt-backend = "gcs_origin";
    set req.url = querystring.remove(req.url);
    set req.http.var-nyt-no-referrer = "true";
    set req.http.Fastly-Client-IP = "0.0.0.0";

    if ( req.http.Referer ~ "www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com/tips(/)?(\?.*)?$" ) {
        unset req.http.Referer;
    }

    # these pages are ready for HTTPS
    if ( !req.http.Fastly-SSL ) {
      # This will expose user information. Should we instead show a different page or deny access?
      call redirect_to_https;
    }
  }
}

sub miss_pass_route_tips_html_gcs {
  if (req.http.x-nyt-route == "tips-html-gcs") {
    unset bereq.http.cookie;
    call miss_pass_set_bucket_auth_headers;
  }
}

sub deliver_tips_html_gcs {
  if (req.http.var-nyt-no-referrer == "true") {
      set resp.http.Referrer-Policy = "no-referrer";
  }
}
