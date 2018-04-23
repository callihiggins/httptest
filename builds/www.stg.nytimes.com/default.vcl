include "acl-internal";
include "acl-vpc-gateway";
include "acl-external-staging-access";
include "acl-crawlers";
include "acl-blacklist";
include "acl-fastly";
include "error-pages";
include "sanitize-url";
include "normalize-url";
include "access-level-authorization";
include "initialize-vars";
include "geoip-timezone-map-table";
include "geoip-location-consolidation-map-table";
include "geoip-service";
include "frame-buster";
include "health-check";
include "ipauth";
include "www-redirect";
include "tips";
include "migration-allocation";
include "auth-headers";

# this adds vcl_error logic for logging purposes
include "backend-init-vars";


# the following files contain routes for the backends defined above
include "route-health-service"; # service that reports health of defined backends
include "backends-main";

# new style routing includes
# TODO: replace all of the above with these during refactor
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
include "route-content-api"
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
include "route-newsgraphics-gcs";
include "route-newsletters";
include "route-weddings";
include "route-search";
include "route-timeswire";
include "route-interactive";
include "route-vi-assets";

# vi allocation and routing
# intentionally after other backend logic
include "vi-allocation";
include "backend-vi";

# backend response processing
include "surrogate-key";
include "origin-response-handler";
include "set-cache-object-ttl";

# begin other logic
include "https-redirect";
include "device-detect";
include "cookie";
include "querystring";
include "mobile-redirect";
include "homepage-redirect";
include "uuid";
include "gdpr";
include "response-headers";
# Slideshow fallback to legacy backend logic
include "route-slideshow";


sub vcl_recv {

  # begin routing logic
  # each route needs a separate route-<semantic-name>.vcl file with a recv_route_<semantic_name> sub
  call recv_route_esi_jsonp_callback;
  call recv_route_cms_static_assets;
  call recv_route_ads_static_assets;
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
  call recv_route_watching; # this needs to come AFTER article routing since it uses year/mo/day
  call recv_route_video;
  call recv_route_real_estate;
  call recv_route_trending;
  call recv_route_podcasts;
  call recv_route_best_sellers;
  call recv_route_diningmap;
  call recv_route_userinfo;
  call recv_route_newsroom_files_gcs;
  call recv_route_newsgraphics_gcs;
  call recv_route_newsletters;
  call recv_route_weddings;
  call recv_route_search;
  call recv_route_timeswire;
  call recv_route_interactive;
  call recv_route_vi_assets;
  call recv_route_slideshow;

  # WARNING THIS ORDER MUST BE PRESERVED FOR NEWSDEV ROUTES
  call recv_route_newsdev_gcs;
  call recv_route_newsdev_gke;              # contains sub route of recv_route_newsdev_gcs
  call recv_route_newsdev_cloud_functions;  # contains sub route of recv_route_newsdev_gke
  call recv_route_newsdev_attribute;        # contains sub route of recv_route_newsdev_gke
  # WARNING THIS ORDER MUST BE PRESERVED FOR NEWSDEV ROUTES

  call recv_gdpr;
  call recv_route_svc_gdpr;
  call recv_querystring;

  # at this point all routing decisions should be final
  # first check to see if we should redirect https<->http
  call recv_https_redirect;

/* any recv/request functionality defined in terraform
 * as well as anything Fastly needs to do magically
 * will be inserted by the below macro
 * be aware of this for the above functionality that is executed
 * make sure all backends in terraform have backend-name conditionals!
 * backends will be set WITHIN THIS MACRO
 *
 * WARNING, we are mid refactor the above is not 100% true yet
 * There be dragons here. Pay close attention to the test suite
 * There are tons of routes in vcl files with their own vcl_recv in the includes!!
 * Lets migrate them to route subs iteratively!
 */

# DO NOT REMOVE THIS LINE, FASTLY MACRO
#FASTLY recv

  # check to see if we need to remove the cookie header
  call recv_remove_cookie_check;

  # Set the edge req header
  set req.http.X-NYT-Edge-CDN = "Fastly";

  if (req.request != "HEAD" && req.request != "GET" && req.request != "FASTLYPURGE") {
    set req.http.x-nyt-force-pass = "true";
  }

  // URIs not accessible via Varnish VIPs
  if (   req.url ~ "^/svc/web-shell/"
      || req.url ~ "^/svc/web-products/shell/"
      || req.url ~ "^/apc-stats/"
      || req.url ~ "^/phpinfo/"
      || req.url ~ "\.php$"
  ) {
      set req.url = "/404.html";
  }

  if (req.http.Authorization || req.http.Cookie) {
    /* Not cacheable by default */
    set req.http.x-nyt-force-pass = "true";
    #return(pass);
  }

  // removing because Symfony2 Request object will use this for getUri() if present
  if (req.http.X-Original-Url) {
    remove req.http.X-Original-Url;
  }

  # if the route didn't specifically ask for a pass we will do a lookup
  if (req.http.x-nyt-force-pass == "true") {
    return(pass);
  } else {
    return(lookup);
  }
}

