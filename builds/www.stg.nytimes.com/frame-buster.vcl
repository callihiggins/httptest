sub vcl_deliver {

    # some paths are whitelisted for framing on 3rd parties, check those first
    if(		req.url !~ "^/svc/oembed/html"
    	&& 	req.url !~ "\.embedded\.html$"
    	&& 	req.url !~ "\.app\.html$"
    	&& 	req.url !~ "\.mobile\.html$"
    	&& 	req.url !~ "^/ads/"
    	){
    	
    	# not in the whitelist, check the Referer
	    if (!req.http.Referer) {
	        set resp.http.X-Frame-Options = "DENY";
	    } elseif (req.http.Referer !~ "^https?://(?:[^?/]+\.)?(?:localhost|(?:nytimes|nytco|nytlabs|stumbleupon|starbucks|insightexpress|optimizely)\.com|(?:newsdev\.net))(?:\:[1-9][0-9]*)?/") {
	        set resp.http.X-Frame-Options = "DENY";
	    }
	} else {
		remove resp.http.X-Frame-Options;
	}
}
