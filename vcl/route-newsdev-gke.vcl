sub recv_route_newsdev_gke {

    # MAKE SURE recv_route_newsdev_attribute is AFTER THIS FUNCTION CALL in vcl_recv
    # it has a more specific route than /svc/int
    if (req.url ~ "^/svc/int/"
        || req.url ~ "^/interactive/projects/guantanamo"
    ) {
        set req.http.x-nyt-route = "newsdev-gke";
        set req.http.x-nyt-backend = "newsdev_k8s_gke";
        set req.http.var-nyt-send-gdpr = "true";

        // Bypass cache for certain /svc/int routes
        if (
             req.url ~ "^/svc/int/godzown/u"
          || req.url ~ "^/svc/int/dialects"
          || req.url ~ "^/svc/int/attribute"
        ) {
          set req.http.var-nyt-force-pass = "true";
        }
    }
}

sub fetch_route_newsdev_gke {
  if (req.http.x-nyt-route == "newsdev-gke") {
    unset beresp.http.X-Amz-Id-2;
    unset beresp.http.X-Amz-Request-Id;
    unset beresp.http.X-Request-Id;

    # remove this header in prd
    if ( !(req.http.x-nyt-nyhq-access == "1") && req.http.var-nyt-env == "prd") {
      unset beresp.http.X-Kubernetes-Url;
    }

    # cache ttl override
    set beresp.http.x-nyt-ttl-override = "300";
  }

}
