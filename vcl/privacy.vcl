sub recv_enable_privacy {
    ## masquerade client ip
    set req.http.Fastly-Client-IP = "0.0.0.0";
}

sub deliver_enable_privacy {
    # set no-referrer when client ip is masked
    if (req.http.Fastly-Client-IP == "0.0.0.0"){
        set resp.http.Referrer-Policy = "no-referrer";
    }
}
