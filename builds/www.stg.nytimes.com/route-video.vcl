sub recv_route_video {

    if (req.http.host ~ "^(www|paidpost)([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
    	// The order of these two checks is important since the second one is a sub path of the first one
        if (req.url ~ "^/video-media") {
            set req.http.x-nyt-route = "video-media";
            set req.http.x-nyt-backend = "vp";
        }
    }

    if ( req.url.path == "/video" || req.url.path ~ "^/video/") {
        set req.http.x-nyt-route = "video-library";
        set req.http.x-nyt-backend = "video_library";
        set req.http.var-nyt-send-gdpr = "true";
    }

    if ( req.url.path ~ "^/video/players/offsite/" ) {
        set req.http.x-nyt-route = "video-offsite-player";
        set req.http.x-nyt-backend = "gcs_origin";
        set req.http.X-SendGDPR = "true";
    }

    if ( req.url ~ "^/svc/video" ) {
        set req.http.x-nyt-route = "video-api";
        set req.http.x-nyt-ttl-override = "30";
        set req.http.x-nyt-backend = "video_api";
    }
}

sub hash_route_video {
  // video library needs to pivot on device type and gdpr status
  if(req.http.x-nyt-route == "video-library") {
    set req.hash += req.http.device_type;
    set req.hash += req.http.var-cookie-nyt-gdpr;
  }
}

sub miss_pass_route_video {

    # video routes do not need cookies
    if (req.http.x-nyt-route ~ "^video-") {
        unset bereq.http.cookie;
    }

    if(!req.backend.is_shield && req.http.x-nyt-route == "video-media") {
      set bereq.http.host = "vp.nyt.com";
    }

    if (!req.backend.is_shield && req.http.x-nyt-route == "video-offsite-player") {
        call miss_pass_set_bucket_auth_headers;
    }

    if (!req.backend.is_shield && req.http.x-nyt-route == "video-library") {
        set bereq.http.x-nyt-gdpr = req.http.var-cookie-nyt-gdpr;
    }
}

sub deliver_video_api_version {
    if (req.http.x-nyt-route == "video-media") {
        set resp.http.X-API-Version = "VM";
    }
}
