sub miss_pass_unset_bereq_headers {

  # remove headers used as variables for logic
  # backend definitely does not need these
  # in some cases it could be a security concern
  # TODO: which of these can be refactored to var-nyt namespace
  unset bereq.http.x-nyt-bucket-token;
  unset bereq.http.x-nyt-bucket-secret;
  unset bereq.http.x-nyt-bucket-name;
  unset bereq.http.x-nyt-bucket-provider;

  # unset the routing headers if we are sending
  # this request to a fastly shield pop
  # it should route it again itself
  if (req.http.var-nyt-is-shielded == "true") {
    unset bereq.http.x-nyt-route;
    unset bereq.http.x-nyt-backend;
  }

  # unset header vars being used solely for fastly logic
  # there are the headers that have recfactored naming

  unset bereq.http.var-cookie-np-enable-https;
  unset bereq.http.var-cookie-nyt-a;
  unset bereq.http.var-cookie-nyt-edition;
  unset bereq.http.var-cookie-nyt-gdpr;
  unset bereq.http.var-cookie-nyt-np-internal-https-opt-out;
  unset bereq.http.var-cookie-nyt-s;
  unset bereq.http.var-cookie-nyt-t;

  unset bereq.http.var-is-east-static-backup-enabled;
  unset bereq.http.var-is-vi-static-backup-enabled;
  unset bereq.http.var-nyt-404-url;
  unset bereq.http.var-nyt-canonical-www-host;
  unset bereq.http.var-nyt-elections-bucket;
  unset bereq.http.var-nyt-env;
  unset bereq.http.var-nyt-error-retry;
  unset bereq.http.var-nyt-force-gdpr;
  unset bereq.http.var-nyt-force-pass;
  unset bereq.http.var-nyt-geoip-ip;
  unset bereq.http.var-nyt-has-gdpr;
  unset bereq.http.var-nyt-has-nyt-t;
  unset bereq.http.var-nyt-https-phase;
  unset bereq.http.var-nyt-ismagnolia;
  unset bereq.http.var-nyt-is-shielded;
  unset bereq.http.var-nyt-no-referrer;
  unset bereq.http.var-nyt-redirect-reason;
  ##unset bereq.http.var-nyt-logger-name;
  unset bereq.http.var-nyt-sumo-purge-log-name;
  unset bereq.http.var-nyt-send-gdpr;
  unset bereq.http.var-nyt-shield-auth;
  unset bereq.http.var-nyt-sumo-purge-log-name;
  unset bereq.http.var-nyt-surrogate-key;
  unset bereq.http.var-nyt-vi-story-compatibility;
  unset bereq.http.var-nyt-wf-auth;
}
