sub recv_route_elections {
    if (req.url ~ "^/elections?(?:/|\?|$)") {
        set req.http.x-nyt-route = "elections";
        set req.http.var-nyt-send-gdpr = "true";
        ## set elections backend
        if (table.lookup(newsdev_elections, "use_s3", "false") == "true") {
            set req.http.x-nyt-backend = "newsdev_elections_s3";

            if (req.http.var-nyt-env == "dev") {
                set req.http.x-bucket = "nytint-stg-elections";
            } else if (req.http.var-nyt-env == "stg") {
                set req.http.x-bucket = "nytint-stg-elections";
            } else {
                set req.http.x-bucket = "nytint-prd-elections";
            }
        } else {
            set req.http.x-nyt-backend = "newsdev_elections";

            if (req.http.var-nyt-env == "dev") {
                set req.http.x-bucket = "nytint-stg-elections";
            } else if (req.http.var-nyt-env == "stg") {
                set req.http.x-bucket = "nytint-stg-elections";
            } else {
                set req.http.x-bucket = "nytint-prd-elections";
            }
        }

        # Redirect to https before updating req.http.host header
        if ( !req.http.Fastly-SSL ) {
          call redirect_to_https;
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
        set bereq.http.host = req.http.x-bucket ".s3.amazonaws.com";
        set bereq.http.authorization = "AWS " table.lookup(newsdev_elections, "s3_access_key") ":" digest.hmac_sha1_base64(table.lookup(newsdev_elections, "s3_secret"), "GET" LF LF LF bereq.http.date LF "/" req.http.x-bucket req.url.path);
    } else {
        set bereq.http.host = req.http.x-bucket ".storage.googleapis.com";
        set bereq.http.authorization = "AWS " table.lookup(newsdev_elections, "access_key") ":" digest.hmac_sha1_base64(table.lookup(newsdev_elections, "secret"), "GET" LF LF LF bereq.http.date LF "/" req.http.x-bucket req.url.path);
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
