sub recv_route_tips {
    # remove source IP and Referer from tips related pages
    # https://jira.nyt.net/browse/DV-237
    if (   req.url ~ "^/tips(/)?(\?.*)?$"
        || req.url == "/securedrop"
        || req.url ~ "^/newsgraphics/2016/news-tips"
    ) {
        set req.http.x-nyt-route = "tips";
        set req.http.var-nyt-no-referrer = "true";
        set req.http.x-nyt-backend = "www_legacy_gke";
        set req.http.Fastly-Client-IP = "0.0.0.0";
        unset req.http.Referer;
    }

    # if the Referer for this request is any of the tips pages, unset it
    if (   req.http.Referer ~ "www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com/tips(/)?(\?.*)?$"
        || req.http.Referer == "www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com/securedrop"
        || req.http.Referer ~ "www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com/newsgraphics/2016/news-tips"
    ) {
        unset req.http.Referer;
    }
}

sub deliver_route_tips {
    if (req.http.var-nyt-no-referrer == "true") {
        set resp.http.Referrer-Policy = "no-referrer";
    }
}
