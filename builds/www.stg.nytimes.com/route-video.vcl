sub recv_route_video {

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
        }
    }

    if ( req.url.path == "/video" || req.url.path ~ "^/video/") {
        set req.http.X-PageType = "video-library";
        set req.http.x-nyt-backend = "video_library";
        set req.http.X-SendGDPR = "true";
    }

    if ( req.url.path ~ "^/video/players/offsite/" ) {
        set req.http.X-PageType = "video-offsite-player";
        set req.http.x-nyt-backend = "gcs_origin";
        set req.http.X-SendGDPR = "true";
    }

    if ( req.url ~ "^/svc/video" ) {
        set req.http.X-PageType = "video-api";
        set req.http.x-nyt-ttl-override = "30";
        set req.http.x-nyt-backend = "video_api";
    }
}

sub hash_route_video {
  // video library needs to pivot on device type
  if(req.http.X-PageType == "video-library") {
      set req.hash += req.http.device_type;
  }
}

sub miss_pass_route_video {
    if(!req.backend.is_shield && req.http.x-pagetype == "video-media") {
        set bereq.http.host = "vp.nyt.com";
    }
    call miss_pass_set_bucket_auth_headers;
}

sub deliver_video_api_version {
    if (req.http.X-PageType == "video-media") {
        set resp.http.X-API-Version = "VM";
    }
}
