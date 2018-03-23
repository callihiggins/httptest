sub recv_route_switchboard {
  if ( req.url.path ~ "^/movies"
    || req.url.path ~ "^/best-sellers"
    || req.url.path ~ "^/theater"
    || req.url.path ~ "^/restaurants/"
    || req.url.path ~ "^/listings"
    || req.url.path ~ "^/briefing"
    || req.url.path ~ "^/ambriefing"
    || (req.url.path ~ "^/thedaily" && req.url.path !~ "^/thedailyoffer")
  )
  ) {
    set req.http.x-pagetype = "switchboard";
    set req.http.x-nyt-backend = "switchboard";
    unset req.http.Cookie;
    unset req.http.X-Cookie;
  }
}
