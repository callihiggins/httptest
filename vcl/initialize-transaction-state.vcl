sub recv_determine_env_from_host {
    # set the environment class variable
    if (req.http.host ~ "\.dev\."){
      set req.http.var-nyt-env = "dev";
    } else if (req.http.host ~ "\.stg\."){
      set req.http.var-nyt-env = "stg";
    } else {
      set req.http.var-nyt-env = "prd";
    }
}

sub recv_set_canonical_www_host_var {
    # set a var to denote if this domain is canonical www request
    if (req.http.host ~ "^(www-[a-z0-9]+\.)(dev\.|stg\.|)?nytimes.com$" || req.http.host ~ "^www\.(dev\.|stg\.|)?nytimes.com$") {
      set req.http.var-nyt-canonical-www-host = "true";
    } else {
      set req.http.var-nyt-canonical-www-host = "false";
    }
}

sub recv_block_alpha_preview {
    if (req.http.host ~ "^alpha" && ! (req.http.x-nyt-nyhq-access == "1" || req.http.x-nyt-staging-only-access == "1" )) {
      error 403 "Not Allowed, Forbidden";
    }
}

sub recv_initialize_transaction_state {

    # variables that should always be empty for a new transaction
    unset req.http.x-nyt-backend-health;
    unset req.http.x-nyt-ttl-override;
    unset req.http.var-nyt-force-pass;
    unset req.http.x-nyt-route;
    unset req.http.x-nyt-backend;

    # initialize sending gdpr cookie to false
    set req.http.var-nyt-send-gdpr = "false";

    # logic that should not be executed on a shield pop
    if(!req.http.x-nyt-shield-auth) {
      # do not create an agent id (nyt-a cookie) if this transaction is on a shield pop backend
      call recv_create_agent_id_var;

      # this could be incorrect if we are on a shield pop backend
      # set the original protocol to let downstream systems know what it was
      if (req.http.Fastly-SSL) {
        set req.http.X-Forwarded-Proto = "https";
      }

      # save off the URL the user came with
      # need it to reset for restarts and other logic
      set req.http.x-nyt-original-url = req.url;
    }

    # set the var for using vcl log to sumo in this service
    # TODO: if we change the name of the integration this needs to change
    # TODO: Move this as a var to recv_sumologic_purge_log_line once we are done with tracing
    set req.http.var-nyt-sumo-purge-log-name = "fastly-www-purge/" + if(req.http.var-nyt-env != "prd", "stg","prd");

    # Set a var with the original querystring if it exists, some logic needs to use it in vcl_deliver
    # do not do this if this has been restarted or if we're on a shield pop
    # we will rely on the edge to send this to the shield
    if (req.restarts == 0 && !req.http.x-nyt-shield-auth) {
        if (req.url ~ "\?") {
            set req.http.x-nyt-orig-querystring = regsub(req.url, ".*(\?.*)", "\1");
        } else {
            set req.http.x-nyt-orig-querystring = "";
        }
    }

    # (route-vi-static-backup-gcs)
    # Manual switch to turn on/off the vi static backup routing.
    # To failover, uncomment this var, set it to "true" and redeploy
    # set req.http.var-is-vi-static-backup-enabled = "false";

    # If the request is internal and we detect our backup
    # unit test header then manually turn on the switch.
    if (req.http.x-nyt-nyhq-access == "1" && req.http.vi-static-backup-test == "true") {
      set req.http.var-is-vi-static-backup-enabled = "true";
    }
    # The default static backup will be read from the Central cluster.
    # To Failover to East, uncomment this var, set it to true and redeploy
    # set req.http.var-is-east-static-backup-enabled = "false";

    # Switch to turn on/off the Storylines ABRA test.
    # Currently set to off, testing in prod is on hold
    # set req.http.var-is-storylines-recirc-test-enabled = "false";

    # For debugging purposes, if the request is internal and we
    # detect a test header, then turn on the switch.
    if (req.http.x-nyt-nyhq-access == "1" && req.http.storylines-recirc-test == "true") {
      set req.http.var-is-storylines-recirc-test-enabled = "true";
    }

    # If the request is internal, allow for a client to choose a specific
    # backend for a request (only works in route-switchboard)
    if (req.http.x-nyt-nyhq-access != "1") {
      unset req.http.x-nyt-force-backend;
    }
}
