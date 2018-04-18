sub recv_route_newsletters {
  // newsletter application
    if (   req.url ~ "^/newsletters/"
        || req.url ~ "^/newsletters?"
        || req.url ~ "^/newsletters$"
    ) {
        set req.http.X-PageType = "newsletter";
        set req.http.x-nyt-backend = "projectvi_fe";
        set req.http.x-nyt-wf-auth = "true";
        set req.http.x--fastly-project-vi = "1";
    }
}
