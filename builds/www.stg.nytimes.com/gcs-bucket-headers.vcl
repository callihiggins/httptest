sub miss_pass_set_gcs_aws_auth_headers {
  if(req.http.x-nyt-gcs-private-bucket) {
    set bereq.http.Date = now;
    set bereq.http.Authorization = "AWS " + table.lookup(origin_auth_keys,"gcs_key") + ":" + digest.hmac_sha1_base64(table.lookup(origin_auth_keys,"gcs_secret"), if(req.request == "HEAD", "GET", req.request) LF LF LF req.http.Date LF "/" req.http.x-nyt-gcs-private-bucket req.url.path);
  }
}
