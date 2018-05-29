sub recv_route_messaging {
  if (req.url.path ~ "^/svc/(pushmobile|message)/") {
    set req.http.x-nyt-route = "messaging";
    set req.http.x-nyt-backend = "messaging";
    set req.url = querystring.remove(req.url);
  }
}
