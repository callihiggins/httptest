sub recv_route_blogs {
  // blogs under WWW hostname
  if (req.http.var-nyt-canonical-www-host == "true") {
      if (   req.url ~  "^/news/"
          || req.url ~  "^/news$"
          || req.url ~  "^/politics/first-draft"
          || req.url ~  "^/times-insider"
          || req.url ~  "^/timesjourneys"
          || req.url ~  "^/live/"
          || req.url ~  "^/live$"
      ) {
          set req.http.x-nyt-route = "blog";
          set req.http.x-nyt-backend = "blogs";
          set req.http.var-nyt-send-gdpr = "true";
          // legacy urls
          if (   req.url ~ "^/timesjourneys"
              || req.url ~ "/live-updates/(json|text)/"
              || req.url ~ "/renderstyle/(phone|tablet)/"
              || req.url ~ "/wp-content/"
              || req.url ~ "/feed/"
              || req.url ~ "/xml"
              || req.url ~ "\.xml"
              || req.url ~ "/json/posts"
              || req.url ~ "/blogs\.json"
              || req.url ~ "/glassjson/"
              || req.url ~ "/papijson/"
              || req.http.X-QueryString ~ "nytapp=(.*)"
          ) {
              set req.http.x-nyt-route = "blog-legacy";
          }
      }
  }

  // vanity hostnames for blogs
  if (   req.http.host == "beta620.nytimes.com"
      || req.http.host == "bits.nytimes.com"
      || req.http.host ~  "(www\.)?dealbook\.com$"
      || req.http.host ~  "(www\.)?dealbook\.me$"
      || req.http.host ~  "jobs\.nytco\.com$"
  ) {
      set req.http.x-nyt-route = "blog-legacy";
      set req.http.x-nyt-backend = "blogs";
  }

  # now let us deal with the qparams for this route
  if (req.http.x-nyt-route ~ "^blog") {
    # WP-7352: Don't deal with POST requests
    if (req.request == "POST") {
        set req.http.var-nyt-force-pass = "true";
    } else {
       call recv_route_blogs_filter_querystring;
    }
  }
}

sub miss_pass_route_blogs {

    # the blogs backend does not honor sandbox hosts like www-sandbox01.dev.nytimes.com
    # normalize these to just www.dev.nytimes.com for blogs route
    if(req.http.x-nyt-backend == "blogs") {
        unset bereq.http.cookie;

        if (  !req.backend.is_shield
          &&  req.http.host ~ "^www-[a-z0-9]+\.(dev|stg)\.nytimes\.com$"
          &&  req.http.var-nyt-env != "prd") {

          set bereq.http.host = "www." + req.http.var-nyt-env + ".nytimes.com";
        }
    }
}

sub recv_route_blogs_filter_querystring {
    set req.url = querystring.filter_except(req.url,
      "_jsonp" + querystring.filtersep() +
      "apagenum" + querystring.filtersep() +
      "apikey" + querystring.filtersep() +
      "apitoken" + querystring.filtersep() +
      "asset_id" + querystring.filtersep() +
      "author" + querystring.filtersep() +
      "callback" + querystring.filtersep() +
      "category" + querystring.filtersep() +
      "chromeless" + querystring.filtersep() +
      "entry" + querystring.filtersep() +
      "feed_type" + querystring.filtersep() +
      "homepage" + querystring.filtersep() +
      "nytapp" + querystring.filtersep() +
      "offset" + querystring.filtersep() +
      "p" + querystring.filtersep() +
      "pagewanted" + querystring.filtersep() +
      "post_not_in" + querystring.filtersep() +
      "post_type" + querystring.filtersep() +
      "posts_per_page" + querystring.filtersep() +
      "s" + querystring.filtersep() +
      "tag");
}