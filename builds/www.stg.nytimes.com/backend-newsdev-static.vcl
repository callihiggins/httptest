sub vcl_recv {
  if (req.http.X-PageType == "newsdev-static") {
    set req.grace = 24h;

    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;
  }
}

sub vcl_fetch {
  if (req.http.X-PageType == "newsdev-static") {
    unset beresp.http.X-Amz-Id-2;
    unset beresp.http.X-Amz-Request-Id;
    unset beresp.http.X-Request-Id;
    unset beresp.http.X-Kubernetes-Url;

    // use very short cache TTL for HTTP 4XXs
    if (beresp.status >= 400 && beresp.status < 500) {
      set beresp.ttl = 3s;
    } else {
      set beresp.ttl = 300s;
    }

    if (beresp.status >= 500) {
      /* deliver stale if the object is available */
      if (stale.exists) {
        return(deliver_stale);
      }
      return(restart);
    }

    set beresp.stale_if_error = 86400s;
    set beresp.stale_while_revalidate = 30s;
  }
}
