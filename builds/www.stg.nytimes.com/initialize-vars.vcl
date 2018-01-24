# use keys in x-fastly-stg header for staging access from non-whitelisted IPs
table staging_access_tokens {
  # "app-<random>" : "<issue date>"
  "watching-2gk6" : "20170614",
  "cms-scoop-9v5q" : "20180105",
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
      unset req.http.x-nyt-backend-health;
      unset req.http.x-nyt-backend;
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

    if (req.http.host ~ "\.dev\."){
      set req.http.x-environment = "dev";
    } else if (req.http.host ~ "\.stg\."){
      set req.http.x-environment = "stg";
    } else {
      set req.http.x-environment = "prd";
    }

    set req.http.x-nyt-logger-name = "web" + req.http.x-environment + "-www";

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
}
