# acl
include "acl-googlebot";
include "shared-access-control";
include "shared-vcl-version";
include "shared-geoip-headers-init";
include "shared-device-detection-init";
include "shared-cmots-headers-init";

# initialization
include "error-pages";
include "sanitize-request";
include "initialize-transaction-state";
include "geoip-homepage-briefing-map";
include "frame-buster";
include "auth-headers";
include "test-suite-force-miss";
include "log-purge";
include "privacy";

# the following files contain routes for the backends defined above
include "route-backend-health-report"; # service that reports health of defined backends
include "route-default";

include "route-zone-apex-redirect";
include "route-geoip";
include "route-fastly-healthcheck";
include "route-esi-jsonp-callback";
include "route-cms-static-assets";
include "route-ads-static-assets";
include "route-search-suggest-svc";
include "route-switchboard";
include "route-collections-svc";
include "route-add-svc";
include "route-community-svc";
include "route-messaging";
include "route-sitemap";
include "route-recommendations";
include "route-newsdev-cloud-functions";
include "route-games";
include "route-profile-fe";
include "route-adx";
include "route-intl";
include "route-elections";
include "route-content-api";
include "route-tbooks";
include "route-newsdev-gcs";
include "route-mwcm";
include "route-programs";
include "route-times-journeys";
include "route-guides";
include "route-newsdev-attribute";
include "route-newsdev-gke";
include "route-watching";
include "route-video";
include "route-real-estate";
include "route-nyt5-misc";
include "route-userinfo";
include "route-newsroom-files-gcs";
include "route-tips-html-gcs";
include "route-newsgraphics-gcs";
include "route-newsletters";
include "route-weddings";
include "route-search";
include "route-timeswire";
include "route-interactive";
include "route-vi-assets";
include "route-homepage";
include "route-story";
include "route-collection";
include "route-paidpost";
include "route-blogs";
include "route-slideshow";
include "route-invalid-requests";
include "route-gdpr-form";
include "route-audio";
include "route-ask";
include "route-device-detection-debug";
include "route-trending";
include "route-get-started";
include "route-code";
include "route-vi-static-backup-gcs";
include "route-alpha";

# backend response processing
include "surrogate-key";
include "origin-response-handler";
include "origin-request-handler";
include "set-cache-object-ttl";

# begin other logic
include "abra";
include "https-redirect";
include "agent-id";
include "gdpr";
include "response-headers";
include "geo-identifier";

