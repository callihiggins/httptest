sub recv_route_blogs {
  // blogs under WWW hostname
  if (req.http.x-nyt-canonical-www-host == "true") {
      if (   req.url ~  "^/news/"
          || req.url ~  "^/news$"
          || req.url ~  "^/politics/first-draft"
          || req.url ~  "^/times-insider"
          || req.url ~  "^/timesjourneys"
          || req.url ~  "^/live/"
          || req.url ~  "^/live$"
      ) {
          set req.http.X-PageType = "blog";
          set req.http.x-nyt-backend = "blogs";
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
              set req.http.X-PageType = "blog-legacy";
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
      set req.http.X-PageType = "blog-legacy";
      set req.http.x-nyt-backend = "blogs";
  }
}
