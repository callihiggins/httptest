sub recv_route_zone_apex_redirect {

    # redirect nytimes.com to www.nytimes.com
    # Per DV-4865, we are temporarily allowing Apple to request this file from nytimes.com without redirecting to www
    if (req.http.host == "nytimes.com" && req.url.path != "/.well-known/apple-developer-domain-association.txt") {
        # forcing this to https, if the asset does not support https it will be redirected again
        declare local var.target_url STRING;
        set var.target_url = "https://www.nytimes.com" + req.url;
        set req.http.var-nyt-redirect-reason = "redir=[zone-apex]";
        error 770 var.target_url;
    }
}
