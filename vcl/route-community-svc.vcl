sub recv_route_community_svc {

    if ( req.url ~ "^/svc/community" ) {

        # set the backend to community_svc for all routes
        set req.http.x-nyt-backend = "community_svc";

        # we only allow caching here if the command is not BasicInfo or
        # the user is not logged in or cacheable=true
        declare local var.cookie-nyt-s STRING;
        if (req.http.Cookie:NYT-S) {
            set var.cookie-nyt-s = urldecode(req.http.Cookie:NYT-S);
        }

        if ( subfield(req.url.qs, "cacheable", "&") == "true" ||
            ( subfield(req.url.qs, "cmd", "&") ~ "Get(?!BasicInfo).+"
            && (!var.cookie-nyt-s || var.cookie-nyt-s ~ "^0"))) {

            set req.http.x-nyt-route = "community-svc-cacheable";

            # sub in an esi include for "/esi/jsonp-callback" as the callback parameter
            # hack to be able to cache jsonp responses
            set req.url = regsub(req.url,
                "([\?&])callback=[a-zA-Z0-9_][^&]+",
                "\1callback=%3Cesi%3Ainclude%2520src%3D%22%2Fesi%2Fjsonp-callback%22%2F%3E" );

            # remove the jquery cache busting parameter so we can cache this..
            set req.url = querystring.filter(req.url, "_");

        } else {
            set req.http.x-nyt-route = "community-svc";

            # these requests MUST NOT be cached, force pass
            set req.http.var-nyt-force-pass = "true";
        }
    }
}

sub miss_pass_route_community_svc {

  // cacheable community svc requests are ESI jsonp
  // they cannot be compressed from the origin
  if(req.http.x-nyt-route == "community-svc-cacheable"){
    unset bereq.http.accept-encoding;
    unset req.http.accept-encoding;
  }

}

sub fetch_route_community_svc {

  # unset headers for cacheable community requests, we're using default TTL
  # turn on ESI processing for the callback param inclusion
  if (req.http.x-nyt-route == "community-svc-cacheable") {
    esi;
    unset beresp.http.cache-control;
    unset beresp.http.pragma;
    unset beresp.http.expires;
  }

}
