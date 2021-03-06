
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
#   set var.test_param = var.test_name + "=0_control";
# } elseif (var.p < 2834678415) {
#   set var.test_param = var.test_name + "=1_variant";
# } else {
#   set var.test_param = var.test_name + "=2_variant";
# }
#
# # Add the variation param to the tests:
# set var.test_group = var.test_group + var.test_param;
#
# # Add the variation param to specific route variables so that the cache can vary.
# # For example, the homepage route:
# set req.http.var-home-abtest-variation = req.http.var-home-abtest-variation + var.test_param;
#
# # This pipe needs to be added between each test result, but not after the last one.
# set var.test_group = var.test_group + "&";
# ---------------------------

sub recv_abra_allocation {

  declare local var.hash STRING;
  declare local var.p INTEGER;
  declare local var.test_group STRING;
  declare local var.test_name STRING;
  declare local var.test_param STRING;

  # only if this execution is not on the shield pop in a shielding scenario
  if (!req.http.x-nyt-shield-auth) {

    # Are we on the home route?
    declare local var.is_home BOOL;
    set var.is_home = (req.http.x-nyt-route == "homepage");
    # Are we on the story route?
    declare local var.is_story BOOL;
    set var.is_story = (req.http.x-nyt-route == "vi-story");
    # Are we on the interactive route?
    declare local var.is_interactive BOOL;
    set var.is_interactive = (req.http.x-nyt-route == "vi-interactive");

    #######################################
    # Test Name: STYLN_recirc_pres
    #
    # Description: Storylines recirc pres is testing click response of editors picks
    #              and associated when they are in the third ad slot on the page
    #
    # Variants:
    #   - 0_control                        60%
    #   - 1_edpicks_a                      10%
    #   - 2_edpicks_b                      10%
    #   - 3_morein_a                       10%
    #   - 4_morein_b                       10%
    #

    # Are we on the story route and is the test enabled?
    # Also limit articles cached to 2019/08/05 ~ 2019/08/19
    if (req.http.x-nyt-route == "vi-story" && req.http.var-is-storylines-recirc-test-enabled == "true" && req.url ~ "^/?2019/08/(0[5-9]|1[0-9])/") {
      #append an & if there was a previous test
      if (var.test_group){
        set var.test_group = var.test_group "&";
      }

      set var.test_name = "STYLN_recirc_pres";
      set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
      set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
      set var.p = std.strtol(var.hash, 16);

      if (var.p < 2576980377) {
        set var.test_param = var.test_name + "=0_recirc_pres_control";
      } elseif (var.p < 3006477106) {
        set var.test_param = var.test_name + "=1_edpicks_a";
      } elseif (var.p < 3435973835) {
        set var.test_param = var.test_name + "=2_edpicks_b";
      } elseif (var.p < 3865470564) {
        set var.test_param = var.test_name + "=3_morein_a";
      } else{
        set var.test_param = var.test_name + "=4_morein_b";
      }

      set var.test_group = var.test_group + var.test_param;
      # vary the cache on story routes:
      set req.http.var-story-abtest-variation = req.http.var-story-abtest-variation + var.test_param;
    }

    # Test Name: HOME_chartbeat
    #
    # Description: Chartbeat headline tester on homepage
    #
    # Variants:
    #   - 0_control                        80%
    #   - 1_variant                        20%
    #
    #

    if (var.is_home) {

      if (var.test_group){
        set var.test_group = var.test_group "&";
      }
      set var.test_name = "HOME_chartbeat";
      set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
      set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
      set var.p = std.strtol(var.hash, 16);

      if (var.p < 3435973836) {
        set var.test_param = var.test_name + "=0_control";
      } else {
        set var.test_param = var.test_name + "=1_variant";
      }

      set var.test_group = var.test_group + var.test_param;
      # We need to vary the cache on both the home and story routes:
      set req.http.var-home-abtest-variation = req.http.var-home-abtest-variation + var.test_param;
    }
    #
    # End of Test HOME_chartbeat
    #######################################

    # Test Name: HOME_editorsPicks
    #
    # Description: Editor's Picks content test on homepage
    # only for external clients
    #
    # The test only affects 25% of total traffic
    #
    # Variants:
    #   - 0_control                                 5%
    #   - 1_week_userhistory                        5%
    #   - 2_month_userhistory                       5%
    #   - 3_week_userhistory_impressions            5%
    #   - 4_month_userhistory_impressions           5%
    #

    #  Temporarily turning off HOME_editorsPicks test

    /* if (var.is_home && !(req.http.x-nyt-nyhq-access == "1")) {

      if (var.test_group){
        set var.test_group = var.test_group "&";
      }
      set var.test_name = "HOME_editorsPicks";
      set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
      set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
      set var.p = std.strtol(var.hash, 16);

      if (var.p < 214748365) {
        set var.test_param = var.test_name + "=0_control";
      } else if (var.p < 429496730) {
        set var.test_param = var.test_name + "=1_week_userhistory";
      } else if (var.p < 644245094) {
        set var.test_param = var.test_name + "=2_month_userhistory";
      } else if (var.p < 858993459) {
        set var.test_param = var.test_name + "=3_week_userhistory_impressions";
      } else if (var.p < 1073741824) {
        set var.test_param = var.test_name + "=4_month_userhistory_impressions";
      }

      set var.test_group = var.test_group + var.test_param;
      # We need to vary the cache on home route:
      set req.http.var-home-abtest-variation = req.http.var-home-abtest-variation + var.test_param;
    } */
    #
    # End of Test HOME_editorsPicks
    #######################################

    # Test Name: HOME_greatReads
    #
    # Description: Great reads content test on homepage
    # only for external clients
    #
    #
    # Variants:
    #   - 0_control                                 80%
    #   - 1_variant                                 20%
    #

    if (var.is_home && !(req.http.x-nyt-nyhq-access == "1")) {

      if (var.test_group){
        set var.test_group = var.test_group "&";
      }
      set var.test_name = "HOME_greatReads";
      set var.hash = digest.hash_sha256(req.http.var-cookie-nyt-a + " " + var.test_name);
      set var.hash = regsub(var.hash, "^([a-fA-F0-9]{8}).*$", "\1");
      set var.p = std.strtol(var.hash, 16);

      if (var.p < 3435973837) {
        set var.test_param = var.test_name + "=0_control";
      } else {
        set var.test_param = var.test_name + "=1_variant";
      }

      set var.test_group = var.test_group + var.test_param;
      # We need to vary the cache on home route:
      set req.http.var-home-abtest-variation = req.http.var-home-abtest-variation + var.test_param;
    }
    #
    # End of Test HOME_editorsPicks
    #######################################

    # We pass a generically-named header `x-nyt-vi-abtest` to the Vi server, which
    # implements the A/B test branching logic.
    # example value: HOME_test_foo=0_control&STORY_test_bar=1_variant
    set req.http.x-nyt-vi-abtest = var.test_group;
  }
}
