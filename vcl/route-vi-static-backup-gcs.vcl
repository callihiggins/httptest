sub recv_route_vi_static_backup_gcs {
  # If the static backup is enabled, point to the gcs backend.
  if (req.http.var-is-vi-static-backup-enabled == "true") {
    set req.http.var-nyt-wf-auth = "false";
    set req.http.x-nyt-backend = "projectvi_static_backup_gcs";
  }
}

sub miss_pass_route_vi_static_backup_gcs {
  if (req.http.var-is-vi-static-backup-enabled == "true"
      && (req.http.x-nyt-route == "vi-story" || req.http.x-nyt-route == "vi-homepage")) {
    unset bereq.http.cookie;

    # Prepend the path to the static backup in the gcs bucket.
    set bereq.url = "/content" + bereq.url;

    # Since the gcs bucket doesn't have document logic
    # we need to prepend index.html if it's a homepage request
    if (req.http.x-nyt-route == "vi-homepage") {
      set bereq.url = bereq.url + "index.html";
    }

    # The gcs bucket is private so we need auth.
    # Since this bucket isn't defined like other gcs-origin backends
    # (the reason for that is that we want to preserve the x-nyt-route)
    # we have to manually fill in a couple of the required headers.
    set req.http.x-nyt-bucket-auth = "true";
    # Default production bucket is in the Central cluster.
    set bereq.http.x-nyt-bucket-name = "newsreader-static-site-backup-central-prd";
    if (req.http.var-nyt-env != "prd") {
      set bereq.http.x-nyt-bucket-name = "newsreader-static-site-backup-dev";
    } else if (req.http.var-is-east-static-backup-enabled == "true") {
      set bereq.http.x-nyt-bucket-name = "newsreader-static-site-backup-prd";
    }
    set bereq.http.x-nyt-bucket-provider = "gcs";
    set bereq.http.x-nyt-bucket-token = "gcs_key";
    set bereq.http.x-nyt-bucket-secret = "gcs_secret";
    call miss_pass_set_bucket_auth_headers;
  }
}

sub fetch_route_vi_static_backup_gcs {
  # If the requested content does not exist in the static backup.
  if (req.http.var-is-vi-static-backup-enabled == "true"
      && (req.http.x-nyt-route == "vi-story" || req.http.x-nyt-route == "vi-homepage")) {
    # Remove cache from the private bucket response which has a 0 TTL
    unset beresp.http.Cache-Control;
    unset beresp.http.Expires;
    if (beresp.status != 200) {
      # Set the status to 503 so that Fastly will try to serve stale.
      set beresp.status = 503;
    }
  }
}
