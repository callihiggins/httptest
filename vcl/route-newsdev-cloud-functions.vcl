sub recv_route_newsdev_cloud_functions {
  if (req.url.path ~ "^/svc/int/functions/") {
    set req.http.x-nyt-route = "newsdev-cloud-functions";
    set req.http.x-nyt-backend = "newsdev_cloud_functions_us_central1";
    set req.http.var-nyt-force-pass = "true";
  }
}

sub miss_pass_route_newsdev_cloud_functions {
  if (req.http.x-nyt-route == "newsdev-cloud-functions") {
    # Replace the fastly-www routing prefix with the name of the Google Cloud
    # Function, where it is deployed. Also add the `www-` prefix used to
    # expose functions to Fastly.
    # /svc/int/functions/test > /www-test

    set bereq.url = regsub(req.url, "^/svc/int/functions/", "/www-");

    if (req.http.var-nyt-env == "dev" || req.http.var-nyt-env == "stg") {
      set bereq.http.host = "us-central1-nytint-stg.cloudfunctions.net";
    } else {
      set bereq.http.host = "us-central1-nytint-prd.cloudfunctions.net";
    }
  }
}

sub deliver_route_newsdev_cloud_functions_access_control {
  if (req.http.x-nyt-route == "newsdev-cloud-functions") {
    // Block responses to missing functions / 302s
    if (resp.status == 302 && resp.http.location ~ "https://accounts.google.com") {
      set resp.status = 404;
      unset resp.http.location;
    }
  }
}
