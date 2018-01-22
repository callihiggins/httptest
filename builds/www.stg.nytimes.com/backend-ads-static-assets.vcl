sub vcl_recv {
  if (req.url.path ~ "^/ads/" && req.http.x-environment ~ "dev") {
    set req.http.X-PageType = "ads-static-assets";
    set req.http.x-nyt-backend = "ads_static-assets";
    set req.backend = F_ads_static_assets;
    set bereq.http.host = "nyt-ads-static-assets.storage.googleapis.com";
    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;
    unset req.http.Authorization;
  }
}
