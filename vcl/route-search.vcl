sub recv_route_search {
  if (req.url ~ "^/search") {
      set req.http.x-nyt-route = "vi-search";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-error-retry = "false";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.x--fastly-project-vi = "1";
      set req.http.var-nyt-send-gdpr = "true";

      call recv_route_search_filter_querystring;
  }
}

sub miss_pass_route_search {
  if (req.http.x-nyt-route == "vi-search") {
    unset bereq.http.cookie;
  }
}

sub recv_route_search_filter_querystring {
  set req.url = querystring.filter_except(req.url,
    "query" + querystring.filtersep() +
    "startDate" + querystring.filtersep() +
    "endDate" + querystring.filtersep() +
    "sort");
}
