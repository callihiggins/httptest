sub vcl_recv {
  if (req.url.path ~ "^/ads/" && req.http.x-environment == "dev") {
    set req.http.X-PageType = "ads-static-assets";
    set req.http.x-nyt-backend = "ads-static-assets";
    set req.http.x-nyt-gcs-private-bucket = "nyt-ads-static-assets";
    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;
  }
}

sub vcl_miss {
  if (req.http.X-PageType == "ads-static-assets") {
    set req.backend = F_adx_static; #reusing another gcs backend, TODO: consolidate all gcs backends
    set bereq.http.host = req.x-nyt-gcs-private-bucket ".storage.googleapis.com";
  }
}

sub vcl_pass {
  if (req.http.X-PageType == "ads-static-assets") {
    set req.backend = F_adx_static; #reusing another gcs backend, see todo above
    set bereq.http.host = req.x-nyt-gcs-private-bucket ".storage.googleapis.com";
  }
}
