sub recv_route_trending {
  // trending application
  if (   req.url ~ "^/trending/"
      || req.url ~ "^/trending?"
      || req.url ~ "^/trending$"
  ) {
      set req.http.x-nyt-route = "trending";
      set req.http.x-nyt-backend = "misc_fe";
      set req.http.var-nyt-send-gdpr = "true";
      set req.url = querystring.remove(req.url);
      call set_nyt5_misc_backend;
  }
}

sub recv_route_best_sellers {
  // bestseller application
  if (   req.url ~ "^/books/best-sellers/"
      || req.url ~ "^/books/best-sellers?"
      || req.url ~ "^/books/best-sellers$"
  ) {
      set req.http.x-nyt-route = "bestseller";
      set req.http.x-nyt-backend = "misc_fe";
      set req.http.var-nyt-send-gdpr = "true";
      set req.url = querystring.filter_except(req.url, "nytapp");
      call set_nyt5_misc_backend;
  }
}

sub recv_route_diningmap {
  // collection reviews diningmap pattern is part of misc
  if (req.url ~ "^/reviews/dining/map") {
      set req.http.x-nyt-route = "collection";
      set req.http.x-nyt-backend = "misc_fe";
      set req.http.var-nyt-send-gdpr = "true";
      set req.url = querystring.filter_except(req.url, "nytapp");
      call set_nyt5_misc_backend;
  }
}

sub miss_pass_route_nyt5_misc {
  if (req.http.x-nyt-backend == "misc_fe") {
    unset bereq.http.cookie;
  }
}

sub set_nyt5_misc_backend {
  set req.http.var-nyt-wf-auth = "true";
  set req.http.var-nyt-send-gdpr = "true";
  # if we needed to switch back to NYT5, unset the vi flag
  unset req.http.x--fastly-project-vi;
  unset req.http.Authorization;
  call recv_post_method_restricted;
}
