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

sub recv_capture_cookie_values {
    # capture specific cookie values into custom headers
    if (req.http.Cookie:NYT-S) {
      set req.http.var-cookie-nyt-s = urldecode(req.http.Cookie:NYT-S);
    }

    if (req.http.Cookie:NYT-Edition) {
      set req.http.var-cookie-nyt-edition = urldecode(req.http.Cookie:NYT-Edition);
    }

    if (req.http.Cookie:nyt-mobile) {
      set req.http.var-cookie-nyt-mobile = urldecode(req.http.Cookie:nyt-mobile);
    }

    if (req.http.Cookie:nyt.np.enable-https) {
        set req.http.var-cookie-np-enable-https = urldecode(req.http.Cookie:nyt.np.enable-https);
    }

    if (req.http.Cookie:nyt.np.internal-https-opt-out) {
        set req.http.var-cookie-nyt-np-internal-https-opt-out = urldecode(req.http.Cookie:nyt.np.internal-https-opt-out);
    }
}

sub recv_initialize_transaction_state {

    # variables that should always be empty for a new transaction
    unset req.http.x-nyt-backend-health;
    unset req.http.x-nyt-backend;
    unset req.http.x-nyt-ttl-override;
    unset req.http.var-nyt-force-pass;
    unset req.http.x-nyt-route;
    unset req.http.x-nyt-backend;
    unset req.http.var-nyt-no-referrer;

    # initialize sending gdpr cookie to false
    set req.http.var-nyt-send-gdpr = "false";

    # logic that should not be executed on a shield pop
    if(!req.http.x-nyt-shield-auth) {
      # do not create a uuid var if this transaction is on a shield pop backend
      call recv_create_uuid_var;

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
    set req.http.var-nyt-logger-name = "web" + req.http.var-nyt-env + "-www";

    # Set a var with the original querystring if it exists, some logic needs to use it in vcl_deliver
    # do not do this if this has been restarted or if we're on a shield pop
    # we will rely on the edge to send this to the shield
    if(req.restarts == 0 && !req.http.x-nyt-shield-auth) {
        if (req.url ~ "\?") {
            set req.http.x-nyt-orig-querystring = regsub(req.url, ".*(\?.*)", "\1");
        } else {
            set req.http.x-nyt-orig-querystring = "";
        }
    }

    # catpure mobile redirect qparam
    call recv_mobile_redirect_capture_qparam;
}