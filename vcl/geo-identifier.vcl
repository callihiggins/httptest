# This is a small library to identify the client's location and drop a cookie.
# Additional values may come but for now it will just set the value
# as a two character country code

sub deliver_geo_cookie {
    if (req.http.x-nyt-route == "vi-homepage" ||
        req.http.x-nyt-route == "vi-story") {
        add resp.http.Set-Cookie =
            "nyt-geo="+ req.http.x-nyt-country + "; "+ 
            "Expires=" + time.add(now, 6h) + "; "+
            "Path=/; "+
            "Domain=.nytimes.com";
    }
}
