sub vcl_recv {

    if (req.http.host ~ "^(www|paidpost)([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
    	// The order of these two checks is important since the second one is a sub path of the first one
        if (req.url ~ "^/video-media") {
            set req.http.X-PageType = "video-media";

    	    set req.url = regsub(req.url, "^/video-media", "/video");
            set req.http.x-nyt-backend = "vp";
            set req.backend = F_vp;
            set req.http.host = "vp.nyt.com";

	        unset req.http.x-nyt-edition;
	        unset req.http.x-nyt-s;
	        unset req.http.x-nyt-wpab;
	        unset req.http.Cookie;
            unset req.http.X-Cookie;

            return(lookup);
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "video-media") {
        set resp.http.X-API-Version = "VM";
    }
}
