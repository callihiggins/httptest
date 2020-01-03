// For load testing purposes, we sometimes want to direct traffic on staging to
// our VI load test cluster.
//
// In order to allow load test traffic through to the load test cluster, the
// client must provide a custom header:
//
//   X-NYT-Load-Test: 1
//
// Additionally, the backend needs to have already been set by other logic in
// the Fastly VCL configuration files to have a backend of "projectvi_fe".
//
// While the load test backend is not defined in the production YAML
// configuration, we still do a check that we're in a non-production
// environment when considering this header.
//
// An example curl command to test this behavior:
//
//   curl -H "X-NYT-Load-Test: 1" https://www.stg.nytimes.com/
//
// This does *not* consider the HTTP method, so any _valid_ traffic will pass
// through. This means that all of the other checks, such as IP address, will
// still be required when this header is present.
//
sub recv_route_vi_load_test {
  if (req.http.x-nyt-backend == "projectvi_fe"
      && req.http.x-nyt-load-test == "1"
      && req.http.var-nyt-env != "prd"
  ) {
    set req.http.x-nyt-backend = "projectvi_fe_load_test";
  }
}
