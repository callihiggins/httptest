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
  unset bereq.http.x-nyt-mobile;

  # Denotes headers that have been through the audit
  unset bereq.http.var-nyt-env;
  unset bereq.http.var-nyt-wf-auth;
  unset bereq.http.var-nyt-force-pass;
}
