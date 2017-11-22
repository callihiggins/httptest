# use keys in x-fastly-stg header for staging access from non-whitelisted IPs
table staging_access_tokens {
  # "app-<random>" : "<issue date>"
  "watching-2gk6" : "20170614",
}

table internal_access_tokens {
  "drone-fastly-test-4er7" : "20171016", //the item for drone-fastly-test to access dev or stg with drone
}

sub vcl_recv {

    // Reset access levels before setting them
    unset req.http.x-nyt-internal-access;
    unset req.http.x-nyt-external-access;

    if (client.ip ~ internal || client.ip ~ vpc_nat_gateway || table.lookup(internal_access_tokens, req.http.x-fastly-stg) ~ "^[0-9]{8}$") {
      set req.http.x-nyt-internal-access = "1";
    }

    if (client.ip ~ external_staging_access || table.lookup(staging_access_tokens, req.http.x-fastly-stg) ~ "^[0-9]{8}$") {
      set req.http.x-nyt-external-access = "1";
    }

    # unset anything that we shouldn't trust from the user request
    if (!req.http.x-nyt-internal-access) {
      unset req.http.x-skip-glogin;
      unset req.http.x-nyt-backend-health;
    }

    /*
     * capture specific cookie values into custom headers
     */
    if (req.http.Cookie:NYT-S) {
      set req.http.x-nyt-s = urldecode(req.http.Cookie:NYT-S);
    }

    // detect if there are at least two NYT-S cookies
    if (req.http.x-nyt-s){
      set req.http.x-nyt-s2 = regsub(req.http.Cookie, ".*?NYT-S=.*NYT-S=([^;]*).*", "\1");
      if(req.http.x-nyt-s2 == req.http.Cookie) {
        // unset this req var if we didn't find one
        unset req.http.x-nyt-s2;
      } else {
        // apparently we did find one, skip glogin for this request to fail open
        set req.http.x-skip-glogin = "1";
      }
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

    # handle the nyt-a cookie in a restart safe manner
    if (!req.http.x-nyt-a && req.http.Cookie:nyt-a) {
      set req.http.x-nyt-a = req.http.Cookie:nyt-a;
    }

    if (!req.http.x-nyt-a) {
      # we didn't get a uuid, generate and set one
      set req.http.x-nyt-a = digest.hash_sha256(
          now.sec+
          randomstr(64)+
          req.http.host+
          req.url+
          client.ip+
          client.port+
          server.identity);
    }

    if (req.http.Cookie:nyt-bcet){
      set req.http.x-nyt-bcet = req.http.Cookie:nyt-bcet;
    }

    if (req.http.host ~ "\.dev\."){
      set req.http.x-environment = "dev";
    } else if (req.http.host ~ "\.stg\."){
      set req.http.x-environment = "stg";
    } else {
      set req.http.x-environment = "prd";
    }

    if (req.http.x-environment == "prd") {
      set req.http.x-nyt-logger-name = "webprd-www";
    } else {
      set req.http.x-nyt-logger-name = "webstg-www";
    }

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

    /*
     * salt for BCET, we'll put this in drone secrets when we refactor
     */
    set req.http.x-bcet-secret-key = "75b798658d2f43bc1caadb0260d175524ad3c874ab76a15c9aeef3cec11096597f068faca3133285a004fa2106799246dc050ec66c3e75c134d26b8d163b6086";

    set req.http.x-nyt-glogin-error-skip-key = "43697263756974427265616b474c4f47494e5468697352657175657374";
}
