sub recv_route_newsdev_attribute {
   if ( req.url ~ "^/svc/int/attribute/projects/" ) {
    set req.http.x-nyt-route = "newsdev-attribute";
    set req.http.x-nyt-backend = "newsdev_cloud_functions_us_central1";
    set req.url = querystring.remove(req.url);
   }
}

sub miss_pass_route_newsdev_attribute {
  if (req.http.x-nyt-route == "newsdev-attribute") {

    if (!req.backend.is_shield) {
      set bereq.http.host = bereq.http.x-cf-host;
      set bereq.http.X-OldURL = bereq.url;
      set bereq.url = regsub(bereq.url, "^/svc/int/attribute/projects/([^/]+)/submissions.json", "/attribute-submission/\1");
      unset bereq.http.x-cf-host;
    }
  }
}
