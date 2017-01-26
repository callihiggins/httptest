sub vcl_recv {
  if (req.http.X-PageType == "newsdev-dynamic") {

    // Bypass cache for certain /svc/int routes
    if (
         req.url ~ "^(/svc/int/balloteer/ballot/[a-z0-9\-]*/current_user|/svc/int/balloteer/ballot/[a-z0-9\-]*/user_ballot(/\w+)?|/svc/int/balloteer/ballot/[a-z0-9\-]*/user_ballot/\w+/update|/svc/int/balloteer/ballot/[a-z0-9\-]*/update_picks)"
      || req.url ~ "^/svc/int/qa/questions/[a-z0-9\-]*/votes"
      || req.url ~ "^/svc/int/godzown/u"
      || req.url ~ "^/svc/int/dialects"
      || req.url ~ "^/svc/int/grandmominator"
    ) {
      return (pass);
    }

    // Querystring parameter filters
    if ( req.url ~ "^/svc/int/balloteer" ) {
      set req.url = querystring.regfilter(req.url, "^(?!callback)");
    } else if ( req.url ~ "^/svc/int/qa/questions" ) {
      set req.url = querystring.regfilter(req.url, "^(?!limit|offset|sort)");
      set req.url = querystring.sort(req.url);
    } else if ( req.url ~ "^/svc/int/dialects" ) {
      set req.url = querystring.regfilter(req.url, "^(?!a)");
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
  if (req.http.X-PageType == "newsdev-dynamic") {
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
      // default 5 minutes
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
    set beresp.stale_while_revalidate = 60s;
  }
}
