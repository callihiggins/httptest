sub recv_route_newsdev_gke {

    # MAKE SURE recv_route_newsdev_attribute is AFTER THIS FUNCTION CALL in vcl_recv
    # it has a more specific route than /svc/int
    if (req.url ~ "^/svc/int/"
        || req.url ~ "^/interactive/projects/(notable-deaths|guantanamo)"
        || req.url == "/fashion/runway"
        || req.url ~ "^/fashion/runway"
    ) {
        set req.http.X-PageType = "newsdev-gke";
        set req.http.x-nyt-backend = "newsdev_k8s_gke";

        // Bypass cache for certain /svc/int routes
        if (
             req.url ~ "^(/svc/int/balloteer/ballot/[a-z0-9\-]*/current_user|/svc/int/balloteer/ballot/[a-z0-9\-]*/user_ballot(/\w+)?|/svc/int/balloteer/ballot/[a-z0-9\-]*/user_ballot/\w+/update|/svc/int/balloteer/ballot/[a-z0-9\-]*/update_picks)"
          || req.url ~ "^/svc/int/godzown/u"
          || req.url ~ "^/svc/int/dialects"
          || req.url ~ "^/svc/int/grandmominator"
          || req.url ~ "^/svc/int/attribute"
        ) {
          set req.http.x-nyt-force-pass = "true";
        } else if ( req.url ~ "^/svc/int/balloteer" ) {
          set req.url = querystring.regfilter(req.url, "^(?!callback)");
        } else if ( req.url ~ "^/svc/int/dialects" ) {
          set req.url = querystring.regfilter(req.url, "^(?!a)");
        }
    }
}

sub fetch_route_newsdev_gke {
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
