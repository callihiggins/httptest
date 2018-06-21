# sub to set up auth headers for storage buckets
# check main.tmpl and config yaml files for how these are intialized
# we only want to do this if we are talking directly to the bucket
sub miss_pass_set_bucket_auth_headers {

  if (!req.backend.is_shield) {

    if(bereq.http.x-nyt-bucket-provider == "gcs") {
      set bereq.http.host = bereq.http.x-nyt-bucket-name + ".storage.googleapis.com";
    } else {
      set bereq.http.host = bereq.http.x-nyt-bucket-name + ".s3.amazonaws.com";
    }

    if (req.http.x-nyt-bucket-auth == "true") {
      set bereq.http.date = now;
      set bereq.http.authorization = "AWS " table.lookup(origin_auth_keys, bereq.http.x-nyt-bucket-token) ":" digest.hmac_sha1_base64(table.lookup(origin_auth_keys, bereq.http.x-nyt-bucket-secret), "GET" LF LF LF bereq.http.date LF "/" bereq.http.x-nyt-bucket-name bereq.url.path);
    }
  }
}

sub miss_pass_wf_auth_headers {
  if (req.http.var-nyt-wf-auth == "true" && !req.backend.is_shield) {
      if (req.http.var-nyt-env == "prd") {
          set bereq.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_prd");
      } else {
          set bereq.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_stg");
      }
  }
}


# functions to validate a request came from an edge pop of the same service_id
# this is useful for controlling logic we may not want executed on the shield pop

# validate the signed header if this request came from a fastly pop
sub recv_shield_request_authorization {

    set req.http.var-nyt-shield-auth = digest.hmac_sha256(table.lookup(shield_auth_secrets, "secret"), req.service_id);
    if (req.http.x-nyt-shield-auth != req.http.var-nyt-shield-auth) {
      unset req.http.x-nyt-shield-auth;
    }
}

# create the auth header if the origin is a shield
sub miss_pass_shield_request_signing {
    if (req.backend.is_shield) {
        set bereq.http.x-nyt-shield-auth = req.http.var-nyt-shield-auth;
    }
}
