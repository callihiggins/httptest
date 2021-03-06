sub recv_route_wirecutter {
    if (req.url.path ~ "^/wirecutter" && req.http.var-nyt-canonical-www-host) {
        set req.http.x-nyt-route = "wirecutter";
        set req.http.x-nyt-backend = "wirecutter";
        set req.http.var-nyt-send-gdpr = "true";
        unset req.http.Authorization;
        call recv_post_method_restricted;
    }
}

sub miss_pass_route_wirecutter {
    if (req.http.x-nyt-route == "wirecutter") {
        if (req.url.path ~ "^/wirecutter$") {
            set bereq.url = req.url "/";
        }
        if (req.http.var-nyt-env == "prd") {
            set bereq.http.host = "thewirecutter.com";
        } else if (req.http.var-nyt-env == "stg") {
            set bereq.http.host = "stage.thewirecutter.com";
        } else if (req.http.var-nyt-env == "dev") {
            set bereq.http.host = "dev.thewirecutter.com";
        }
        unset bereq.http.cookie;
    }
}

sub deliver_route_wirecutter {
    if (req.http.x-nyt-route == "wirecutter") {
        if (req.url.ext ~ "^(css|js|ttf|ttc|otf|eot|woff|woff2|jpg|jpeg)$") {
            set resp.http.Access-Control-Allow-Origin = "*";
        }
    }
}

