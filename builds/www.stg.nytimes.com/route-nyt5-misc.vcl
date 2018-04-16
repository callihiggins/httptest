sub recv_route_trending {
  // trending application
  if (   req.url ~ "^/trending/"
      || req.url ~ "^/trending?"
      || req.url ~ "^/trending$"
  ) {
      set req.http.X-PageType = "trending";
      set req.http.x-nyt-backend = "misc_fe";
      call set_nyt5_misc_backend;
  }
}

sub recv_route_podcasts {
  // podcasts application
  if (req.url ~ "^/podcasts") {
      set req.http.X-PageType = "podcasts";
      set req.http.x-nyt-backend = "misc_fe";
      call set_nyt5_misc_backend;
  }
}

sub recv_route_best_sellers {
  // bestseller application
  if (   req.url ~ "^/books/best-sellers/"
      || req.url ~ "^/books/best-sellers?"
      || req.url ~ "^/books/best-sellers$"
  ) {
      set req.http.X-PageType = "bestseller";
      set req.http.x-nyt-backend = "misc_fe";
      call set_nyt5_misc_backend;
  }
}

sub recv_route_diningmap {
  // collection reviews diningmap pattern is part of misc
  if (req.url ~ "^/reviews/dining/map") {
      set req.http.X-PageType = "collection";
      set req.http.x-nyt-backend = "misc_fe";
      call set_nyt5_misc_backend;
  }
}

sub set_nyt5_misc_backend {
  set req.http.x-nyt-wf-auth = "true";
  # if we needed to switch back to NYT5, unset the vi flag
  unset req.http.x--fastly-project-vi;
}
