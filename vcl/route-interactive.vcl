sub recv_route_interactive {

  # interactive years 2014-forever are served by Vi
  # including all variants, canonical and .(embedded|mobile|app)\.html
  if (req.http.x-nyt-route != "elections" &&
      req.url.path !~ "\.amp\.html$" &&
     (req.url ~ "^/interactive/magazine/masthead.html" ||
      req.url ~ "^/interactive/20(1[4-9]|[2-9][0-9])/")) {


    set req.http.x-nyt-route = "vi-interactive";
    set req.http.var-nyt-wf-auth = "true";
    set req.http.var-nyt-send-gdpr = "true";
    set req.http.x-nyt-backend = "projectvi_fe";
    set req.http.var-nyt-error-retry = "false";

    # do not remove the query string if this is an `alpha` URL (preview type functionality)
    if (req.http.var-nyt-canonical-alpha-host != "true") {
      set req.url = querystring.remove(req.url);
    }

    unset req.http.Authorization;

    call recv_post_method_restricted;

    # sub to determine if a subset of interactives are in an AWS failover state
    # this will override the route/backend if the failover condition exists for this request
    # we only do this for requests using a canonical www host
    if (req.http.var-nyt-canonical-www-host == "true") {
      call interactive_2020_election_aws_failover;
    }
  }
}

sub hash_route_interactive {
    // need to vary based on crawler so that Vi can serverside render more
    if (req.http.device_type == "crawler" && req.http.x-nyt-route == "vi-interactive") {
      set req.hash += "crawler";
    }
}

sub interactive_2020_election_aws_failover {

  declare local var.interactive_failover_cookie_override_enabled BOOL;
  declare local var.url_can_failover_by_dictionary BOOL;

  # evaluate if interactive failover cookie override is enabled for this request
  # the cookie override allows ANY url in the interactive route to try to use AWS
  # this is for testing a single URL
  # the client must be authed to NYHQ role access by IP or `x-fastly-stg` header key
  if (req.http.Cookie:interactive-failover == "1" && req.http.x-nyt-nyhq-access == "1") {
    set var.interactive_failover_cookie_override_enabled = true;
  }

  # evaluate if the URL is valid for failover to AWS based on dictionary value
  # if new patterns need to be added/changed for failover scope add them to this conditional
  if (req.url.path ~ "^/interactive/2020/([0-1][0-9]/[0-9]{2}/)?us/elections/results-.*\.html$") {
    set var.url_can_failover_by_dictionary = true;
  }

  # use the elections failover backend if:
  # 1. `interactive_failover` item in `newsdev_elections` dictionary == `true` and the URL is allowed to failover
  #  OR
  # 2. the cookie override funcitonality has been validated to be enabled
  #
  # the host must also be a canonical www host, not any other host such as alpha
  if ( ( (table.lookup(newsdev_elections, "interactive_failover", "false") == "true" && var.url_can_failover_by_dictionary)
         || var.interactive_failover_cookie_override_enabled)) {

    # force pass if the cookie override is being used so we do not publically cache the response
    if (var.interactive_failover_cookie_override_enabled) {
      set req.http.var-nyt-force-pass = "true";
    }

    set req.http.x-nyt-route = "interactive-s3-failover";
    set req.http.x-nyt-backend = "s3_origin";
    set req.http.var-nyt-send-gdpr = "true";
    set req.http.var-nyt-error-retry = "false";
    set req.http.var-nyt-4xx-serve-stale = "true";
    set req.url = querystring.remove(req.url);
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
