# This is the bot detection VCL, with vendor specific subroutines

sub recv_bot_detection {
    if (!req.http.x-nyt-shield-auth &&
        table.lookup(bot_detection, "enabled") == "true" &&
        (req.http.var-nyt-env != "prd" ||
         (randombool(25,100) && req.restarts == 0) ||
         req.http.X-DataDome-params)) {
        call datadome_vcl_recv;
    }
}

# Call this AFTER the fastly recv macro to reset the shield.
# If JFK is no longer the shield, update the below to match the compiled macro
sub recv_bot_detection_reset_shield {
    if (!req.http.x-nyt-shield-auth &&
        table.lookup(bot_detection, "enabled") == "true" &&
        req.http.var-datadome-response) {

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
    if (req.backend == F_datadome) {
        # Retrieve Datadome key from dictionary HERE
        set bereq.http.X-DataDome-params:Key =
            table.lookup(bot_detection, "datadome_api_key");
        set bereq.http.X-DataDome-params:RequestModuleName = "Fastly";
        set bereq.http.X-DataDome-params:ModuleVersion = "2.1";
        set bereq.http.X-DataDome-params:TimeRequest = time.start.usec;
        set bereq.http.X-DataDome-params:ServerName = server.identity;
        set bereq.http.X-DataDome-params:ServerRegion = server.region;
        set bereq.http.X-DataDome-params:IP = req.http.fastly-client-ip;
        set bereq.http.X-DataDome-params:AuthorizationLen = std.strlen(req.http.authorization);
        unset bereq.http.authorization;
        set bereq.http.X-DataDome-params:ClientID = urlencode(req.http.cookie:datadome);
        set bereq.http.X-DataDome-params:CookiesLen = std.strlen(req.http.cookie);
        unset bereq.http.cookie;
    } else {
        # prevent leak of the key
        unset bereq.http.X-DataDome-params;

        # remove NYT debugging vars, will cause problems when going to a shield
        unset bereq.http.x-nyt-restart-reason;
        unset bereq.http.x-datadome-timer;
        unset bereq.http.var-datadome-response;
        unset bereq.http.var-datadome-behealth;
    }
}

sub datadome_vcl_recv {
  # Configure the regular expression below to match URLs that
  # should be checked by DataDome
  # Make sure enough req.headers are available for the dd headers + restart.
  # 69 appears to be the max before the mysterious restart loop occurs.
  # Rounding down to 65 for added buffer.
  if (!req.http.fastly-ff && req.restarts == 0 && std.count(req.headers) < 65 && req.url.ext !~ "^(js|css|jpg|jpeg|png|ico|gif|tiff|svg|woff|woff2|ttf|eot|mp4|otf)$") {
    if (!req.http.x-datadome-timer) {
        set req.http.x-datadome-timer = "S" time.start.sec "." time.start.usec_frac;
    }
    set req.http.x-datadome-timer = req.http.x-datadome-timer ",VS0";

    set req.backend = F_datadome;
    set req.http.var-datadome-behealth = req.backend.healthy;
    set req.http.X-DataDome-params:Method = urlencode(req.method);
    set req.http.X-DataDome-params:PostParamLen = urlencode(req.http.content-length);
    set req.method = "GET";
    return (pass);
  } else {
    if (req.http.X-DataDome-params:Method) {
      set req.method = urldecode(req.http.X-DataDome-params:Method);
      # After a restart, clustering is disabled. This re-enables it.
      set req.http.fastly-force-shield = "1";
    }
    unset req.http.X-DataDome-params;
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
    set req.http.var-datadome-response = beresp.status;

    # check that it is real ApiServer response
    if (var.status != beresp.http.x-datadomeresponse) {
      set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " DD_resp_error", "DD_resp_error");
      restart;
    }
    unset beresp.http.x-datadomeresponse;

    # copy datadome headers
    set req.http.x-datadome-headers-pairs:x-datadome-headers = urlencode(beresp.http.x-datadome-headers);

    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+x-datadome-server( |$)+") {
      set req.http.x-datadome-headers-pairs:x-datadome-server = urlencode(beresp.http.x-datadome-server);
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+x-datadome( |$)+") {
      set req.http.x-datadome-headers-pairs:x-datadome = urlencode(beresp.http.x-datadome);
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+content-type( |$)+") {
      set req.http.x-datadome-headers-pairs:content-type = urlencode(beresp.http.content-type);
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+charset( |$)+") {
      set req.http.x-datadome-headers-pairs:charset = urlencode(beresp.http.charset);
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+cache-control( |$)+") {
      set req.http.x-datadome-headers-pairs:cache-control = urlencode(beresp.http.cache-control);
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+pragma( |$)+") {
      set req.http.x-datadome-headers-pairs:pragma = urlencode(beresp.http.pragma);
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+access-control-allow-credentials( |$)+") {
      set req.http.x-datadome-headers-pairs:access-control-allow-credentials = urlencode(beresp.http.access-control-allow-credentials);
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+access-control-expose-headers( |$)+") {
      set req.http.x-datadome-headers-pairs:access-control-expose-headers = urlencode(beresp.http.access-control-expose-headers);
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+access-control-allow-origin( |$)+") {
      set req.http.x-datadome-headers-pairs:access-control-allow-origin = urlencode(beresp.http.access-control-allow-origin);
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+x-datadome-cid( |$)+") {
      set req.http.x-datadome-headers-pairs:x-datadome-cid = urlencode(beresp.http.x-datadome-cid);
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+x-dd-b( |$)+") {
      set req.http.x-datadome-headers-pairs:x-dd-b = urlencode(beresp.http.x-dd-b);
    }
    if (beresp.http.x-datadome-headers ~ "(?i)(^| )+x-dd-type( |$)+") {
      set req.http.x-datadome-headers-pairs:x-dd-type = urlencode(beresp.http.x-dd-type);
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
      set req.http.x-datadome-headers-pairs:set-cookie = urlencode(beresp.http.set-cookie);
    }

    # Continue only if ApiServer returns expected blocked status
    if (beresp.status != 403 &&
        beresp.status != 401 &&
        beresp.status != 301 &&
        beresp.status != 302) {
      set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " DD_check_passed", "DD_check_passed");
      unset beresp.http.x-datadome-headers;
      unset beresp.http.x-datadome-request-headers;
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
        resp.status != 403 &&
        resp.status != 401 &&
        resp.status != 301 &&
        resp.status != 302) {
      set req.http.var-datadome-response = resp.status;
      set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " DD_error_failopen", "DD_error_failopen");
      restart;
    }
  } else if (req.http.x-datadome-headers-pairs) {
    # copy datadome headers if it isn't datadome request
    declare local var.x-datadome-headers STRING;
    set var.x-datadome-headers = urldecode(req.http.x-datadome-headers-pairs:x-datadome-headers);
    if (var.x-datadome-headers ~ "(?i)(^| )+x-datadome-server( |$)+") {
      set resp.http.x-datadome-server = urldecode(req.http.x-datadome-headers-pairs:x-datadome-server);
    }
    if (var.x-datadome-headers ~ "(?i)(^| )+x-datadome( |$)+") {
      set resp.http.x-datadome = urldecode(req.http.x-datadome-headers-pairs:x-datadome);
    }
    if (var.x-datadome-headers ~ "(?i)(^| )+content-type( |$)+") {
      set resp.http.content-type = urldecode(req.http.x-datadome-headers-pairs:content-type);
    }
    if (var.x-datadome-headers ~ "(?i)(^| )+charset( |$)+") {
      set resp.http.charset = urldecode(req.http.x-datadome-headers-pairs:charset);
    }
    if (var.x-datadome-headers ~ "(?i)(^| )+cache-control( |$)+") {
      set resp.http.cache-control = urldecode(req.http.x-datadome-headers-pairs:cache-control);
    }
    if (var.x-datadome-headers ~ "(?i)(^| )+pragma( |$)+") {
      set resp.http.pragma = urldecode(req.http.x-datadome-headers-pairs:pragma);
    }
    if (var.x-datadome-headers ~ "(?i)(^| )+access-control-allow-credentials( |$)+") {
      set resp.http.access-control-allow-credentials = urldecode(req.http.x-datadome-headers-pairs:access-control-allow-credentials);
    }
    if (var.x-datadome-headers ~ "(?i)(^| )+access-control-expose-headers( |$)+") {
      set resp.http.access-control-expose-headers = urldecode(req.http.x-datadome-headers-pairs:access-control-expose-headers);
    }
    if (var.x-datadome-headers ~ "(?i)(^| )+access-control-allow-origin( |$)+") {
      set resp.http.access-control-allow-origin = urldecode(req.http.x-datadome-headers-pairs:access-control-allow-origin);
    }
    if (var.x-datadome-headers ~ "(?i)(^| )+x-datadome-cid( |$)+") {
      set resp.http.x-datadome-cid = urldecode(req.http.x-datadome-headers-pairs:x-datadome-cid);
    }
    if (var.x-datadome-headers ~ "(?i)(^| )+x-dd-b( |$)+") {
      set resp.http.x-dd-b = urldecode(req.http.x-datadome-headers-pairs:x-dd-b);
    }
    if (var.x-datadome-headers ~ "(?i)(^| )+x-dd-type( |$)+") {
      set resp.http.x-dd-type = urldecode(req.http.x-datadome-headers-pairs:x-dd-type);
    }
    # don't forget about ApiServer's cookies
    if (var.x-datadome-headers ~ "(?i)(^| )+set-cookie( |$)+") {
      add resp.http.set-cookie = urldecode(req.http.x-datadome-headers-pairs:set-cookie);
    }

    # gk - debug
    if (req.http.x-nyt-nyhq-access == "1") {
      set resp.http.x-datadome-response = req.http.var-datadome-response;
    }
  }
}
