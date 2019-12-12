sub recv_route_video {
    declare local var.hash STRING;
    declare local var.p INTEGER;
    declare local var.test_name STRING;
    declare local var.should_serve_from_vi BOOL;
    declare local var.start_time_window BOOL;
    declare local var.end_time_window BOOL;


    if (req.http.host ~ "^(www|paidpost)([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
    	// The order of these two checks is important since the second one is a sub path of the first one
        if (req.url ~ "^/video-media") {
            set req.http.x-nyt-route = "video-media";
            set req.http.x-nyt-backend = "vp";
        }
    }

    if ( req.url.path == "/video" || req.url.path ~ "^/video/") {
        set var.start_time_window = time.is_after(now, std.time("Sat, 14 Dec 2019 01:00:00 GMT", now));
        set var.end_time_window = time.is_after(now, std.time("Sun, 15 Dec 2019 10:00:00 GMT", now));
        set var.should_serve_from_vi = (var.start_time_window && !var.end_time_window);

        if (var.should_serve_from_vi || req.url ~ "(?i)force-vi=true") {
            set req.http.x-nyt-route = "vi-video";
            set req.http.x-nyt-backend = "projectvi_fe";
            set req.http.var-nyt-error-retry = "false";
            set req.http.var-nyt-wf-auth = "true";
            unset req.http.Authorization;
        } else {
            set req.http.x-nyt-route = "video-library";
            set req.http.x-nyt-backend = "video_library";
        }

        set req.http.var-nyt-send-gdpr = "true";
        call recv_post_method_restricted;
    }

    if ( req.url.path ~ "^/video/players/offsite/" ) {
        set req.http.x-nyt-route = "video-offsite-player";
        set req.http.x-nyt-backend = "gcs_origin";
        set req.http.var-nyt-send-gdpr = "true";
        set req.url = querystring.remove(req.url);
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
    if (!req.backend.is_shield && req.http.x-nyt-route ~ "^video-") {
        unset bereq.http.cookie;
    }

    if (req.http.x-nyt-route == "vi-video") {
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
