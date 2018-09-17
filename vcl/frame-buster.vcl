sub deliver_frame_buster {

    # some paths are whitelisted for framing on 3rd parties, check those first
    if (   req.url.path !~ "^/svc/oembed/html"
        && req.url.path !~ "\.embedded\.html$"
        && req.url.path !~ "\.app\.html$"
        && req.url.path !~ "\.mobile\.html$"
        && req.url.path !~ "^/ads/"
        && req.url.path !~ "^/newsletters/regilite/"
        && req.url.path !~ "^/newsgraphics/"
        && req.url.path !~ "^/video/players/offsite/"
        && req.url.path !~ "^/times-journeys/(.*)terms(.*)"
        ) {

    	# not in the whitelist, check the Referer
	    if (!req.http.Referer) {
            # mobile apps have "NYTimes" in the User-Agent
            if (req.http.user-agent !~ "NYTimes") {
    	        set resp.http.X-Frame-Options = "DENY";
            }
        # good luck figuring this out
	    } else if (req.http.Referer !~ "^https?://(?:[^?/]+\.)?(?:localhost|(?:nytimes|nytco|nytlabs|stumbleupon|starbucks|insightexpress|optimizely)\.com|(?:(nyt|newsdev)\.net))(?:\:[1-9][0-9]*)?/") {
	        set resp.http.X-Frame-Options = "DENY";
	    }
	} else {
		remove resp.http.X-Frame-Options;
	}
}
