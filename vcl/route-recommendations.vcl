sub recv_route_recommendations {
  if (req.url.path ~ "^/recommendations") {
    set req.http.x-nyt-route = "recommendations";
    set req.http.x-nyt-backend = "recommendations";
    set req.http.var-nyt-force-pass = "true";
    set req.http.var-nyt-send-gdpr = "true";
  }
}

sub miss_pass_route_recommendation {
  if (req.http.x-nyt-route == "recommendation") {
    set bereq.url = "/recommendations" + bereq.url;
  }
}
