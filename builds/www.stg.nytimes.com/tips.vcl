sub vcl_recv {
    // remove source IP from tips related pages
    // https://jira.nyt.net/browse/DV-237
    if (   req.url ~ "^/tips(/)?(\?.*)?$"
        || req.url == "/securedrop"
        || req.url ~ "^/newsgraphics/2016/news-tips"
    ) {
        set req.http.Fastly-Client-IP = "0.0.0.0";
        unset req.http.Referer;
    }

    if (   req.http.Referer ~ "www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com/tips(/)?(\?.*)?$"
        || req.http.Referer == "www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com/securedrop"
        || req.http.Referer ~ "www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com/newsgraphics/2016/news-tips"
    ) {
        unset req.http.Referer;
    }
}

sub vcl_deliver {
    if (   req.url ~ "^/tips(/)?(\?.*)?$"
        || req.url == "/securedrop"
        || req.url ~ "^/newsgraphics/2016/news-tips"
    ) {
        set resp.http.Referrer-Policy = "no-referrer";
    }
}
