sub vcl_recv {
  if (req.http.X-PageType == "intl") {
    if (req.request != "GET" &&
        req.request != "HEAD" &&
        req.request != "FASTLYPURGE"
    ) {
      error 405 "Not allowed.";
    }

    # Bypass cache for logged-in WordPress users, etc.
    if (req.http.Cookie ~ "comment_author_|wordpress_(?!test_cookie)|wp-postpass_" ) {
      return (pass);
    }

    unset req.http.Cookie;
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;
  }
}

sub vcl_fetch {
  if (req.http.X-PageType == "intl") {

    # don't return this header in prd
    if (!req.http.x-nyt-internal-access && req.http.x-environment == "prd") {
      unset beresp.http.X-Kubernetes-Url;
    }
  }

}