sub vcl_hash {
#FASTLY hash
  set req.hash += req.url;
  set req.hash += req.http.host;

  call hash_route_video;
  call hash_route_slideshow;
  call hash_route_watching;

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

  // this should be removed already, but lets be sure
  // since this was a lookup we were not pass
  remove bereq.http.Cookie;

  // collapse X-Cookie unset for article, collection,slideshow,homepage,paidpost and misc
  if(    req.http.X-PageType == "article"
      || req.http.X-PageType == "collection"
      || req.http.X-PageType == "slideshow"
      || req.http.X-PageType == "homepage"
      || req.http.X-PageType == "paidpost"
      || req.http.X-PageType == "trending"
      || req.http.X-PageType == "podcasts"
      || req.http.X-PageType == "bestseller"
  ){
    unset bereq.http.X-Cookie;
  }

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
  call miss_pass_route_tbooks;
  call miss_pass_route_content_api;
  call miss_pass_route_newsdev_gcs;
  call miss_pass_route_times_journeys;
  call miss_pass_route_health_service;
  call miss_pass_route_newsdev_attribute;
  call miss_pass_route_video;
  call miss_pass_wf_auth_headers;
  call miss_pass_route_newsroom_files_gcs;
  call miss_pass_route_newsgraphics_gcs;
  call miss_pass_route_vi_assets;

  # unset headers to the origin that we use for vars
  # definitely need to do this last incase they are used above
  call unset_extraneous_bereq_headers;

  return(fetch);
}


sub vcl_pass {
#FASTLY pass

  // collapse X-Cookie unset for article, collection,slideshow,homepage,paidpost and misc
  if(    req.http.X-PageType == "article"
      || req.http.X-PageType == "collection"
      || req.http.X-PageType == "slideshow"
      || req.http.X-PageType == "homepage"
      || req.http.X-PageType == "paidpost"
      || req.http.X-PageType == "trending"
      || req.http.X-PageType == "podcasts"
      || req.http.X-PageType == "bestseller"
  ){
    unset bereq.http.Cookie;
    unset bereq.http.X-Cookie;
  }

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
  call miss_pass_route_health_service;
  call miss_pass_route_newsdev_attribute;
  call miss_pass_route_video;
  call miss_pass_wf_auth_headers;
  call miss_pass_route_newsroom_files_gcs;
  call miss_pass_route_newsgraphics_gcs;
  call miss_pass_route_vi_assets;

  # unset headers to the origin that we use for vars
  # definitely need to do this last incase they are used above
  call unset_extraneous_bereq_headers;
}


