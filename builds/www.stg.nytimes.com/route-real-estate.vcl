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
        # so that we don't return users data.
        if (   req.url ~ "^/real-estate/api/mail"
            || req.url ~ "^/real-estate/api/personalization"
        ) {
            // We want to pass the NYT-S cookie only to the realestate backend
            // becasue of the 8k headers size limit
            set req.http.Cookie = "NYT-S=" req.http.Cookie:NYT-S ";";
            set req.http.var-nyt-force-pass = "true";
            #return(pass);
        }
    }
}
