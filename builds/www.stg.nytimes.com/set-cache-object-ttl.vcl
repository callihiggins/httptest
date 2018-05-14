# this sub sets the cache TTL if the object is cacheable
#
# The best way to control cache is to properly implement response headers
# for this purpose in your origin application. This is the OFFICIAL way to do it.
# If you don't want fastly to cache something, return Cache-Control: private
#
# TTL is set in the following order of preference, which is repeated in the conditional.
# 1. X-VarnishCacheDuration header, DO NOT USE THIS FOR NEW IMPLEMENTATIONS, IF YOU ARE USING IT STOP DOING IT
#
# 2. Surrogate-Control header max-age attribute (this will be removed from client response)
# 3. Cache-Control header s-maxage (Only Fastly honors, is not removed from client response)
# 4. Cache-Control header max-age (Browser and downstream cache will also honor this)
# 5. Expires header
#
# 6. default overrides, would like to use #2-5 and abandon these at some point, requires collaboration
#    a. this uses header var set within the route as shown in the conditional
# 7. default TTL if everything else falls through, this is just for sanity protection for origins
#    a. 5xx = 3s
#    b. 4xx = 5s
#    c. everything else = 60s

sub fetch_set_cache_object_ttl {

  if (beresp.http.X-VarnishCacheDuration) {
    # NYT custom header
    # TODO: DEPRECATED - DO NOT USE THIS FOR NEW IMPLEMENTATIONS
    set beresp.ttl = std.atoi(beresp.http.X-VarnishCacheDuration);
  } else if (    beresp.http.Expires
              || beresp.http.Surrogate-Control ~ "max-age"
              || beresp.http.Cache-Control ~ "(s-maxage|max-age)"
              || beresp.http.x-amz-meta-surrogate-control ~ "max-age" ) {
    #    These are the OFFICIAL STANDARD
    #    Fastly will adhere to these automatically, no logic is required here
    #    Fastly honors these in the following priority order
    # 1. Surrogate-Control header max-age (this will be removed from client response)
    # 2. Cache-Control header s-maxage (Only Fastly honors, is not removed from client response)
    # 3. Cache-Control header max-age (Browser and downstream cache will also honor this)
    # 4. Expires header
  } else {

    # TODO: remove these override conditionals when origins implement one of the above OFFICIAL standrds

    # these overrides, obviously, only override the default ttls
    # standard headers still supercede these (above)
    # first copy req into beresp. Some routes use req, some use beresp.
    # if both are set for some reason, beresp will take precedence
    if (req.http.x-nyt-ttl-override && !beresp.http.x-nyt-ttl-override) {
      set beresp.http.x-nyt-ttl-override = req.http.x-nyt-ttl-override;
    }

    # overrides only hold true for any response code less than 400
    if (beresp.http.x-nyt-ttl-override && beresp.status < 400) {
      set beresp.ttl = std.atoi(beresp.http.x-nyt-ttl-override);
    } else {
      # this is the catch-all default TTL if the object is cacheable and does none of the above
      # we do this to protect the origins from themselves if they don't do anything to control cache
      # or if the defaults we provide are sufficient for thier application's needs
      # 5xx's get 3s (this is just heere in the case the error page wasn't rendered above)
      # 4xx's get 5s 
      # everything else gets 60s
      if (beresp.status >= 500) {
        set beresp.ttl = 3s;
      } else if (beresp.status >= 400) {
        set beresp.ttl = 5s;
      } else {
        set beresp.ttl = 60s;
      }
    }
  }
}
