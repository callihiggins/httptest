sub recv_route_gdpr_form {
  if (req.http.var-nyt-canonical-www-host == "true" && req.url.path ~ "^/data-subject-request") {
    set req.http.x-nyt-route = "gdpr-form";
    set req.http.x-nyt-backend = "projectvi_fe";
    set req.http.var-nyt-error-retry = "false";
    set req.http.var-nyt-wf-auth = "true";
    set req.http.var-nyt-send-gdpr = "true";
    set req.url = querystring.remove(req.url);
  }
}
