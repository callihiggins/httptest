sub recv_route_newsdev_cloud_functions {
  // For now, whitelist only the contact-reporter function.
  // In future, could possibly manage a whitelist of functions to let through
  // with an edge dictionary.
  if ( req.url.path ~ "^/svc/int/functions/contact-reporter" ) {
    set req.http.x-nyt-route = "newsdev-cloud-functions";
    set req.http.x-nyt-backend = "newsdev_cloud_functions_us_central1";
  }
}

sub miss_pass_route_newsdev_cloud_functions {
  if (req.http.x-nyt-route == "newsdev-cloud-functions") {
    // set function name
    set bereq.url = regsub(req.url, "^/svc/int/functions/", "/");

    if (req.http.var-nyt-env == "dev" || req.http.var-nyt-env == "stg") {
      set bereq.http.host = "us-central1-nytint-stg.cloudfunctions.net";
    } else {
      set bereq.http.host = "us-central1-nytint-prd.cloudfunctions.net";
    }
  }
}

sub deliver_route_newsdev_cloud_functions_access_control {
  if (req.http.x-nyt-route == "newsdev-cloud-functions") {
    set resp.http.Access-Control-Allow-Origin = "*";
  }
}
