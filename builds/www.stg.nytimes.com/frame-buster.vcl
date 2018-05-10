sub vcl_deliver {

    # some paths are whitelisted for framing on 3rd parties, check those first
    if (	req.url !~ "^/svc/oembed/html"
    	&& 	req.url.path !~ "\.embedded\.html$"
    	&& 	req.url.path !~ "\.app\.html$"
    	&& 	req.url.path !~ "\.mobile\.html$"
    	&& 	req.url !~ "^/ads/"
	&&  	req.url !~ "^/newsletters/regilite/"
	&&	req.url !~ "^/newsgraphics/"
	&&	req.url !~ "^/video/players/offsite/"
    	){

    	# not in the whitelist, check the Referer
	    if (!req.http.Referer) {
            if (req.http.user-agent !~ "NYTimes") {
    	        set resp.http.X-Frame-Options = "DENY";
            }
	    } elseif (req.http.Referer !~ "^https?://(?:[^?/]+\.)?(?:localhost|(?:nytimes|nytco|nytlabs|stumbleupon|starbucks|insightexpress|optimizely)\.com|(?:(nyt|newsdev)\.net))(?:\:[1-9][0-9]*)?/") {
	        set resp.http.X-Frame-Options = "DENY";
	    }
	} else {
		remove resp.http.X-Frame-Options;
	}
}
