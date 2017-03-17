sub vcl_recv {

    # capture the query string into a var before it might be modified
    # we will use this in other initialization functionality in this sub
    declare local var.original-query-string STRING;

    if (req.url ~ "\?") {
        set var.original-query-string = regsub(req.url, ".*(\?.*)", "\1");
    }

    # capture geoip override qparam if it exists, we will use it later
    if (var.original-query-string) {
    	set req.http.x-nyt-geoip-override = regsub(var.original-query-string, ".*?.*ip-override=(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*", "\1");

	    if(req.http.x-nyt-geoip-override == var.original-query-string){
	    	unset req.http.x-nyt-geoip-override;
	    }
	}

}
