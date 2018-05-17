sub miss_pass_unset_bereq_headers {
  # remove headers used as variables for logic
  # backend definitely does not need these
  # in some cases it could be a security concern
  unset bereq.http.x-nyt-edition;
  unset bereq.http.x-nyt-a;
  unset bereq.http.x-nyt-wpab;
  unset bereq.http.x-nyt-s;
  unset bereq.http.x-nyt-d;
  unset bereq.http.x-nyt-bucket-token;
  unset bereq.http.x-nyt-bucket-secret;
  unset bereq.http.x-nyt-bucket-name;
  unset bereq.http.x-nyt-bucket-provider;
  #unset bereq.http.x-nyt-mobile;

  # Denotes headers that have been through the audit
  unset bereq.http.var-nyt-env;
  unset bereq.http.var-nyt-wf-auth;
  unset bereq.http.var-nyt-force-pass;
  unset bereq.http.var-nyt-shield-auth;
  unset bereq.http.var-nyt-is-shielded;
  unset bereq.http.var-nyt-mobile-param;
  unset bereq.http.var-nyt-logger-name;
  unset bereq.http.var-nyt-canonical-www-host;
  unset bereq.http.var-nyt-send-gdpr;
  unset bereq.http.var-nyt-force-gdpr;
  unset bereq.http.var-nyt-has-nyt-t;
  unset bereq.http.var-cookie-nyt-t;
  unset bereq.http.var-nyt-has-gdpr;
  unset bereq.http.var-cookie-nyt-gdpr;
  unset bereq.http.var-nyt-https-phase;
}
