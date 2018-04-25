sub recv_route_paidpost {
  // entire paidpost hostname is NYT5
  if (req.http.host ~ "^paidpost([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$"
      && req.url.ext == "html") {
      set req.http.X-PageType = "paidpost";
      set req.http.x-nyt-backend = "paidpost_fe";
      set req.http.x-nyt-wf-auth = "true";
  }
}
