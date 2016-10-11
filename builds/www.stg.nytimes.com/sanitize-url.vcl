sub vcl_recv {
    // collapse \r\n
    set req.url = regsuball(req.url, "\x250[dDaA]", "");
    
    // we had to urldecode everything to match encoding without Fastly
    // for some reason /svc/community is an edge case
    // is the netscaler doing some crazy encoding normalization??
    if (req.url !~ "^/svc/community") {
    	// urldecode is breaking + chars for watching
	    set req.url = regsuball(req.url, "(\%2B|\%2b)", "%252B");
	    set req.url = urldecode(req.url);
	}
}
