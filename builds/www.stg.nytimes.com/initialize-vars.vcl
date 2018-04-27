# this subroutine is for the new routing logic created in recfactor
# we will migrate things into this sub as needed
sub initialize_global_variable_headers {

  # set the environment class variable
  if (req.http.host ~ "\.dev\."){
    set req.http.var-nyt-env = "dev";
  } else if (req.http.host ~ "\.stg\."){
    set req.http.var-nyt-env = "stg";
  } else {
    set req.http.var-nyt-env = "prd";
  }

  # set a var to denote if this domain is canonical www request
  if (req.http.host ~ "^(www-[a-z0-9]+\.)(dev\.|stg\.|)?nytimes.com$" || req.http.host ~ "^www\.(dev\.|stg\.|)?nytimes.com$") {
    set req.http.x-nyt-canonical-www-host = "true";
  } else {
    set req.http.x-nyt-canonical-www-host = "false";
  }

  set req.http.var-nyt-send-gdpr = "false";
}

sub vcl_recv {

    # nearly everything in here eventually needs to be put in default.vcl
    # in a sub call..
    # cannot until all the other logic is moved there due to order of ops

    # initialize header vars that are used throughout logic here
    call initialize_global_variable_headers;

    # what level of access does this user have based on ACL and/or auth headers
    call recv_set_access_level;

    # block the request if the user does not have access to the environment
    call recv_restrict_access;

    # unset anything that we shouldn't trust from the user request
    if (!req.http.x-nyt-internal-access) {
      unset req.http.x-nyt-backend-health;
      unset req.http.x-nyt-backend;
      unset req.http.x-nyt-ttl-override;
      unset req.http.var-nyt-force-pass;
      unset req.http.x-nyt-mobile;
    }

    /*
     * capture specific cookie values into custom headers
     */
    if (req.http.Cookie:NYT-S) {
      set req.http.x-nyt-s = urldecode(req.http.Cookie:NYT-S);
    }

    if (req.http.Cookie:NYT-Edition) {
      set req.http.x-nyt-edition = urldecode(req.http.Cookie:NYT-Edition);
    }

    if (req.http.Cookie:nyt-d) {
      set req.http.x-nyt-d = urldecode(req.http.Cookie:nyt-d);
    }

    if (req.http.Cookie:NYT-wpAB) {
      set req.http.x-nyt-wpab = urldecode(req.http.Cookie:NYT-wpAB);
    }

    if (req.http.Cookie:nyt-mobile) {
      set req.http.x-nyt-mobile = urldecode(req.http.Cookie:nyt-mobile);
    }

    # handle the nyt-a cookie in a restart safe manner
    if (!req.http.x-nyt-a && req.http.Cookie:nyt-a) {
      set req.http.x-nyt-a = req.http.Cookie:nyt-a;
    }

    if (req.http.x-nyt-a !~ ".") { # if nyt-a doesn't match any character, it's either empty string or NULL
      # we didn't get a uuid, generate and set one
      set req.http.x-nyt-a = digest.hmac_sha256_base64(
          # key doesn't really matter for our purposes, but here's 256 bits entropy anyway:
          "1pCPYoPsNtx1aDpv8EUZ9azYZ3szwSeKFXnmHAojc3s",
          now.sec +
          randomstr(64) +
          req.http.host +
          req.http.user-agent +
          req.http.cookie +
          req.url +
          client.ip +
          req.http.Fastly-Client-IP +
          time.start.usec +
          time.elapsed.usec +
          client.port +
          server.identity
      );

      // we only need 22 base64 chars to reach 128 bits entropy (22 * 6 = 132):
      set req.http.x-nyt-a = regsub(req.http.x-nyt-a, "^(.{22}).*$", "\1");
      // replace '+' and '/' with cookie-safe '-' and '_':
      set req.http.x-nyt-a = regsuball(req.http.x-nyt-a, "\+", "-");
      set req.http.x-nyt-a = regsuball(req.http.x-nyt-a, "\/", "_");
    }

    set req.http.x-nyt-logger-name = "web" + req.http.var-nyt-env + "-www";

    // set the original protocol to let downstream systems know what it was
    if (req.http.Fastly-SSL) {
      set req.http.X-Forwarded-Proto = "https";
    }

    /*
     * capture https enable cookie value, if present
     */
    if (req.http.Cookie:nyt.np.enable-https) {
        set req.http.x-nyt-np-enable-https = urldecode(req.http.Cookie:nyt.np.enable-https);
    }

    /*
     * capture the internal https opt out cookie, if present
     */
    if (req.http.Cookie:nyt.np.internal-https-opt-out) {
        set req.http.x-internal-https-opt-out = urldecode(req.http.Cookie:nyt.np.internal-https-opt-out);
    }

    /*
     * Set a var with the original querystring if it exists, some logic needs to use it in vcl_deliver
     */
    if(req.restarts == 0) {
        if (req.url ~ "\?") {
            set req.http.x-orig-querystring = regsub(req.url, ".*(\?.*)", "\1");
        } else {
            set req.http.x-orig-querystring = "";
        }
    }

    # catpure mobile redirect qparam
    call recv_mobile_redirect_capture_qparam;
}
