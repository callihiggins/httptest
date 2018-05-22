sub recv_route_paidpost {
  // entire paidpost hostname is NYT5
  if (req.http.host ~ "^paidpost([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$"
      && req.url.ext == "html") {
      set req.http.x-nyt-route = "paidpost";
      set req.http.x-nyt-backend = "paidpost_fe";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";
  }
}

sub miss_pass_route_paidpost {
  if (req.http.x-nyt-route == "paidpost") {
    unset bereq.http.cookie;
  }
}
