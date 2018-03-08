include "acl-internal";
include "acl-vpc-gateway";
include "acl-external-staging-access";
include "acl-crawlers";
include "acl-blacklist";
include "error-pages";
include "sanitize-url";
include "normalize-url";
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
include "cloud-storage-bucket-headers";

# the following files define the backends themselves
# these are almost obsolete, nearly all backends are in terraform now
include "backends-dev";
include "backends-stg";
include "backends-prd";
# end defining backends

# this adds vcl_error logic for logging purposes
include "backend-init-vars";


# the following files contain routes for the backends defined above
include "backend-health-service"; # service that reports health of defined backends
include "backends-main";
include "backend-well";
include "backend-elections";
include "backend-newsdev-gke";
include "backend-newsdev-gcs";
include "backend-newsroom-files-gcs";
include "backend-newsgraphics-gcs";
include "backend-newsdev-attribute";
include "backend-intl";
include "backend-watching";
include "backend-games";
include "backend-programs";
include "backend-weddings-api";
include "backend-mwcm";
include "backend-content-api";
include "backend-times-journeys";
include "backend-video";
include "backend-tbooks";
include "backend-adx-static";

# new style routing includes
# TODO: replace all of the above with these during refactor
include "route-cms-static-assets";
include "route-ads-static-assets";
include "route-collections-svc";
include "route-sitemap";
include "backend-profile-fe";

# vi allocation and routing
# intentionally after other backend logic
include "vi-allocation";
include "backend-vi";

# backend response processing
include "surrogate-key";
include "origin-response-handler";
include "set-cache-object-ttl";

# begin other logic
include "community-esi";
include "https-redirect";
include "device-detect";
include "cookie";
include "userinfo";
include "querystring";
include "mobile-redirect";
include "homepage-redirect";
include "uuid";
include "response-headers";
# GKE fallback to NYT4 logic
include "backend-nyt4-fallback";

sub vcl_recv {

  # initialize common functionalities here
  # TODO: move more things into this that are vcl_recv in intialize-vars.vcl
  call initialize_global_variable_headers;


  # begin routing logic
  # each route needs a separate route-<semantic-name>.vcl file with a recv_route_<semantic_name> sub
  call recv_route_cms_static_assets;
  call recv_route_ads_static_assets;
  call recv_route_collections_svc;
  call recv_route_sitemap;

/* any recv/request functionality defined in terraform
 * as well as anything Fastly needs to do magically
 * will be inserted by the below macro
 * be aware of this for the above functionality that is executed
 * make sure all backends in terraform have backend-name conditionals!
 * backends will be set WITHIN THIS MACRO
 *
 * WARNING, we are mid refactor the above is not 100% true yet
 * There be dragons here. Pay close attention to the test suite
 * There are tons of routes in vcl files with their own vcl_rev in the includes!!
 * Lets migrate them to route subs iteratively!
 */

# DO NOT REMOVE THIS LINE, FASTLY MACRO
#FASTLY recv

  # Set the edge req header
  set req.http.X-NYT-Edge-CDN = "Fastly";

  if (req.request != "HEAD" && req.request != "GET" && req.request != "FASTLYPURGE") {
    return(pass);
  }

  # this block assumes default legacy backend
  # we cannot cache legacy by default
  if (   req.backend == F_www
      || req.backend == F_www_https) {
    return(pass);
  }

  // URIs not accessible via Varnish VIPs
  if (   req.url ~ "^/svc/web-shell/"
      || req.url ~ "^/svc/web-products/shell/"
      || req.url ~ "^/apc-stats/"
      || req.url ~ "^/phpinfo/"
  ) {
      set req.url = "/404.html";
  }

  // remove the Authorization header for video-api calls
  // it is diabled and we will implement it in Fastly soon
  if(req.http.X-PageType == "video-api"){
    unset req.http.Authorization;
  }

  if (req.http.Authorization || req.http.Cookie) {
    /* Not cacheable by default */
    return(pass);
  }

  // removing because Symfony2 Request object will use this for getUri() if present
  if (req.http.X-Original-Url) {
      remove req.http.X-Original-Url;
  }

  return(lookup);
}

sub vcl_hash {
#FASTLY hash
  set req.hash += req.url;
  set req.hash += req.http.host;

  // video library needs to pivot on device type
  if(req.http.X-PageType == "video-library"){
    set req.hash += req.http.device_type;
  }

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
  // cacheable community svc requests are ESI jsonp
  // we can not compress these... yet...
  if(req.http.X-PageType == "community-svc-cacheable"){
    unset bereq.http.Accept-Encoding;
    unset req.http.Accept-Encoding;
  }

  # route specific miss logic goes here
  # contained in route-<semantic-name>.vcl, named miss_pass_route_<semantic_name>
  call miss_pass_route_cms_static_assets;
  call miss_pass_route_ads_static_assets;

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

  # unset headers to the origin that we use for vars
  # definitely need to do this last incase they are used above
  call unset_extraneous_bereq_headers;
}


sub vcl_fetch {

  # set surrogate key header properly
  call fetch_surrogate_key_handler;

  # handle 5xx errors from the backend
  call fetch_deliver_stale_on_error;

  # set serve stale content cache object parameters
  call fetch_set_stale_content_controls;

  # DO NOT REMOVE THE NEXT LINE - FASTY SPECIFIC MACRO
#FASTLY fetch

  # moved the next two blocks up the chain
  # these running earlier is faster
  if (beresp.http.X-Is-NYT4) {
    set req.http.X-Is-NYT4 = "1";
    return(restart);
  }

  # Vary on this header for HTTPS version, so we can purge both versions at the same time
  if (beresp.http.Vary) {
    set beresp.http.Vary = beresp.http.Vary ", Fastly-SSL";
  } else {
    set beresp.http.Vary = "Fastly-SSL";
  }

  # hacky, TODO: fix the backends
  # unset headers for cacheable community requests
  if (req.http.X-PageType == "community-svc-cacheable") {
    esi;
    unset beresp.http.Cache-Control;
    unset beresp.http.Pragma;
  }

  # hacky, TODO: fix the backends
  # legacy cacheable content should not be private
  if(req.http.X-PageType == "legacy-cacheable" && beresp.http.Cache-Control ~ "private"){
    unset beresp.http.Cache-Control;
  }

  set beresp.http.X-Origin-Time = strftime({"%F %T EDT"}, time.sub(now,4h));

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
  return(deliver);
}

sub vcl_error {
#FASTLY error

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

    # sumologic log
    # do not log services and adx requests unless they are a 5xx response, also always log in staging
    if ( (req.url !~ "^/svc/" && req.url !~ "^/adx/") || resp.status >= 500 || req.http.x-environment != "prd") {
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
      {" restarts=["} req.restarts {"]"}
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
}
