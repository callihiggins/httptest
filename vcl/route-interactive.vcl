sub recv_route_interactive {

  declare local var.interactive_failover_override STRING;

  # interactive years 2014-forever are served by Vi
  # including all variants, canonical and .(embedded|mobile|app)\.html
  if (req.http.x-nyt-route != "elections" && 
      req.url.path !~ "\.amp\.html$" &&
     (req.url ~ "^/interactive/magazine/masthead.html" ||
      req.url ~ "^/interactive/20(1[4-9]|[2-9][0-9])/")) {

    set var.interactive_failover_override = "0";

    # evaluate if interactive failover cookie override is enabled for this request
    if (req.http.Cookie:interactive-failover == "1" && req.http.x-nyt-nyhq-access == "1") {
      set var.interactive_failover_override = "1";
    }

    # use the elections failover backend if:
    # 1. `interactive_failover` item in `newsdev_elections` dictionary == `true`
    #  OR
    # 2. `interactive-failover` cookie value == `1` and user is in NYHQ auth
    if ((table.lookup(newsdev_elections, "interactive_failover", "false") == "true" || var.interactive_failover_override == "1") &&
        req.http.var-nyt-canonical-www-host == "true") {

      # only allow one URL in production, non-prd can fail the entire route to AWS
      # the cookie override will still allow anything to fail to S3
      # adding this extra conditional so it's easier to remove when we remove the production restriction
      if ( (req.http.var-nyt-env == "dev" || req.url ~ "^/interactive/2019/11/15/us/elections/2015-louisiana-general.html") ||
            var.interactive_failover_override == "1") {

        # force pass if the cookie override is being used so we do not publically cache the response
        if (var.interactive_failover_override == "1") {
          set req.http.var-nyt-force-pass = "true";
        }

        set req.http.x-nyt-route = "interactive-s3-failover";
        set req.http.x-nyt-backend = "s3_origin";
        set req.http.var-nyt-send-gdpr = "true";
        set req.http.var-nyt-error-retry = "false";
        set req.http.var-nyt-4xx-serve-stale = "true";
        set req.url = querystring.remove(req.url);

      } else {
        set req.http.x-nyt-route = "vi-interactive";
        set req.http.var-nyt-wf-auth = "true";
        set req.http.var-nyt-send-gdpr = "true";
        set req.http.x-nyt-backend = "projectvi_fe";
        set req.http.var-nyt-error-retry = "false";

        if (req.http.var-nyt-canonical-alpha-host != "true") {
          set req.url = querystring.remove(req.url);
        }
      }
    } else {
      set req.http.x-nyt-route = "vi-interactive";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-error-retry = "false";

      if (req.http.var-nyt-canonical-alpha-host != "true") {
        set req.url = querystring.remove(req.url);
      }
    }

    unset req.http.Authorization;

    call recv_post_method_restricted;
  }
}

sub miss_pass_route_interactive {
  if (req.http.x-nyt-route == "vi-interactive") {
    unset bereq.http.cookie;
  }

  if (req.http.x-nyt-route == "interactive-s3-failover") {
    call miss_pass_set_bucket_auth_headers;
  }
}

sub fetch_route_interactive {
  if (req.http.x-nyt-route == "vi-interactive" && beresp.status == 400) {
    set beresp.cacheable = true;
  }
}
