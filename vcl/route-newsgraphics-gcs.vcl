sub recv_route_newsgraphics_gcs {

  if (req.url ~ "^/newsgraphics/" || req.url ~ "^/projects/") {
    set req.http.x-nyt-route = "newsgraphics-gcs";
    set req.http.x-nyt-backend = "gcs_origin";
    set req.http.var-nyt-send-gdpr = "true";
    set req.url = querystring.remove(req.url);

    # remove the client ip from assets that exist on the old tips page
    if(req.url.path ~ "^/newsgraphics/2016/news-tips") {
      set req.http.Fastly-Client-IP = "0.0.0.0";
    }
  }
}

sub miss_pass_route_newsgraphics_gcs {
  if (req.http.x-nyt-route == "newsgraphics-gcs") {
    unset bereq.http.cookie;
    call miss_pass_set_bucket_auth_headers;
  }
}

sub fetch_route_newsgraphics_gcs {
  if (req.http.x-nyt-route == "newsgraphics-gcs") {
    # Fake behavior of Amazon's WebsiteRedirectLocation
    if (beresp.http.x-amz-meta-website-redirect-location) {
      error 770 beresp.http.x-amz-meta-website-redirect-location;
    }
  }
}

sub deliver_route_newsgraphics_gcs_error {
  if (req.http.x-nyt-route == "newsgraphics-gcs") {

    # If the gcs object returns a 404, serve a custom 404 error page
    if (resp.status == 404 && req.restarts < 1) {
      set req.http.var-nyt-404-url = "/interactive/projects/404.html";
      call deliver_custom_404_error;
    }
    # Since the custom 404 page is successfully found,
    # restore the original status code
    if (req.http.var-nyt-404-url && req.restarts > 0) {
      set resp.status = 404;
    }

  }
}
