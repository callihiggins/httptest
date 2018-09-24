sub recv_route_newsletters {
  // newsletter application
    if (   req.url ~ "^/newsletters/"
        || req.url ~ "^/newsletters?"
        || req.url ~ "^/newsletters$"
    ) {
        set req.http.x-nyt-route = "newsletter";
        set req.http.x-nyt-backend = "projectvi_fe";
        set req.http.var-nyt-error-retry = "false";
        set req.http.var-nyt-wf-auth = "true";
        unset req.http.Authorization;

        call recv_post_method_restricted;
    }
}


sub miss_pass_route_newsletters {
    if (req.http.x-nyt-route == "newsletters") {
        unset bereq.http.cookie;
    }
}

sub deliver_route_newsletters_us_cookie {
    # if the client is in the United Sates and we determine this is a newsletter page
    # set a cookie indicating this is a user in the United States
    # otherwise, set a cookie indicating the user is not in the United States
    if (req.http.x-nyt-country == "US" && req.http.x-nyt-route == "newsletter") {
        add resp.http.Set-Cookie =
            "nyt-us=1; "+
            "Expires=" + time.add(now, 6h) + "; "+
            "Path=/; "+
            "Domain=.nytimes.com";
    } else if (req.http.x-nyt-route == "newsletter") {
        add resp.http.Set-Cookie =
            "nyt-us=0; "+
            "Expires=" + time.add(now, 6h) + "; "+
            "Path=/; "+
            "Domain=.nytimes.com";
    }
}
