sub vcl_recv {
    // collapse \r\n
    set req.url = regsuball(req.url, "\x250[dDaA]", "");

    // deal with encoding for times widgets
    if (req.url ~ "^/svc/widgets"){
    	set req.url = urldecode(req.url);
    }
}