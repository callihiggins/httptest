sub recv_route_real_estate {
  // realestate application
    if (   req.url ~ "^/real-estate/"
        || req.url ~ "^/real-estate?"
        || req.url ~ "^/real-estate$"
    ) {
        set req.http.x-nyt-route = "real-estate";
        set req.http.x-nyt-backend = "realestate_fe";
        set req.http.var-nyt-wf-auth = "true";
        set req.http.var-nyt-send-gdpr = "true";
        # if we needed to switch back to NYT5, unset the vi flag
        unset req.http.x--fastly-project-vi;

        # we have to pass directly here
        # so that we don't cache private user data.
        if (   req.url ~ "^/real-estate/api/mail"
            || req.url ~ "^/real-estate/api/personalization"
        ) {
            set req.http.x-nyt-route = "real-estate-pass";
            set req.http.var-nyt-force-pass = "true";
        }
    }
}

sub miss_pass_route_real_estate {

    # We want to pass the NYT-S cookie only to the realestate backend
    # becasue of the 8k headers size limit
    if (req.http.x-nyt-route == "real-estate-pass") {
        set bereq.http.cookie = "NYT-S=" req.http.cookie:NYT-S ";";
    }

    if (req.http.x-nyt-route == "real-estate") {
        unset bereq.http.cookie;
    }
}
