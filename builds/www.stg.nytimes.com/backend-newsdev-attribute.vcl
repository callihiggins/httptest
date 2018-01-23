sub vcl_recv {
   if ( req.url ~ "^/svc/int/attribute/projects/" ) {
    set req.http.X-PageType = "newsdev-attribute";
    set req.http.X-OldURL = req.url;
    set req.url = regsub(req.url, "^/svc/int/attribute/projects/([^/]+)/submissions.json", "/attribute-submission/\1");
   }
}
sub vcl_miss {
  if (req.http.X-PageType == "newsdev-attribute") {
    set bereq.http.host = req.http.x-cf-host;
    unset req.http.x-cf-host;
  }
}

sub vcl_pass {
  if (req.http.X-PageType == "newsdev-attribute") {
    set bereq.http.host = req.http.x-cf-host;
    unset req.http.x-cf-host;
  }
}
