sub recv_route_community_svc {

    # if the cmd ~= GetCommentsAll, GetCommentSummary, GetUserCommentSummary, GetCommentsReadersPicks, GetCommentsNYTPicks, GetCommentsNYTReplies
    # but NOT GetBasicInfo
    # and if the user is anon / guest cookie
    if ( req.url ~ "^/svc/community" ) {

        if (req.url ~ "cmd=Get((?!BasicInfo)[^&]+)"
            && (!req.http.x-nyt-s || req.http.x-nyt-s ~ "^0")) {

            set req.http.x-pagetype = "community-svc-cacheable";
            set req.http.x-nyt-backend = "community_svc";

            # sub in "/esi/jsonp-callback" as the callback parameter
            # hack to be able to cache jsonp
            set req.url = regsub(req.url,
                "([\?&])callback=[a-zA-Z0-9_][^&]+",
                "\1callback=%3Cesi%3Ainclude%2520src%3D%22%2Fesi%2Fjsonp-callback%22%2F%3E");
        } else {
            set req.http.x-pagetype = "community-svc";
            set req.http.x-nyt-backend = "community_svc";

            # these requests MUST NOT be cached, force pass
            set req.http.x-nyt-force-pass = "true";
        }
    }
}

sub miss_pass_route_community_svc {

  // cacheable community svc requests are ESI jsonp
  // they can not be compressed from the origin
  if(req.http.x-pagetype == "community-svc-cacheable"){
    unset bereq.http.accept-encoding;
    unset req.http.accept-encoding;
  }

}

sub fetch_route_community_svc {

  # hacky, TODO: fix the backends
  # unset headers for cacheable community requests
  if (req.http.x-pagetype == "community-svc-cacheable") {
    esi;
    unset beresp.http.cache-control;
    unset beresp.http.pragma;
  }

}
