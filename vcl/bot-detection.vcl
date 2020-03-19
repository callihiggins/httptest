# This is the bot detection VCL, with vendor specific subroutines

sub recv_bot_detection {
    if (!req.http.x-nyt-shield-auth &&
        table.lookup(bot_detection, "enabled") == "true" &&
        (req.http.var-nyt-env != "prd" || (randombool(5,100) && req.restarts == 0) || req.http.destination == "datadome")) {
        call datadome_vcl_recv;
    }
}

# Call this AFTER the fastly recv macro to reset the shield.
# If JFK is no longer the shield, update the below to match the compiled macro
sub recv_bot_detection_reset_shield {
    if (!req.http.x-nyt-shield-auth &&
        table.lookup(bot_detection, "enabled") == "true" &&
        req.http.datadome-response) {

        # Update this to match your shielding code as the default shielding
        # code does not support preflighting
        # Note: req.restarts <= 1 instead of == 0
        if (req.backend == F_projectvi_fe && req.restarts <= 1) {
            if (server.identity !~ "-LGA$" && req.http.Fastly-FF !~ "-LGA") {
                set req.backend = ssl_shield_lga_ny_us;
            }
            if (!req.backend.healthy) {
                # the shield datacenter is broken so dont go to it
                set req.backend = F_projectvi_fe;
            }
        }
    }
}

sub deliver_bot_detection {
    if (!req.http.x-nyt-shield-auth &&
        table.lookup(bot_detection, "enabled") == "true") {
        call datadome_vcl_deliver;
    }
}

sub miss_pass_bot_detection {
    if (!req.http.x-nyt-shield-auth &&
        table.lookup(bot_detection, "enabled") == "true") {
        call datadome_set_origin_header;
    }
}

sub fetch_bot_detection {
    if (!req.http.x-nyt-shield-auth &&
        table.lookup(bot_detection, "enabled") == "true") {
        call datadome_vcl_fetch;
    }
}

# Private functions, DO NOT CALL THESE DIRECTLY.  Use the shared functions above
# /* ------- DATADOME ------ */
sub datadome_set_origin_header {
    unset bereq.http.destination;
    if (req.backend == F_datadome) {
        # Retrieve Datadome key from dictionary HERE
        set bereq.http.x-datadome-apikey =
            table.lookup(bot_detection, "datadome_api_key");
        set bereq.http.x-datadome-modulename = "Fastly";
        set bereq.http.x-datadome-moduleversion = "1.9";
        set bereq.http.x-datadome-timestamp = time.start.usec;
        set bereq.http.x-datadome-serverhostname = server.identity;
        set bereq.http.x-datadome-server-region = server.region;
        set bereq.http.x-real-ip = req.http.fastly-client-ip;
        set bereq.http.x-authorizationlen = std.strlen(req.http.authorization);
        unset bereq.http.authorization;
        set bereq.http.x-datadome-clientid = req.http.cookie:datadome;
        set bereq.http.x-cookieslen = std.strlen(req.http.cookie);
        unset bereq.http.cookie;
    } else {
        # prevent leak of the key
        unset bereq.http.x-datadome-apikey;
        unset bereq.http.x-datadome-modulename;
        unset bereq.http.x-datadome-moduleversion;
        unset bereq.http.x-datadome-timestamp;
        unset bereq.http.x-datadome-serverhostname;
        unset bereq.http.x-datadome-server-region;
        unset bereq.http.x-real-ip;
        unset bereq.http.x-authorizationlen;
        unset bereq.http.x-original-method;
        unset bereq.http.x-content-length;
        unset bereq.http.x-authorizationlen;
        unset bereq.http.x-cookieslen;
        unset bereq.http.x-datadome-clientid;

        # remove NYT debugging vars, will cause problems when going to a shield
        unset bereq.http.x-datadome-restart-reason;
        unset bereq.http.x-datadome-timer;
        unset bereq.http.datadome-response;
    }
}

