sub vcl_recv {

    if (req.http.host ~ "^(www|paidpost)([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
    	// The order of these two checks is important since the second one is a sub path of the first one
        if (req.url ~ "^/video-media") {
            set req.http.x-pagetype = "video-media";
            set req.http.x-nyt-backend = "vp";

	        unset req.http.x-nyt-edition;
	        unset req.http.x-nyt-s;
	        unset req.http.x-nyt-wpab;
	        unset req.http.Cookie;
            unset req.http.X-Cookie;

            #return(lookup);
        }
    }
}

sub vcl_pass {
    if(req.http.x-pagetype == "video-media") {
        call miss_pass_set_video_media_request;
    }
}

sub vcl_miss {
    if(req.http.x-pagetype == "video-media") {
        call miss_pass_set_video_media_request;
    }
}

sub miss_pass_set_video_media_request {
    set bereq.http.host = "vp.nyt.com";
    set bereq.url = regsub(bereq.url, "^/video-media", "/video");
}

sub vcl_deliver {
    if (req.http.X-PageType == "video-media") {
        set resp.http.X-API-Version = "VM";
    }
}
