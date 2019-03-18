
#
# Vi A/B Testing
#
# The goal of this file is to allow fastly-based A/B tests to be easily configured and launched.
# The approach that is taken for AB testing utilizes a http header specifying test variants into
# vi-server, which is also used as the key for caching.
#
# The recv_abra_allocation file ultimately sets the req.http.x-nyt-vi-abtest header with the test
# variants based on aspects such as the current route, whether a user is inside or outside the
# building, and any other potential factors.
#
# The header will look something like follows and will be up to vi to parse it.
# EXAMPLE_TEST_NAME=0_control&EXAMPLE_TEST_NAME_2=1_variant
#
# To allocate a user into a specific test, we hash the nyt-a cookie with the ABRA test name into
# an integer between 0 to 2^32 - 1.
#
# set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + var.test_name);
# set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
# set var.p = std.strtol(var.hash, 16);
#
# To calculate the values that go into the if statements regarding each threshold, run the
# percentage boundary you want into the following formula example for 33%:
#
# floor(0.33 * 2^32)
#
# Note that we should keep this file very well commented and tests clearly separated in order to
# keep this file as organized as possible.
#
# To add a new test, it is recommended to copy the section commented below and replace the values
# with the name of your test, the variants, and the allocation of each into the file.
#
# EXAMPLE
# ---------------------------
# #######################################
# # Test Name: EXAMPLE_TEST_NAME
# #
# # Description: Leave a description of what the test is for, and any other special notes.
# #
# # Variants:
# #   - 0_control       33%
# #   - 1_variant       33%
# #   - 2_variant       33%
# #
# set var.test_name = "EXAMPLE_TEST_NAME";
# set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
# set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
# set var.p = std.strtol(var.hash, 16);
#
# if (var.p < 1417339207) {
#   set var.test_group = var.test_group + var.test_name + "=0_control";
# } elseif (var.p < 2834678415) {
#   set var.test_group = var.test_group + var.test_name + "=1_variant";
# } else {
#   set var.test_group = var.test_group + var.test_name + "=2_variant";
# }
#
# # This pipe needs to be added between each test result, but not after the last one.
# set var.test_group = var.test_group + "&";
# ---------------------------

sub recv_abra_allocation {

  declare local var.hash STRING;
  declare local var.p INTEGER;
  declare local var.test_group STRING;
  declare local var.test_name STRING;

  # only if this execution is not on the shield pop in a shielding scenario
  if (!req.http.x-nyt-shield-auth) {

    # HOMEPAGE TESTS
    if (req.http.x-nyt-route == "homepage") {

      #######################################
      # Test Name: HOME_package_stories_count
      #
      # Description: Number of stories per package A/B test.
      #
      # Variants:
      #   - 0_control           98%
      #   - 1_package_max_one   1%
      #   - 2_package_max_two   1%
      #
      set var.test_name = "HOME_package_stories_count";
      set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
      set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
      set var.p = std.strtol(var.hash, 16);

      if (req.http.x-nyt-nyhq-access == "1" || var.p < 4209067950) {
        set var.test_group = var.test_group + var.test_name + "=0_control";
      } elseif (var.p < 4252017623) {
        set var.test_group = var.test_group + var.test_name + "=1_package_max_one";
      } else {
        set var.test_group = var.test_group + var.test_name + "=2_package_max_two";
      }

      set var.test_group = var.test_group + "&";

      #######################################
      # Test Name: HOME_top_stories_count
      #
      # Description: Number of stories / packages in top stories A/B test.
      #
      # Variants:
      #   - 0_control           98%
      #   - 1_total_less_one    1%
      #   - 2_total_less_two    1%
      #
      set var.test_name = "HOME_top_stories_count";
      set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
      set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
      set var.p = std.strtol(var.hash, 16);

      if (req.http.x-nyt-nyhq-access == "1" || var.p < 4209067950) {
        set var.test_group = var.test_group + var.test_name + "=0_control";
      } elseif (var.p < 4252017623) {
        set var.test_group = var.test_group + var.test_name + "=1_total_less_one";
      } else {
        set var.test_group = var.test_group + var.test_name + "=2_total_less_two";
      }

      set var.test_group = var.test_group + "&";

      #######################################
      # Test Name: HOME_chartbeat
      #
      # Description: Test performance of users who have the chartbeat script embedded.
      #
      # Variants:
      #   - 0_control               95%
      #   - 1_flicker_control       2.5%
      #   - 2_no_flicker_control    2.5%
      #
      set var.test_name = "HOME_chartbeat";
      set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
      set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
      set var.p = std.strtol(var.hash, 16);

      if (req.http.x-nyt-nyhq-access == "1" || var.p < 4080218931) {
        set var.test_group = var.test_group + var.test_name + "=0_control";
      } elseif (var.p < 4187593113) {
        set var.test_group = var.test_group + var.test_name + "=1_flicker_control";
      } else {
        set var.test_group = var.test_group + var.test_name + "=2_no_flicker_control";
      }

      set var.test_group = var.test_group + "&";

      #######################################
      # Test Name: HOME_summaries
      #
      # Description: Test the engagement impact on making the Home screen on mobile web
      # easier to scroll through
      #
      # Variants:
      #   - 0_control                               97%
      #   - 1_remove_summaries                      1%
      #   - 2_remove_summaries_except_package_one   1%
      #   - 3_remove_bullets                        1%
      #
      set var.test_name = "HOME_summaries";
      set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
      set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
      set var.p = std.strtol(var.hash, 16);

      if (req.http.x-nyt-nyhq-access || var.p < 4166118277) {
        set var.test_group = var.test_group + var.test_name + "=0_control";
      } elseif (var.p < 4209067950) {
        set var.test_group = var.test_group + var.test_name + "=1_remove_summaries";
      } elseif (var.p < 4252017623) {
        set var.test_group = var.test_group + var.test_name + "=2_remove_summaries_except_package_one";
      } else {
        set var.test_group = var.test_group + var.test_name + "=3_remove_bullets";
      }
    }

    # We pass a generically-named header `x-nyt-vi-abtest` to the Vi server, which
    # implements the A/B test branching logic.
    # example value: HOME_test_foo=0_control&HOME_test_bar=1_variant
    set req.http.x-nyt-vi-abtest = var.test_group;
  }
}
