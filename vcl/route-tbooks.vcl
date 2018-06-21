sub recv_route_tbooks {
    if (req.http.var-nyt-canonical-www-host) {
        if (req.url ~ "^/tbooks") {
            set req.http.x-nyt-route = "tbooks";
            set req.http.x-nyt-backend = "tbooks";
            set req.http.var-nyt-send-gdpr = "true";
            set req.http.var-nyt-force-pass = "true";
        }
    }
}

sub miss_pass_route_tbooks {
  # If it's a request to the tbooks homepage we need to leave the / at the end so that
  # the path "exists". Otherwise, we should remove the whole /tbooks from the path.
  # Removing the whole path is causing errors on the wordpress side where they state
  # they could not read the request
  if(req.http.x-nyt-route == "tbooks") {

    # We want to pass the NYT-S cookie only to the tbooks backend
    # becasue of the 8k headers size limit
    set bereq.http.cookie = "NYT-S=" req.http.cookie:NYT-S ";";

    if (bereq.url.path == "/tbooks") {
        set bereq.url = regsub(bereq.url, "^/tbooks", "/");
    } else {
        set bereq.url = regsub(bereq.url, "^/tbooks", "");
    }
    set bereq.http.host = "nytinsider.wordpress.com";
  }
}

sub deliver_tbooks_api_version {
    if (req.http.x-nyt-route == "tbooks") {
        set resp.http.X-API-Version = "TB";
    }
}
