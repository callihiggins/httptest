sub vcl_recv {
    // collapse \r\n
    set req.url = regsuball(req.url, "\x250[dDaA]", "");
    // collapse \00
    set req.url = regsuball(req.url, "\x2500", "");
}
