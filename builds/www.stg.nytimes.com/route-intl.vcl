sub recv_route_intl {
  if ((req.url == "/es") || (req.url ~ "^/es/")
      || (req.url == "/global") || (req.url ~ "^/global/")) {
      set req.http.x-nyt-route = "intl";
      set req.http.x-nyt-backend = "intl_gcp";
      set req.http.x-nyt-wf-auth = "true";

    if (req.request != "GET" &&
        req.request != "HEAD" &&
        req.request != "FASTLYPURGE"
    ) {
      error 405 "Not allowed.";
    }

    # Bypass cache for logged-in WordPress users, etc.
    if (req.http.Cookie ~ "comment_author_|wordpress_(?!test_cookie)|wp-postpass_" ) {
      set req.http.x-nyt-force-pass = "true";
    } else {
      unset req.http.Cookie;
      unset req.http.X-Cookie;
      unset req.http.x-nyt-edition;
      unset req.http.x-nyt-s;
      unset req.http.x-nyt-wpab;
    }
  }
}

sub fetch_route_intl_headers {
  if (req.http.x-nyt-route == "intl") {
    # don't return this header in prd
    if (!req.http.x-nyt-internal-access && req.http.x-environment == "prd") {
      unset beresp.http.X-Kubernetes-Url;
    }
  }

}