sub vcl_recv {

  # check to see if this request is from a shield pop of the same service service_id
  # retain the x-nyt-shield-auth header if it is
  call recv_shield_request_authorization;

  # determine the environment based on hostname
  call recv_determine_env_from_host;

  # returns vcl version, needs to be before the access check
  call shared_recv_vcl_version;

  # the following two calls restrict access levels to dev/stg and also provide
  # validated clients with NYHQ access priviledge for debug headers
  # TODO: break this into two headers
  # do not restrict this request if this is a shield request from an edge pop
  if (!req.http.x-nyt-shield-auth) {
    # what level of access does this user have based on ACL and/or auth headers
    call shared_recv_set_access_level;

    # block the request if the user does not have access to the environment
    call shared_recv_restrict_access;
  }

  # remove known invalid patterns from client request
  call recv_sanitize_request;

  # set up a few state vars reflecting the request structure
  call recv_set_canonical_www_host_var;
  call recv_set_canonical_alpha_host_var;
  call recv_capture_cookie_values;

  # set misc state vars (no use in creating 15 more subs)
  call recv_initialize_transaction_state;

  # initializes the device detection header
  call shared_recv_device_detection_init;

  # initialize geo ip headers only on the edge
  if (!req.http.x-nyt-shield-auth) {
    call shared_recv_geoip_headers_init;
  }

  # calling the GDPR setup prior to routes to capture cookie and
  # query params prior to potentially being stripped by a route
  # do not perform gdpr logic on the shield
  if (!req.http.x-nyt-shield-auth) {
    call recv_gdpr;
  }
  call recv_route_svc_gdpr;
  call recv_route_svc_amp_gdpr;

  # each route needs a separate route-<semantic-name>.vcl file with a recv_route_<semantic_name> sub
  call recv_route_backend_health_report;
  call recv_route_fastly_healthcheck;
  call recv_route_esi_jsonp_callback;
  call recv_route_cms_static_assets;
  call recv_route_ads_static_assets;
  call recv_route_geoip_svc;
  call recv_route_search_suggest_svc;
  call recv_route_switchboard;
  call recv_route_collections_svc;
  call recv_route_community_svc;
  call recv_route_messaging;
  call recv_route_add_svc;
  call recv_route_sitemap;
  call recv_route_recommendations;
  call recv_route_games;
  call recv_route_profile_fe;
  call recv_route_adx;
  call recv_route_intl;
  call recv_route_elections;
  call recv_route_tbooks;
  call recv_route_content_api;
  call recv_route_mwcm;
  call recv_route_programs;
  call recv_route_times_journeys;
  call recv_route_guides;
  call recv_route_video;
  call recv_route_real_estate;
  call recv_route_trending;
  call recv_route_best_sellers;
  call recv_route_userinfo;
  call recv_route_newsroom_files_gcs;
  call recv_route_newsgraphics_gcs;
  call recv_route_tips_html_gcs;
  call recv_route_newsletters;
  call recv_route_paidpost;
  call recv_route_weddings;
  call recv_route_search;
  call recv_route_timeswire;
  call recv_route_gdpr_form;
  call recv_route_interactive;
  call recv_route_blogs;
  call recv_route_vi_assets;
  call recv_route_collection;
  call recv_route_diningmap;
  call recv_route_slideshow;
  call recv_route_homepage;
  call recv_route_audio;
  call recv_route_ask;
  call recv_route_device_detection_debug;
  call recv_route_get_started;
  call recv_route_code;

  # order matters for these routes that are all using ^/year/mo/day
  call recv_route_story;
  call recv_route_amp;
  call recv_route_watching; # this needs to come AFTER article routing since it uses ^/year/mo/day

  # call preview route after story
  call recv_route_alpha;

  # WARNING THIS ORDER MUST BE PRESERVED FOR NEWSDEV ROUTES
  call recv_route_newsdev_gcs;
  call recv_route_newsdev_gke;              # contains sub route of recv_route_newsdev_gcs
  call recv_route_newsdev_cloud_functions;  # contains sub route of recv_route_newsdev_gke
  call recv_route_newsdev_attribute;        # contains sub route of recv_route_newsdev_gke
  # WARNING THIS ORDER MUST BE PRESERVED FOR NEWSDEV ROUTES

  # adding the zone apex redirect last
  # there is logic in some of the above routes that needs to execute
  # before the zone apex redirect
  call recv_route_zone_apex_redirect;

  ##################################################
  # DO NOT PUT YOUR ROUTE SUB CALL BELOW THIS LINE #
  ##################################################

  # if none of the above routes matched, we will go to the default backend
  if (!req.http.x-nyt-route || !req.http.x-nyt-backend) {
    call recv_set_default_backend;
  }

  # at this point all routing decisions should be final
  # first check to see if we should redirect https<->http
  # do not perform https redirects on the shield
  if (!req.http.x-nyt-shield-auth) {
    call recv_https_redirect;
  }

/* any recv/request functionality defined in terraform
 * as well as anything Fastly needs to do magically
 * will be inserted by the below macro
 * be aware of this for the above functionality that is executed
 * make sure all backends in terraform have backend-name conditionals!
 * backends will be set WITHIN THIS MACRO
 */

# DO NOT REMOVE THIS LINE, FASTLY MACRO
#FASTLY recv

  # check to see if the client asked for a cache miss
  # the test suite does this
  call recv_test_suite_force_miss;

  # set the edge cdn identification header for origins
  set req.http.x-nyt-edge-cdn = "Fastly";

  call recv_route_uncachable_methods;
  call recv_route_invalid_urls;

  # We do not yet allow cache if there is an Authorization header
  if (req.http.Authorization) {
    set req.http.var-nyt-force-pass = "true";
  }

  # removing because Symfony2 (PHP framework) Request object will use this for getUri() if present
  if (req.http.X-Original-Url) {
    unset req.http.X-Original-Url;
  }

  # on the shield pop, do not honor stale-while-revalidate
  if (req.http.x-nyt-shield-auth) {
    set req.max_stale_while_revalidate = 0s;
  }

  # set a tracking var to denote if this req is going to a shield
  if (req.backend.is_shield) {
    set req.http.var-nyt-is-shielded = "true";
  } else {
    unset req.http.var-nyt-is-shielded;
  }

  # sort the querystring just to be sure we optimize cache
  set req.url = querystring.sort(req.url);

  # log any purge request that came in
  if (req.request == "FASTLYPURGE" || req.request == "PURGE") {
      call recv_sumologic_purge_log_line;
  }

  # if the route did not specifically ask for a pass we will do a lookup
  if (req.http.var-nyt-force-pass == "true") {
    return(pass);
  } else {
    return(lookup);
  }
}

