sub recv_route_messaging {
  if (req.url.path ~ "^/svc/(pushmobile|message)/") {
    set req.http.x-pagetype = "messaging";
    set req.http.x-nyt-backend = "messaging";
  }
}
