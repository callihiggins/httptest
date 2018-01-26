sub recv_set_gcs_aws_auth_headers {
  if(req.http.x-nyt-gcs-private-bucket) {
    set req.http.Date = "now";
    set req.http.Authorization = "AWS " table.lookup(origin_auth_keys,"gcs_key") ":" digest.hmac_sha1_base64(table.lookup(origin_auth_keys,"gcs_secret"), req.request LF LF LF req.http.Date LF "/"req.http.x-nyt-gcs-private-bucket req.url.path);
  }
}
