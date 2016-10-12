sub vcl_recv {
    // collapse \r\n
    set req.url = regsuball(req.url, "\x250[dDaA]", "");
}
