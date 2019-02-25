sub recv_enable_privacy {
    ## when called it sets var-nyt-no-referrer and masquerade client ip
    set req.http.var-nyt-no-referrer = "true";
    set req.http.Fastly-Client-IP = "0.0.0.0";
}

sub deliver_enable_privacy {
    if (req.http.var-nyt-no-referrer == "true"){
        set resp.http.Referrer-Policy = "no-referrer";
    }
}