sub datadome_vcl_recv {
  # Configure the regular expression below to match URLs that
  # should be checked by DataDome
  if (req.restarts == 0) {
    set req.http.x-datadome-restart-reason = "DD";
  }

  if (!req.http.fastly-ff && req.restarts == 0 && req.url.ext !~ "^(js|css|jpg|jpeg|png|ico|gif|tiff|svg|woff|woff2|ttf|eot|mp4|otf)$") {
    set req.http.destination = "datadome";
    if (!req.http.x-datadome-timer) {
          set req.http.x-datadome-timer = "S" time.start.sec "." time.start.usec_frac;
    }
    set req.http.x-datadome-timer = req.http.x-datadome-timer ",VS0";
  } else {
    set req.http.destination = "origin";
  }

  if (req.http.destination == "datadome") {
    set req.backend = F_datadome;
    set req.http.x-datadome-behealth = req.backend.healthy;
    set req.http.x-original-method = req.method;
    set req.http.x-content-length = req.http.content-length;
    set req.method = "GET";
    return (pass);
  } else {
    if (req.http.x-original-method) {
      set req.method = req.http.x-original-method;
      # After a restart, clustering is disabled. This re-enables it.
      set req.http.fastly-force-shield = "1";
    }
  }

  # we're using the first restart for datadome, update a part of fastly code
  # we can't replace whole macros because we haven't got any idea about backends
  if (req.restarts == 1) {
    if (!req.http.x-timer) {
      set req.http.x-timer = "S" time.start.sec "." time.start.usec_frac;
    }
    set req.http.x-timer = req.http.x-timer ",VS0";
  }
}

sub datadome_vcl_fetch {
  if (req.restarts == 0) {
      set req.http.x-datadome-timer = req.http.x-datadome-timer ",VE" time.elapsed.msec;
  }
  set beresp.http.x-datadome-timer = req.http.x-datadome-timer;

  if (req.backend == F_datadome && req.restarts == 0) {
    declare local var.status STRING;
    set var.status = beresp.status;
    set req.http.datadome-response = beresp.status;

    # check that it is real ApiServer response
    if (var.status != beresp.http.x-datadomeresponse) {
      set req.http.x-datadome-restart-reason = if(req.http.x-datadome-restart-reason, req.http.x-datadome-restart-reason + "_resp_error ", "DD_resp_error ");
      restart;
    }
    unset beresp.http.x-datadomeresponse;
    # copy datadome headers
    set req.http.x-datadome-headers = beresp.http.x-datadome-headers;
    set req.http.x-datadome-request-headers = beresp.http.x-datadome-request-headers;

    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+x-datadome-server( |$)+") {
      set req.http.x-datadome-server = beresp.http.x-datadome-server;
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+x-datadome( |$)+") {
      set req.http.x-datadome = beresp.http.x-datadome;
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+content-type( |$)+") {
      set req.http.content-type = beresp.http.content-type;
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+charset( |$)+") {
      set req.http.charset = beresp.http.charset;
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+cache-control( |$)+") {
      set req.http.cache-control = beresp.http.cache-control;
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+pragma( |$)+") {
      set req.http.pragma = beresp.http.pragma;
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+access-control-allow-credentials( |$)+") {
      set req.http.access-control-allow-credentials = beresp.http.access-control-allow-credentials;
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+access-control-expose-headers( |$)+") {
      set req.http.access-control-expose-headers = beresp.http.access-control-expose-headers;
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+access-control-allow-origin( |$)+") {
      set req.http.access-control-allow-origin = beresp.http.access-control-allow-origin;
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+x-datadome-cid( |$)+") {
      set req.http.x-datadome-cid = beresp.http.x-datadome-cid;
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+x-dd-b( |$)+") {
      set req.http.x-dd-b = beresp.http.x-dd-b;
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+x-dd-type( |$)+") {
      set req.http.x-dd-type = beresp.http.x-dd-type;
    }
    if (beresp.http.x-datadome-request-headers ~ "(?i)(^| )+x-dd-type( |$)+") {
      set req.http.x-dd-type = beresp.http.x-dd-type;
    }
    if (beresp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-botname( |$)+") {
      set req.http.x-datadome-botname = beresp.http.x-datadome-botname;
    }
    if (beresp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-botfamily( |$)+") {
      set req.http.x-datadome-botfamily = beresp.http.x-datadome-botfamily;
    }
    if (beresp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-isbot( |$)+") {
      set req.http.x-datadome-isbot = beresp.http.x-datadome-isbot;
    }
    if (beresp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-captchapassed( |$)+") {
      set req.http.x-datadome-captchapassed = beresp.http.x-datadome-captchapassed;
    }
    # don't forget about ApiServer's cookies
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+set-cookie( |$)+") {
      set req.http.set-cookie = beresp.http.set-cookie;
    }

    # is it passed? If so just restart it!
    if (beresp.status == 200) {
      set req.http.x-datadome-restart-reason = if(req.http.x-datadome-restart-reason, req.http.x-datadome-restart-reason + "_check_passed ", "DD_check_passed ");
      restart;
    }

    # ok, it is banned request, cleanup it a bit
    if (beresp.http.x-datadome-request-headers ~ "(?i)(^| )+x-dd-type( |$)+") {
      if (beresp.http.x-datadome-headers !~ "(?i)(^| )+x-dd-type( |$)+") {
        unset beresp.http.x-dd-type;
      }
    }
    if (beresp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-botname( |$)+") {
      if (beresp.http.x-datadome-headers !~ "(?i)(^| )+x-datadome-botname( |$)+") {
        unset beresp.http.x-datadome-botname;
      }
    }
    if (beresp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-botfamily( |$)+") {
      if (beresp.http.x-datadome-headers !~ "(?i)(^| )+x-datadome-botfamily( |$)+") {
        unset beresp.http.x-datadome-botfamily;
      }
    }
    if (beresp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-isbot( |$)+") {
      if (beresp.http.x-datadome-headers !~ "(?i)(^| )+x-datadome-isbot( |$)+") {
        unset beresp.http.x-datadome-isbot;
      }
    }
    if (beresp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-captchapassed( |$)+") {
      if (beresp.http.x-datadome-headers !~ "(?i)(^| )+x-datadome-captchapassed( |$)+") {
        unset beresp.http.x-datadome-captchapassed;
      }
    }
    unset beresp.http.x-datadome-headers;
    unset beresp.http.x-datadome-request-headers;
  }
}

