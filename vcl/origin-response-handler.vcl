# This logic will handle serving stale content if we got an error from the backend
sub fetch_deliver_stale_on_error {

  if ( (beresp.status >= 500 && beresp.status < 600) ||
       (req.http.var-nyt-4xx-serve-stale == "true" && beresp.status >= 400 && beresp.status < 500) ) {

      # Deliver stale if the object is available
      if (stale.exists) {
        return(deliver_stale);
      }

      # logic to retry the transaction
      # routes can set req.http.var-nyt-error-retry to false to disable this
      if (   req.restarts <= 1
          && req.http.var-nyt-error-retry != "false"
          && (req.request == "GET" || req.request == "HEAD")
          ) {
        set beresp.http.x-nyt-restart-reason = beresp.status + " retry";
      }

      set req.http.Fastly-Cachetype = "ERROR";

      /*
        we got an error and we already restarted at least once, time to bail
        return a pretty error page if the requested page was an html page
        assuming ending in .html or "/" is good enough here.
        otherwise lets just return the default Fastly page
        Doing this to limit what gets a large error page download
      */

      if ( req.restarts >= 2
           && (req.url.path ~ ".html$" || req.url.path ~ "/$")
           && (req.url.path !~ "^/svc" && req.url.path !~ "^/adx")
          ) {
        error beresp.status;
      }

  }
}

# if we did not get an error from the backend, set stale content handling headers
# per https://tools.ietf.org/html/rfc5861
sub fetch_set_stale_content_controls {

  if (beresp.status < 500) {

    # first check if stale-if-error is in a cache control header
    if (beresp.http.Cache-Control !~ "stale-if-error" && beresp.http.Surrogate-Control !~ "stale-if-error") {
      # if not set in cache control, check for an override in the route
      if(beresp.http.x-nyt-stale-if-error){
        set beresp.stale_if_error = std.atoi(beresp.http.x-nyt-stale-if-error);
      } else {
        # default is 1 day
        set beresp.stale_if_error = 86400s;
      }
    }

    # first check if stale-while-revlidate is in a cache control header
    if (beresp.http.Cache-Control !~ "stale-while-revalidate" && beresp.http.Surrogate-Control !~ "stale-while-revalidate") {
      # if not set in cache control, check for an override in the route
      if(beresp.http.x-nyt-stale-while-revalidate){
        set beresp.stale_while_revalidate = std.atoi(beresp.http.x-nyt-stale-while-revalidate);
      } else {
        # default is 60 seconds
        set beresp.stale_while_revalidate = 1200s;
      }
    }
  }

  # clean up any potential override headers
  unset beresp.http.x-nyt-stale-while-revalidate;
  unset beresp.http.x-nyt-stale-if-error;
}

sub error_init_health_vars {
  # based on some fastly documentation it looks like
  # the response always has the string "healthy" when
  # we entered vcl_error because the backend was unhealthy
  # lets set a header var we can capture and log / return
  if(std.tolower(obj.response) ~ "healthy"){
    set obj.http.x-nyt-backend-health = "0";
  } else {
    set obj.http.x-nyt-backend-health = "1";
  }
}

sub fetch_fix_cache_control_for_vi_shield {
  # this logic fixes a fastly bug with conditional repsonses (304) with regard to
  # how those are processed when only Surrogate-Control exists with a max-age directive
  # and the backend is configured with a shield

  declare local var.max_age STRING;

  # extract max-age value from Surrogate-Control and apply it to Cache-Control as s-maxage
  # only do this if s-maxage does not exist in Cache-Control
  if (req.http.x-nyt-backend ~ "^projectvi_fe" && beresp.http.cache-control !~ "s-maxage=[0-9]+") {

    # try to capture the max-age value, the entire string is returned if capture group does not match
    set var.max_age = regsub(beresp.http.surrogate-control, ".*max-age=([0-9]+).*", "\1");

    # if the value was captured add it to Cache-Control as s-maxage
    if (var.max_age != beresp.http.surrogate-control) {
      set beresp.http.cache-control = "s-maxage=" + var.max_age + "," + beresp.http.cache-control;
    }
  }
}
