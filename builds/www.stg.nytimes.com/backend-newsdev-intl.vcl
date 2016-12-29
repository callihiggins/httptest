sub vcl_recv {
  if (req.http.X-PageType == "newsdev-intl") {
    if (req.request != "GET" &&
      req.request != "HEAD") {
      error 405 "Not allowed.";
    }

    # Bypass cache for logged-in WordPress users, etc.
    if (req.http.Cookie ~ "comment_author_|wordpress_(?!test_cookie)|wp-postpass_" ) {
      return (pass);
    }

    set req.grace = 24h;

    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;
  }
}

sub vcl_fetch {
  if (req.http.X-PageType == "newsdev-intl") {
    unset beresp.http.X-Amz-Id-2;
    unset beresp.http.X-Amz-Request-Id;
    unset beresp.http.X-Request-Id;
    
    if ( client.ip !~ internal && req.http.x-environment == "prd") {
      unset beresp.http.X-Kubernetes-Url;
    }

    // use very short cache TTL for HTTP 4XXs
    if (beresp.status >= 400 && beresp.status < 500) {
      set beresp.ttl = 3s;
    } else {
      // default 2 minutes
      set beresp.ttl = 120s;
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