sub vcl_fetch {


  # handle 5xx errors from the backend
  call fetch_deliver_stale_on_error;

  # it's probably best to put route specific fetch logic here
  # for instance fetch_route_newsdev_gcs overrides stale-while-revalidate
  # in which the override is checked in fetch_set_stale_content_controls
  # also fetch_route_community_svc needs to run before the fastly fetch macro
  call fetch_elections_redirect;
  call fetch_route_newsdev_gke;
  call fetch_route_newsdev_gcs;
  call fetch_route_content_api;
  call fetch_route_community_svc;
  call fetch_route_intl_headers;
  call fetch_route_newsgraphics_gcs;

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
  if (beresp.http.Vary) {
    set beresp.http.Vary = beresp.http.Vary ", Fastly-SSL";
  } else {
    set beresp.http.Vary = "Fastly-SSL";
  }

  # hacky, TODO: fix the backends
  # legacy cacheable content should not be private
  if(req.http.X-PageType == "legacy-cacheable" && beresp.http.Cache-Control ~ "private"){
    unset beresp.http.Cache-Control;
  }

  set beresp.http.X-Origin-Time = strftime({"%F %T UTC"}, now);

  # Fastly is now controlling nyt-a, if anyone else tries to set it, stop them
  # we are also going to remove set-cookie if RMID is there, no one is using it anymore
  # unfortunately this is sloppy but we do not have much choice
  # TODO: Backends stop setting nyt-a and RMID cookies
  if(req.url !~ "^/adx") {
    if(setcookie.get_value_by_name(beresp,"nyt-a") || setcookie.get_value_by_name(beresp,"RMID")){
      remove beresp.http.Set-Cookie;
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

  if (resp.http.x-nyt-restart-reason) {
    set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " " + resp.http.x-nyt-restart-reason, resp.http.x-nyt-restart-reason);
    return(restart);
  }

  call deliver_add_svc_access_control;
  call deliver_route_newsdev_cloud_functions_access_control;
  call deliver_games_api_version;
  call deliver_profile_fe_api_version;
  call deliver_adx_static_api_version;
  call deliver_elections_api_version;
  call deliver_tbooks_api_version;
  call deliver_content_api_version;
  call deliver_route_mwcm;
  call deliver_programs_api_version;
  call deliver_times_journeys_api_version;
  call deliver_watching_api_version;
  call deliver_video_api_version;

  # set response headers
  call deliver_gdpr;
  call deliver_response_headers;
  call deliver_slideshow_fallback;

  return(deliver);
}

sub vcl_error {
#FASTLY error

  call error_770_perform_301_redirect; # e.x. "error 770 <absolute_url>"
  call error_900_route_esi_jsonp_callback;
  call error_995_route_health_service;
  call error_901_to_906_route_userinfo;
  call error_919_gdpr;

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

    # selectively log some services
    # log 5xx status ALWAYS
    # log everything in dev and stg
    if (
           (req.url !~ "^/svc/(web-products|comscore)" && req.url !~ "^/adx/")
        || resp.status >= 500
        || req.http.x-environment != "prd"
       ) {

      log {"syslog "} + req.service_id + {" "} + req.http.x-nyt-logger-name + {" :: "}
      req.http.Fastly-Client-IP
      {" "-" "-" "}
      {"["} strftime({"%d/%b/%Y:%H:%M:%S %z"}, time.start) {"]"}
      {" "} cstr_escape(req.http.host)
      {" ""} cstr_escape(req.request) " " cstr_escape(req.url) " " cstr_escape(req.proto) {"""}
      {" "} resp.status
      {" "} regsub(resp.body_bytes_written, "^0$", {""-""})
      {" ""} cstr_escape(req.http.referer) {"""}
      {"" ""} cstr_escape(req.http.user-agent) {"""}
      {" backend=["} if(req.http.x-nyt-backend,req.http.x-nyt-backend,"-") {"]"}
      {" pagetype=["} if(resp.http.X-PageType,resp.http.X-PageType,"-") {"]"}
      {" apiversion=["} if(resp.http.X-API-Version,resp.http.X-API-Version,"-") {"]"}
      {" cachetype=["} if(fastly_info.state,fastly_info.state,"-") {"]"}
      {" reqtime=["} time.elapsed {"]"}
      {" reqsize=["} req.bytes_read {"]"}
      {" protocol=["} if(req.http.Fastly-SSL,"https","http") {"]"}
      {" behealth=["} if(req.http.x-nyt-backend-health,req.http.x-nyt-backend-health,"-") {"]"}
      {" vialloc=["} if(req.http.x--fastly-project-vi,"1","0") {"]"}
      if(resp.http.Fastly-Restarts, {" restarts=["} resp.http.Fastly-Restarts {"]"},"")
      if(req.http.x-nyt-restart-reason,{" restart_reason=["} req.http.x-nyt-restart-reason {"]"}, "")
      if(req.http.x-redirect-reason, {" "} + req.http.x-redirect-reason, "")
      if(req.http.x-vi-health, {" "} + req.http.x-vi-health, "");
    }
  }

sub unset_extraneous_bereq_headers {
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
}
