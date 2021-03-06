sub recv_route_elections {
    if (req.url ~ "^/elections?(?:/|\?|$)") {
        set req.http.x-nyt-route = "elections";
        set req.http.var-nyt-send-gdpr = "true";
        set req.url = querystring.remove(req.url);

        ## set elections backend
        if (table.lookup(newsdev_elections, "use_s3", "false") == "true") {
            set req.http.x-nyt-backend = "newsdev_elections_s3";

            if (req.http.var-nyt-env == "dev") {
                set req.http.var-nyt-elections-bucket = "nytint-stg-elections";
            } else if (req.http.var-nyt-env == "stg") {
                set req.http.var-nyt-elections-bucket = "nytint-stg-elections";
            } else {
                set req.http.var-nyt-elections-bucket = "nytint-prd-elections";
            }
        } else {
            set req.http.x-nyt-backend = "newsdev_elections";

            if (req.http.var-nyt-env == "dev") {
                set req.http.var-nyt-elections-bucket = "nytint-stg-elections";
            } else if (req.http.var-nyt-env == "stg") {
                set req.http.var-nyt-elections-bucket = "nytint-stg-elections";
            } else {
                set req.http.var-nyt-elections-bucket = "nytint-prd-elections";
            }
        }

        # Redirect to https before updating req.http.host header
        if ( !req.http.Fastly-SSL ) {
          call redirect_to_https;
        }
    }
}

sub fetch_route_elections {
  if (req.http.x-nyt-route == "elections") {

    # on GCS/S3 unauthorized or not found
    if (beresp.status == 404 || beresp.status == 403) {

      # deliver cached response if available
      if (stale.exists) {
        return(deliver_stale);
      }
    }
  }
}

# Sets backend request headers sent to GCS or S3 used to
# authenticate the request.
sub miss_pass_route_elections {
  if (req.http.x-nyt-route == "elections") {

    unset bereq.http.cookie;

    set bereq.http.date = now;
    if (table.lookup(newsdev_elections, "use_s3", "false") == "true") {
        set bereq.http.host = req.http.var-nyt-elections-bucket ".s3.amazonaws.com";
        set bereq.http.authorization = "AWS " table.lookup(newsdev_elections, "s3_access_key") ":" digest.hmac_sha1_base64(table.lookup(newsdev_elections, "s3_secret"), "GET" LF LF LF bereq.http.date LF "/" req.http.var-nyt-elections-bucket req.url.path);
    } else {
        set bereq.http.host = req.http.var-nyt-elections-bucket ".storage.googleapis.com";
        set bereq.http.authorization = "AWS " table.lookup(newsdev_elections, "access_key") ":" digest.hmac_sha1_base64(table.lookup(newsdev_elections, "secret"), "GET" LF LF LF bereq.http.date LF "/" req.http.var-nyt-elections-bucket req.url.path);
    }
  }
}

sub fetch_elections_redirect {
    if (req.http.x-nyt-route == "elections") {

        # redirect
        if (beresp.http.x-amz-meta-website-redirect-location) {
          error 770 beresp.http.x-amz-meta-website-redirect-location;
        }

        # stale-while-revalidate override
        set beresp.http.x-nyt-stale-while-revalidate = "30";
    }
}

sub deliver_elections_api_version {
    if (req.http.x-nyt-route == "elections") {
        set resp.http.X-API-Version = "I";
    }
}

sub deliver_route_elections_gcs_error {
  if (req.http.x-nyt-route == "elections") {

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
