sub recv_route_recommendations {
  if (req.url.path ~ "^/recommendations") {
    set req.http.x-pagetype = "recommendations";
    set req.http.x-nyt-backend = "recommendations";
    set req.http.x-nyt-force-pass = "true";
  }
}
