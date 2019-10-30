sub recv_route_video {
    declare local var.hash STRING;
    declare local var.p INTEGER;
    declare local var.test_name STRING;

    if (req.http.host ~ "^(www|paidpost)([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
    	// The order of these two checks is important since the second one is a sub path of the first one
        if (req.url ~ "^/video-media") {
            set req.http.x-nyt-route = "video-media";
            set req.http.x-nyt-backend = "vp";
        }
    }

    if ( req.url.path == "/video" || req.url.path ~ "^/video/") {
        #######################################
        #
        # Abra style traffic allocation
        #
        # Variants:
        #   - Legacy Video        75%
        #   - Project VI Video    25%
        #
        set var.test_name = "VIDEO_allocation";
        set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
        set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
        set var.p = std.strtol(var.hash, 16);

        # 2^32 = 4294967296
        # 75% = 3221225472
        if (var.p < 3221225472) {
          set req.http.x-nyt-route = "video-library";
          set req.http.x-nyt-backend = "video_library";
          set req.url = querystring.filter_except(req.url, "playlistId");
        } else {
          # 25% = 1073741824
          set req.http.x-nyt-route = "vi-video";
          set req.http.x-nyt-backend = "projectvi_fe";
          set req.http.var-nyt-error-retry = "false";
          set req.http.var-nyt-wf-auth = "true";
          set req.url = querystring.filter_except(req.url, "playlistId");
          unset req.http.Authorization;
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
