
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
    if (req.http.x-nyt-route == "vi-homepage") {

      #######################################
      # Test Name: HOME_comments_count
      #
      # Description: Used on vi homepage to determine whether to show a comment count or not.
      # This test contains a special caveat for all internal users to be allocated into the
      # "0_control" variant.
      #
      # Variants:
      #   - 0_control       33%
      #   - 1_comments_25   33%
      #   - 2_comments_100  33%
      #
      set var.test_name = "HOME_comments_count";
      set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
      set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
      set var.p = std.strtol(var.hash, 16);

      if (req.http.x-nyt-nyhq-access || var.p < 1417339207) {
        set var.test_group = var.test_group + var.test_name + "=0_control";
      } elseif (var.p < 2834678415) {
        set var.test_group = var.test_group + var.test_name + "=1_comments_25";
      } else {
        set var.test_group = var.test_group + var.test_name + "=2_comments_100";
      }

      set var.test_group = var.test_group + "&";

      #######################################
      # Test Name: HOME_briefing_carousel
      #
      # Description: briefing carousel A/B test.
      #
      # Variants:
      #   - 0_control       33%
      #   - 1_briefing_top  33%
      #   - 2_carousel_top  33%
      #
      set var.test_name = "HOME_briefing_carousel";
      set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
      set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
      set var.p = std.strtol(var.hash, 16);

      if (var.p < 1417339207) {
        set var.test_group = var.test_group + var.test_name + "=0_control";
      } elseif (var.p < 2834678415) {
        set var.test_group = var.test_group + var.test_name + "=1_briefing_top";
      } else {
        set var.test_group = var.test_group + var.test_name + "=2_carousel_top";
      }
    }

    # We pass a generically-named header `x-nyt-vi-abtest` to the Vi server, which
    # implements the A/B test branching logic.
    # example value: HOME_test_foo=0_control&HOME_test_bar=1_variant
    set req.http.x-nyt-vi-abtest = var.test_group;
  }
}
