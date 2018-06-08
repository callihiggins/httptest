sub recv_route_collection {
  if (   req.url ~ "^/by/"
      || req.url ~ "^/column/"
      || req.url ~ "^/issue/"
      || req.url ~ "^/series/"
      || req.url ~ "^/news-event/"
      || req.url ~ "^/reviews/"
      || req.url ~ "^/reviews?"
      || req.url ~ "^/reviews$"
      || req.url ~ "^/saved/"
      || req.url ~ "^/saved\?"
      || req.url ~ "^/saved$"
      || req.url ~ "^/section/"
      || req.url ~ "^/spotlight/"
      || req.url ~ "^/topic/person/"
      || req.url ~ "^/topic/company/"
      || req.url ~ "^/topic/destination/"
      || req.url ~ "^/topic/organization/"
      || req.url ~ "^/topic/subject/"
      || req.url ~ "^/upshot"
  ) {
      set req.http.x-nyt-route = "collection";
      set req.http.x-nyt-backend = "collection_fe";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";
      set req.url = querystring.filter_except(req.url, "nytapp");
      # if we needed to switch back to NYT5, unset the vi flag
      unset req.http.x--fastly-project-vi;
  }

  # route selected columns to VI
  if (   req.url ~ "^/column/road-trip"
      || req.url ~ "^/column/by-the-book"
      || req.url ~ "^/column/learning-news-quiz"
      || req.url ~ "^/column/diagnosis"
      || req.url ~ "^/column/crime"
      || req.url ~ "^/column/learning-student-opinion"
      || req.url ~ "^/column/vows"
      || req.url ~ "^/column/36-hours"
      || req.url ~ "^/column/learning-word-of-the-day"
      || req.url ~ "^/column/best-of-late-night"
  ) {
    set req.http.x-nyt-route = "vi-collection";
    set req.http.x-nyt-backend = "projectvi_fe";
    set req.http.var-nyt-wf-auth = "true";
    set req.http.var-nyt-send-gdpr = "true";
    set req.url = querystring.filter_except(req.url, "nytapp");
    set req.http.x--fastly-project-vi = "1";
  }

}

sub miss_pass_route_collection {
  if (req.http.x-nyt-route == "collection" || req.http.x-nyt-route == "vi-collection") {
    unset bereq.http.cookie;
  }
}
