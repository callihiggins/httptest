# This is the bot detection VCL, with vendor specific subroutines

sub recv_bot_detection {
    if (!req.http.x-nyt-shield-auth &&
        table.lookup(bot_detection, "enabled") == "true" &&
        (req.http.var-nyt-env != "prd" || randombool(5,100))) {
        call datadome_vcl_recv;
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

# Private functions, DO NOT CALL THESE DIRECTLY.  Use the shared functions above
# /* ------- DATADOME ------ */
sub datadome_vcl_recv {
  # Configure the regular expression below to match URLs that
  # should be checked by DataDome
  if (!req.http.fastly-ff && req.restarts == 0 && req.url !~ "\.(js|css|jpg|jpeg|png|ico|gif|tiff|svg|woff|woff2|ttf|eot|mp4|otf)$") {
    set req.http.destination = "datadome";
  } else {
    set req.http.destination = "origin";
  }

  if (req.http.destination == "datadome") {
    if (server.region == "APAC") {
      set req.backend = F_datadome_apac;
    } else if (server.region == "Asia") {
      set req.backend = F_datadome_asia;
    } else if (server.region == "Asia-South") {
      set req.backend = F_datadome_asia_south;
    } else if (server.region == "EU-Central") {
      set req.backend = F_datadome_eu_central;
    } else if (server.region == "EU-East") {
      set req.backend = F_datadome_eu_east;
    } else if (server.region == "EU-West") {
      set req.backend = F_datadome_eu_west;
    } else if (server.region == "North-America") {
      set req.backend = F_datadome_north_america;
    } else if (server.region == "SA-East") {
      set req.backend = F_datadome_sa_east;
    } else if (server.region == "SA-North") {
      set req.backend = F_datadome_sa_north;
    } else if (server.region == "SA-South") {
      set req.backend = F_datadome_sa_south;
    } else if (server.region == "South-Africa") {
      set req.backend = F_datadome_south_africa;
    } else if (server.region == "US-Central") {
      set req.backend = F_datadome_us_central;
    } else if (server.region == "US-East") {
      set req.backend = F_datadome_us_east;
    } else if (server.region == "US-West") {
      set req.backend = F_datadome_us_west;
    } else {
      set req.backend = F_datadome;
    }

    # Configure the string below to include your DataDome API key
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

sub datadome_vcl_deliver {
  if (req.backend == F_datadome
   || req.backend == F_datadome_apac
   || req.backend == F_datadome_asia
   || req.backend == F_datadome_asia_south
   || req.backend == F_datadome_eu_central
   || req.backend == F_datadome_eu_east
   || req.backend == F_datadome_eu_west
   || req.backend == F_datadome_north_america
   || req.backend == F_datadome_sa_east
   || req.backend == F_datadome_sa_north
   || req.backend == F_datadome_sa_south
   || req.backend == F_datadome_south_africa
   || req.backend == F_datadome_us_central
   || req.backend == F_datadome_us_east
   || req.backend == F_datadome_us_west
   ) {
    declare local var.status STRING;
    set var.status = resp.status;
    set req.http.debug-datadome-response = resp.status;

    # check that it is real ApiServer response
    if (var.status != resp.http.x-datadomeresponse) {
      restart;
    }
    unset resp.http.x-datadomeresponse;

    # copy datadome headers
    set req.http.x-datadome-headers = resp.http.x-datadome-headers;
    set req.http.x-datadome-request-headers = resp.http.x-datadome-request-headers;

    if (resp.http.x-datadome-headers ~ "(?i)(^| )+x-datadome-server( |$)+") {
      set req.http.x-datadome-server = resp.http.x-datadome-server;
    }
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+x-datadome( |$)+") {
      set req.http.x-datadome = resp.http.x-datadome;
    }
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+content-type( |$)+") {
      set req.http.content-type = resp.http.content-type;
    }
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+charset( |$)+") {
      set req.http.charset = resp.http.charset;
    }
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+cache-control( |$)+") {
      set req.http.cache-control = resp.http.cache-control;
    }
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+pragma( |$)+") {
      set req.http.pragma = resp.http.pragma;
    }
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+access-control-allow-credentials( |$)+") {
      set req.http.access-control-allow-credentials = resp.http.access-control-allow-credentials;
    }
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+access-control-expose-headers( |$)+") {
      set req.http.access-control-expose-headers = resp.http.access-control-expose-headers;
    }
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+access-control-allow-origin( |$)+") {
      set req.http.access-control-allow-origin = resp.http.access-control-allow-origin;
    }
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+x-datadome-cid( |$)+") {
      set req.http.x-datadome-cid = resp.http.x-datadome-cid;
    }
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+x-dd-b( |$)+") {
      set req.http.x-dd-b = resp.http.x-dd-b;
    }
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+x-dd-type( |$)+") {
      set req.http.x-dd-type = resp.http.x-dd-type;
    }
    if (resp.http.x-datadome-request-headers ~ "(?i)(^| )+x-dd-type( |$)+") {
      set req.http.x-dd-type = resp.http.x-dd-type;
    }
    if (resp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-botname( |$)+") {
      set req.http.x-datadome-botname = resp.http.x-datadome-botname;
    }
    if (resp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-botfamily( |$)+") {
      set req.http.x-datadome-botfamily = resp.http.x-datadome-botfamily;
    }
    if (resp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-isbot( |$)+") {
      set req.http.x-datadome-isbot = resp.http.x-datadome-isbot;
    }
    if (resp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-captchapassed( |$)+") {
      set req.http.x-datadome-captchapassed = resp.http.x-datadome-captchapassed;
    }
    # don't forget about ApiServer's cookies
    if (resp.http.x-datadome-headers ~ "(?i)(^| )+set-cookie( |$)+") {
      set req.http.set-cookie = resp.http.set-cookie;
    }

    # is it passed? If so just restart it!
    if (resp.status == 200) {
      restart;
    }

    # ok, it is banned request, cleanup it a bit
    if (resp.http.x-datadome-request-headers ~ "(?i)(^| )+x-dd-type( |$)+") {
      if (resp.http.x-datadome-headers !~ "(?i)(^| )+x-dd-type( |$)+") {
        unset resp.http.x-dd-type;
      }
    }
    if (resp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-botname( |$)+") {
      if (resp.http.x-datadome-headers !~ "(?i)(^| )+x-datadome-botname( |$)+") {
        unset resp.http.x-datadome-botname;
      }
    }
    if (resp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-botfamily( |$)+") {
      if (resp.http.x-datadome-headers !~ "(?i)(^| )+x-datadome-botfamily( |$)+") {
        unset resp.http.x-datadome-botfamily;
      }
    }
    if (resp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-isbot( |$)+") {
      if (resp.http.x-datadome-headers !~ "(?i)(^| )+x-datadome-isbot( |$)+") {
        unset resp.http.x-datadome-isbot;
      }
    }
    if (resp.http.x-datadome-request-headers ~ "(?i)(^| )+x-datadome-captchapassed( |$)+") {
      if (resp.http.x-datadome-headers !~ "(?i)(^| )+x-datadome-captchapassed( |$)+") {
        unset resp.http.x-datadome-captchapassed;
      }
    }
    unset resp.http.x-datadome-headers;
    unset resp.http.x-datadome-request-headers;
  } else {

  # copy datadome headers
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
      set resp.http.datadome-response = req.http.debug-datadome-response;
    }
  }
}

sub datadome_set_origin_header {
    unset bereq.http.destination;
    if (req.backend == F_datadome
     || req.backend == F_datadome_apac
     || req.backend == F_datadome_asia
     || req.backend == F_datadome_asia_south
     || req.backend == F_datadome_eu_central
     || req.backend == F_datadome_eu_east
     || req.backend == F_datadome_eu_west
     || req.backend == F_datadome_north_america
     || req.backend == F_datadome_sa_east
     || req.backend == F_datadome_sa_north
     || req.backend == F_datadome_sa_south
     || req.backend == F_datadome_south_africa
     || req.backend == F_datadome_us_central
     || req.backend == F_datadome_us_east
     || req.backend == F_datadome_us_west
     ) {
        # Retrieve Datadome key from dictionary HERE
        set bereq.http.x-datadome-apikey =
            table.lookup(bot_detection, "datadome_api_key");
        set bereq.http.x-datadome-modulename = "Fastly@NYT";
        set bereq.http.x-datadome-moduleversion = "1.6";
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
    }
}