sub vcl_hash {
#FASTLY hash

# WARNING: DO NOT modify this block of code below UNLESS you know what you are doing
# ------------------------------
  set req.hash += req.url;
  set req.hash += req.http.host;
# ------------------------------

  call hash_route_video;
  call hash_route_slideshow;
  call hash_route_collection;
  call hash_route_homepage;
  call hash_route_story;
  call hash_route_alpha;

  return(hash);
}

sub vcl_hit {
#FASTLY hit

  if (!obj.cacheable) {
    return(pass);
  }
  return(deliver);
}

sub vcl_miss {
#FASTLY miss

  # send signed requests to shield pops
  call miss_pass_shield_request_signing;

  # route specific miss logic goes here
  # contained in route-<semantic-name>.vcl, named miss_pass_route_<semantic_name>
  call miss_pass_route_cms_static_assets;
  call miss_pass_route_ads_static_assets;
  call miss_pass_route_community_svc;
  call miss_pass_route_sitemap;
  call miss_pass_route_search_suggest;
  call miss_pass_route_newsdev_cloud_functions;
  call miss_pass_route_games;
  call miss_pass_route_profile_fe;
  call miss_pass_route_adx;
  call miss_pass_route_elections;
  call miss_pass_route_programs;
  call miss_pass_route_guides;
  call miss_pass_route_tbooks;
  call miss_pass_route_content_api;
  call miss_pass_route_newsdev_gcs;
  call miss_pass_route_times_journeys;
  call miss_pass_route_newsdev_attribute;
  call miss_pass_route_video;
  call miss_pass_wf_auth_headers;
  call miss_pass_route_newsroom_files_gcs;
  call miss_pass_route_newsgraphics_gcs;
  call miss_pass_route_tips_html_gcs;
  call miss_pass_route_vi_assets;
  call miss_pass_route_switchboard;
  call miss_pass_route_blogs;
  call miss_pass_route_amp;
  call miss_pass_route_add_svc;
  call miss_pass_route_intl;
  call miss_pass_route_real_estate;
  call miss_pass_route_nyt5_misc;
  call miss_pass_route_newsletters;
  call miss_pass_route_paidpost;
  call miss_pass_route_weddings;
  call miss_pass_route_ask;
  call miss_pass_route_search;
  call miss_pass_route_timeswire;
  call miss_pass_route_trending;
  call miss_pass_route_interactive;
  call miss_pass_route_collection;
  call miss_pass_route_homepage;
  call miss_pass_route_story;
  call miss_pass_route_watching;
  call miss_pass_route_default_remove_cookie;
  call miss_pass_route_mwcm;
  call miss_pass_route_get_started;
  call miss_pass_route_code;
  call miss_pass_route_vi_static_backup_gcs;
  call miss_pass_route_recommendation;

  # unset headers to the origin that we use for vars
  # definitely need to do this last incase they are used above
  call miss_pass_unset_bereq_headers;

  return(fetch);
}

