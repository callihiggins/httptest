sub vcl_recv {
    if (req.url ~ "^/elections?(?:/|\?|$)") {
        set req.http.X-PageType = "elections";
        call set_newsdev_elections_backend;

        unset req.http.Cookie;
        unset req.http.X-Cookie;
        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-wpab;

        # Redirect to https before updating req.http.host header
        if ( !req.http.Fastly-SSL ) {
          call redirect_to_https;
        }
    }
}

sub vcl_miss {
  if (req.http.X-PageType == "elections") {
    call set_newsdev_elections_authorization;
  }
}

sub vcl_pass {
  if (req.http.X-PageType == "elections") {
    call set_newsdev_elections_authorization;
  }
}

sub vcl_fetch {
    if (req.http.X-PageType == "elections") {

        # redirect
        if (beresp.http.x-amz-meta-website-redirect-location) {
          set req.http.Location = beresp.http.x-amz-meta-website-redirect-location;
          error 760 "Moved Permanently";
        }

        # stale-while-revalidate override
        set beresp.http.x-nyt-stale-while-revalidate = "30";
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "elections") {
        set resp.http.X-API-Version = "I";
    }
}

sub vcl_error {
    if (req.http.X-PageType == "elections") {
        # Fake behavior of Amazon's WebsiteRedirectLocation
        if (obj.status == 760) {
          set obj.http.Location = req.http.Location;
          set obj.status = 301;
          return(deliver);
        }
    }
}

sub set_newsdev_elections_backend {
    if (table.lookup(newsdev_elections, "use_s3", "false") == "true") {

        set req.backend = F_newsdev_elections_s3;
        set req.http.x-nyt-backend = "newsdev_elections_s3";

        if (req.http.x-environment == "dev") {
            set req.http.x-bucket = "nytint-stg-elections";
        } else if (req.http.x-environment == "stg") {
            set req.http.x-bucket = "nytint-stg-elections";
        } else {
            set req.http.x-bucket = "nytint-prd-elections";
        }

    } else {

        set req.backend = F_newsdev_elections;
        set req.http.x-nyt-backend = "newsdev_elections";

        if (req.http.x-environment == "dev") {
            set req.http.x-bucket = "nytint-stg-elections";
        } else if (req.http.x-environment == "stg") {
            set req.http.x-bucket = "nytint-stg-elections";
        } else {
            set req.http.x-bucket = "nytint-prd-elections";
        }
    }
}

# Sets backend request headers sent to GCS or S3 used to
# authenticate the request.
sub set_newsdev_elections_authorization {
    set bereq.http.date = now;
    if (table.lookup(newsdev_elections, "use_s3", "false") == "true") {
        set bereq.http.host = req.http.x-bucket ".s3.amazonaws.com";
        set bereq.http.authorization = "AWS " table.lookup(newsdev_elections, "s3_access_key") ":" digest.hmac_sha1_base64(table.lookup(newsdev_elections, "s3_secret"), "GET" LF LF LF bereq.http.date LF "/" req.http.x-bucket req.url.path);
    } else {
        set bereq.http.host = req.http.x-bucket ".storage.googleapis.com";
        set bereq.http.authorization = "AWS " table.lookup(newsdev_elections, "access_key") ":" digest.hmac_sha1_base64(table.lookup(newsdev_elections, "secret"), "GET" LF LF LF bereq.http.date LF "/" req.http.x-bucket req.url.path);
    }
}