sub datadome_vcl_deliver {

  if (req.backend == F_datadome) {
    # check for unexpected server errors and if so force restart
    if (req.restarts == 0 &&
        resp.status != 200 &&
        resp.status != 403) {
      set req.http.datadome-response = resp.status;
      set req.http.x-datadome-restart-reason = if(req.http.x-datadome-restart-reason, req.http.x-datadome-restart-reason + "_error_force_failopen ", "DD_error_force_failopen ");
      restart;
    }
  } else {
    # copy datadome headers if it isn't datadome request
    if (req.http.x-datadome-headers ~ "(?i)(^| )+x-datadome-server( |$)+") {
      set resp.http.x-datadome-server = req.http.x-datadome-server;
    }
    if (req.http.x-datadome-headers ~ "(?i)(^| )+x-datadome( |$)+") {
      set resp.http.x-datadome = req.http.x-datadome;
    }
    if (req.http.x-datadome-headers ~ "(?i)(^| )+content-type( |$)+") {
      set resp.http.content-type = req.http.content-type;
    }
    if (req.http.x-datadome-headers ~ "(?i)(^| )+charset( |$)+") {
      set resp.http.charset = req.http.charset;
    }
    if (req.http.x-datadome-headers ~ "(?i)(^| )+cache-control( |$)+") {
      set resp.http.cache-control = req.http.cache-control;
    }
    if (req.http.x-datadome-headers ~ "(?i)(^| )+pragma( |$)+") {
      set resp.http.pragma = req.http.pragma;
    }
    if (req.http.x-datadome-headers ~ "(?i)(^| )+access-control-allow-credentials( |$)+") {
      set resp.http.access-control-allow-credentials = req.http.access-control-allow-credentials;
    }
    if (req.http.x-datadome-headers ~ "(?i)(^| )+access-control-expose-headers( |$)+") {
      set resp.http.access-control-expose-headers = req.http.access-control-expose-headers;
    }
    if (req.http.x-datadome-headers ~ "(?i)(^| )+access-control-allow-origin( |$)+") {
      set resp.http.access-control-allow-origin = req.http.access-control-allow-origin;
    }
    if (req.http.x-datadome-headers ~ "(?i)(^| )+x-datadome-cid( |$)+") {
      set resp.http.x-datadome-cid = req.http.x-datadome-cid;
    }
    if (req.http.x-datadome-headers ~ "(?i)(^| )+x-dd-b( |$)+") {
      set resp.http.x-dd-b = req.http.x-dd-b;
    }
    if (req.http.x-datadome-headers ~ "(?i)(^| )+x-dd-type( |$)+") {
      set resp.http.x-dd-type = req.http.x-dd-type;
    }
    # don't forget about ApiServer's cookies
    if (req.http.x-datadome-headers ~ "(?i)(^| )+set-cookie( |$)+") {
      add resp.http.set-cookie = req.http.set-cookie;
    }

    # gk - debug
    if (req.http.x-nyt-nyhq-access == "1") {
      set resp.http.datadome-response = req.http.datadome-response;
    }
  }
}