sub vcl_pass {
#FASTLY pass

  # send signed requests to shield pops
  call miss_pass_shield_request_signing;

  # route specific pass logic goes here
  # contained in route-<semantic-name>.vcl, named miss_pass_route_<semantic_name>
  call miss_pass_route_cms_static_assets;
  call miss_pass_route_ads_static_assets;
  call miss_pass_route_community_svc;
  call miss_pass_route_sitemap;
  call miss_pass_route_search_suggest;
  call miss_pass_route_newsdev_cloud_functions;
  call miss_pass_route_games;
  call miss_pass_route_profile_fe;
  call miss_pass_route_adx;
  call miss_pass_route_elections;
  call miss_pass_route_programs;
  call miss_pass_route_tbooks;
  call miss_pass_route_content_api;
  call miss_pass_route_newsdev_gcs;
  call miss_pass_route_times_journeys;
  call miss_pass_route_newsdev_attribute;
  call miss_pass_route_video;
  call miss_pass_wf_auth_headers;
  call miss_pass_route_newsroom_files_gcs;
  call miss_pass_route_newsgraphics_gcs;
  call miss_pass_route_tips_html_gcs;
  call miss_pass_route_vi_assets;
  call miss_pass_route_switchboard;
  call miss_pass_route_blogs;
  call miss_pass_route_amp;
  call miss_pass_route_add_svc;
  call miss_pass_route_intl;
  call miss_pass_route_real_estate;
  call miss_pass_route_nyt5_misc;
  call miss_pass_route_newsletters;
  call miss_pass_route_paidpost;
  call miss_pass_route_weddings;
  call miss_pass_route_ask;
  call miss_pass_route_search;
  call miss_pass_route_timeswire;
  call miss_pass_route_interactive;
  call miss_pass_route_collection;
  call miss_pass_route_homepage;
  call miss_pass_route_story;
  call miss_pass_route_watching;
  call miss_pass_route_default_remove_cookie;
  call miss_pass_route_mwcm;
  call miss_pass_route_trending;
  call miss_pass_route_get_started;
  call miss_pass_route_code;
  call miss_pass_route_vi_static_backup_gcs;

  # unset headers to the origin that we use for vars
  # definitely need to do this last incase they are used above
  call miss_pass_unset_bereq_headers;
}

sub vcl_fetch {

  # if the static backup is enabled,
  # check that before handling 5xx errors
  call fetch_route_vi_static_backup_gcs;

  # handle 5xx errors from the backend
  call fetch_deliver_stale_on_error;

  # it's probably best to put route specific fetch logic here
  # for instance fetch_route_newsdev_gcs overrides stale-while-revalidate
  # in which the override is checked in fetch_set_stale_content_controls
  # also fetch_route_community_svc needs to run before the fastly fetch macro
  call fetch_elections_redirect;
  call fetch_route_newsdev_gke;
  call fetch_route_newsdev_gcs;
  call fetch_route_elections;
  call fetch_route_community_svc;
  call fetch_route_intl_headers;
  call fetch_route_newsgraphics_gcs;
  call fetch_route_story;
  call fetch_route_interactive;
  call fetch_route_collection;
  call fetch_route_alpha;

  # set surrogate key header properly
  call fetch_surrogate_key_handler;

  # set serve stale content cache object parameters
  call fetch_set_stale_content_controls;

  # DO NOT REMOVE THE NEXT LINE - FASTY SPECIFIC MACRO
#FASTLY fetch

  # moved the next two blocks up the chain
  # these running earlier is faster
  if (beresp.http.X-Is-NYT4) {
    set beresp.http.x-nyt-restart-reason = "X-Is-NYT4";
  }

  # Vary on this header for HTTPS version, so we can purge both versions at the same time
  if (beresp.http.Vary && beresp.http.Vary !~ "Fastly-SSL") {
    set beresp.http.Vary = beresp.http.Vary ", Fastly-SSL";
  } else if (!beresp.http.Vary) {
    set beresp.http.Vary = "Fastly-SSL";
  }

  # hacky, TODO: fix the backends
  # legacy cacheable content should not be private
  if (req.http.x-nyt-route == "legacy-cacheable" && beresp.http.Cache-Control ~ "private") {
    unset beresp.http.Cache-Control;
  }

  set beresp.http.X-Origin-Time = strftime({"%F %T UTC"}, now);

  # Fastly is now controlling nyt-a, if anyone else tries to set it, stop them
  # we are also going to remove set-cookie if RMID is there, no one is using it anymore
  # unfortunately this is sloppy but we do not have much choice
  # TODO: Backends stop setting nyt-a and RMID cookies
  if (req.url !~ "^/adx") {
    if (setcookie.get_value_by_name(beresp,"nyt-a") || setcookie.get_value_by_name(beresp,"RMID")) {
      unset beresp.http.Set-Cookie;
    }
  }

  if (req.restarts > 0) {
    set beresp.http.Fastly-Restarts = req.restarts;
  }

  if (beresp.http.Set-Cookie) {
    set req.http.Fastly-Cachetype = "SETCOOKIE";
    return(pass);
  }

  if (beresp.http.Cache-Control ~ "private") {
    set req.http.Fastly-Cachetype = "PRIVATE";
    return(pass);
  }

  # set the cache TTL of the object
  call fetch_set_cache_object_ttl;

  return(deliver);
}

