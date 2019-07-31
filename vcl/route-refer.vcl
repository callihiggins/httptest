sub recv_route_refer {
  if (req.url ~ "^/share/"
        || req.url ~ "^/share\?"
        || req.url ~ "^/share$"
    ) {
      set req.http.x-nyt-route = "vi-refer";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-error-retry = "false";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";
      unset req.http.Authorization;

      call recv_route_refer_filter_querystring;
  }
}

sub miss_pass_route_refer {
  if (req.http.x-nyt-route == "vi-refer") {
    unset bereq.http.cookie;
  }
}

sub recv_route_refer_filter_querystring {
  set req.url = querystring.filter_except(req.url, 
    "campaignId" + querystring.filtersep() +
    "referralCampaign"
    );
}
