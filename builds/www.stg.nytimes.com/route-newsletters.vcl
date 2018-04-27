sub recv_route_newsletters {
  // newsletter application
    if (   req.url ~ "^/newsletters/"
        || req.url ~ "^/newsletters?"
        || req.url ~ "^/newsletters$"
    ) {
        set req.http.x-nyt-route = "newsletter";
        set req.http.x-nyt-backend = "projectvi_fe";
        set req.http.var-nyt-wf-auth = "true";
        set req.http.x--fastly-project-vi = "1";
    }
}