sub vcl_deliver {
#FASTLY deliver

  # set the agent id (nyt-a cookie):
  call deliver_set_agent_id_cookie;

  if (resp.http.x-nyt-restart-reason) {
    set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " " + resp.http.x-nyt-restart-reason, resp.http.x-nyt-restart-reason);
    return(restart);
  }

  call deliver_route_story_restart_indicators;
  call deliver_route_collection_restart_indicators;

  call deliver_enable_privacy;
  call deliver_add_svc_access_control;
  call deliver_route_newsdev_cloud_functions_access_control;
  call deliver_games_api_version;
  call deliver_profile_fe_api_version;
  call deliver_elections_api_version;
  call deliver_tbooks_api_version;
  call deliver_route_mwcm;
  call deliver_programs_api_version;
  call deliver_times_journeys_api_version;
  call deliver_watching_api_version;
  call deliver_video_api_version;
  call deliver_route_elections_gcs_error;
  call deliver_route_newsdev_gcs_error;
  call deliver_route_newsgraphics_gcs_error;
  call deliver_route_vi_assets_access_control;
  call deliver_route_alpha;

  # logic executed only on the edge in a shielding scenario
  if (!req.http.x-nyt-shield-auth) {
    #gdpr
    call deliver_gdpr;
    call deliver_route_story_us_cookie;
    call deliver_route_newsletters_us_cookie;
    call deliver_geo_cookie;

    # control when our content is allowed to be framed
    call deliver_frame_buster;
  }

  # set other response headers
  call deliver_response_headers;
  call deliver_debug_response_headers;
  call deliver_homepage_set_debug_header;
  call shared_deliver_geoip_response_headers;
  call shared_deliver_device_detection_header;

  # slideshow incompatbility fallback
  call deliver_slideshow_fallback;

  return(deliver);
}

sub vcl_error {
  # this should execute before any other backend route vcl_error logic
  call error_init_health_vars;
#FASTLY error

  # call subs here that are handling custom error codes
  # please add the error code(s) to the sub names
  # these must be >= 600 and <= 999
  call shared_error_vcl_version; # error 710 for fastly vcl version catch
  call error_755_amp_redirect;
  call error_770_perform_301_redirect; # e.x. "error 770 <absolute_url>"
  call error_771_perform_302_redirect; # e.x. "error 771 <absolute_url>"
  call error_800_fastly_healthcheck;
  call error_848_device_detection_debug;
  call error_900_route_esi_jsonp_callback;
  call error_901_to_906_route_userinfo;
  call error_918_amp_gdpr;
  call error_919_gdpr;
  call error_949_geo_debug_svc;
  call error_995_route_backend_health_report;

  # handle 5xx errors if the error handler was called
  # with a 500-599 code
  if (obj.status >= 500 && obj.status < 600) {

    # deliver stale object if it is available
    if (stale.exists) {
      return(deliver_stale);
    }

    call render_50x_page;

    return(deliver);
  }

}

sub vcl_log {
#FASTLY log

}
