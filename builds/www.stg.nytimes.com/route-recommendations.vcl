sub recv_route_recommendations {
  if (req.url.path ~ "^/recommendations") {
    set req.http.x-nyt-route = "recommendations";
    set req.http.x-nyt-backend = "recommendations";
    set req.http.x-nyt-force-pass = "true";
  }
}
