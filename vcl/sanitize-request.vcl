sub recv_sanitize_request {
    # collapse \r\n
    set req.url = regsuball(req.url, "\x250[dDaA]", "");
    # collapse \00
    set req.url = regsuball(req.url, "\x2500", "");

    # collapse repeated slashes in URL
    # this was breaking query params with schemes in them, don't normalize those
    if (req.url !~ "https?.{1,3}\/\/"){
    	set req.url = regsuball(req.url, "[\/]+", "\/");
    }

    # remove query strings like login-email, login-password etc.
    if (req.url ~ "[?&]login-[^=&]+") {
    	declare local var.target_url STRING;
        set req.url = querystring.regfilter(req.url, "^login-*");
        set var.target_url =  "https://" + req.http.host + req.url;
        error 770 var.target_url;
    }

}

sub recv_post_method_restricted {
    if (req.request == "POST") {
        error 405 "Method Not Allowed";
    }
}
