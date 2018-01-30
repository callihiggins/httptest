sub vcl_recv {
  if (req.http.X-PageType == "newsdev-gke") {

    // Bypass cache for certain /svc/int routes
    if (
         req.url ~ "^(/svc/int/balloteer/ballot/[a-z0-9\-]*/current_user|/svc/int/balloteer/ballot/[a-z0-9\-]*/user_ballot(/\w+)?|/svc/int/balloteer/ballot/[a-z0-9\-]*/user_ballot/\w+/update|/svc/int/balloteer/ballot/[a-z0-9\-]*/update_picks)"
      || req.url ~ "^/svc/int/godzown/u"
      || req.url ~ "^/svc/int/dialects"
      || req.url ~ "^/svc/int/grandmominator"
      || req.url ~ "^/svc/int/attribute"
    ) {
      return (pass);
    }

    // Querystring parameter filters
    if ( req.url ~ "^/svc/int/balloteer" ) {
      set req.url = querystring.regfilter(req.url, "^(?!callback)");
    } else if ( req.url ~ "^/svc/int/dialects" ) {
      set req.url = querystring.regfilter(req.url, "^(?!a)");
    }

    // Strip Cookie from GET and HEAD requests where it is not needed,
    // to avoid passing unnecessarily large headers through to the backend.
    if ( req.request == "GET" || req.request == "HEAD" ) {
      unset req.http.Cookie;
    }

    // These are internal VCL headers and should not be sent to
    // the backend for any type of request.
    unset req.http.X-Cookie;
    unset req.http.x-nyt-edition;
    unset req.http.x-nyt-s;
    unset req.http.x-nyt-wpab;
  }
}

sub vcl_fetch {
  if (req.http.X-PageType == "newsdev-gke") {
    unset beresp.http.X-Amz-Id-2;
    unset beresp.http.X-Amz-Request-Id;
    unset beresp.http.X-Request-Id;

    # remove this header in prd
    if (!req.http.x-nyt-internal-access && req.http.x-environment == "prd") {
      unset beresp.http.X-Kubernetes-Url;
    }

    # cache ttl override
    set beresp.http.x-nyt-ttl-override = "300";
  }

}
