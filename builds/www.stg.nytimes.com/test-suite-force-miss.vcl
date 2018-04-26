sub recv_test_suite_force_miss {

    # if the request asked for a cache miss and the client is authorized for internal access
    if (req.http.x-nyt-miss == "1" && req.http.x-nyt-internal-access == "1") {

      # allow request collapsing for the test suite
      set req.hash_ignore_busy = false;

      # test suite will always cache miss to force origin requests
      # testing cache hits is undesirable for the fastly test suite
      set req.hash_always_miss = true;

    }
}
