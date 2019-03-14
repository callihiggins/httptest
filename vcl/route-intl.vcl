sub recv_route_intl {

  # redirect deprecated international host to www
  if (req.http.host ~ "^international\.(dev\.|stg\.)?nytimes.com$") {
      declare local var.target_url STRING;
      set var.target_url =
          "https://" +
          regsub(req.http.host, "^international.","www.") +
          req.url;
      error 770 var.target_url;
  }

  if (req.url == "/es" || (req.url ~ "^/es/" && req.url.path !~ "\.html$") ||
      req.url == "/global" || req.url ~ "^/global/"
  ) {

    set req.http.x-nyt-route = "intl";
    set req.http.x-nyt-backend = "intl_gcp";
    set req.http.var-nyt-wf-auth = "true";
    set req.http.var-nyt-send-gdpr = "true";

    call recv_route_intl_filter_querystring;

      unset req.http.Authorization;
      call recv_post_method_restricted;

    # Bypass cache for logged-in WordPress users, etc.
    if (req.http.Cookie ~ "comment_author_|wordpress_(?!test_cookie)|wp-postpass_" ) {
      set req.http.x-nyt-route = "intl-pass";
      set req.http.var-nyt-force-pass = "true";
    }
  }
}

sub miss_pass_route_intl {
  if (req.http.x-nyt-route == "intl") {
    unset bereq.http.cookie;
  }
}

sub fetch_route_intl_headers {
  if (req.http.x-nyt-route == "intl") {
    # don't return this header in prd
    if ( !(req.http.x-nyt-nyhq-access == "1") && req.http.var-nyt-env == "prd") {
      unset beresp.http.X-Kubernetes-Url;
    }
  }
}

sub recv_route_intl_filter_querystring {
  set req.url = querystring.filter_except(req.url,
      "sort" + querystring.filtersep() +
      "q" + querystring.filtersep() +
      "dom" + querystring.filtersep() +
      "dedupe_hl" + querystring.filtersep() +
      "mc" + querystring.filtersep() +
      "mcid" + querystring.filtersep() +
      "mccr" + querystring.filtersep() +
      "subid" + querystring.filtersep() +
      "ref" + querystring.filtersep() +
      "filter" + querystring.filtersep() +
      "attachment" + querystring.filtersep() +
      "attachment_id" + querystring.filtersep() +
      "author" + querystring.filtersep() +
      "author_name" + querystring.filtersep() +
      "cat" + querystring.filtersep() +
      "calendar" + querystring.filtersep() +
      "category_name" + querystring.filtersep() +
      "comments_popup" + querystring.filtersep() +
      "cpage" + querystring.filtersep() +
      "day" + querystring.filtersep() +
      "dedupe_hl" + querystring.filtersep() +
      "dom" + querystring.filtersep() +
      "error" + querystring.filtersep() +
      "exact" + querystring.filtersep() +
      "exclude" + querystring.filtersep() +
      "feed" + querystring.filtersep() +
      "hour" + querystring.filtersep() +
      "m" + querystring.filtersep() +
      "minute" + querystring.filtersep() +
      "monthnum" + querystring.filtersep() +
      "more" + querystring.filtersep() +
      "name" + querystring.filtersep() +
      "nyt_interactive" + querystring.filtersep() +
      "nyt_kicker" + querystring.filtersep() +
      "nyt_slideshow" + querystring.filtersep() +
      "order" + querystring.filtersep() +
      "orderby" + querystring.filtersep() +
      "p" + querystring.filtersep() +
      "page_id" + querystring.filtersep() +
      "page" + querystring.filtersep() +
      "paged" + querystring.filtersep() +
      "pagename" + querystring.filtersep() +
      "pb" + querystring.filtersep() +
      "post_type" + querystring.filtersep() +
      "posts" + querystring.filtersep() +
      "preview" + querystring.filtersep() +
      "q" + querystring.filtersep() +
      "robots" + querystring.filtersep() +
      "s" + querystring.filtersep() +
      "search" + querystring.filtersep() +
      "second" + querystring.filtersep() +
      "sentence" + querystring.filtersep() +
      "smid" + querystring.filtersep() +
      "smtyp" + querystring.filtersep() +
      "smvar" + querystring.filtersep() +
      "sort" + querystring.filtersep() +
      "static" + querystring.filtersep() +
      "subpost" + querystring.filtersep() +
      "subpost_id" + querystring.filtersep() +
      "taxonomy" + querystring.filtersep() +
      "tag" + querystring.filtersep() +
      "tb" + querystring.filtersep() +
      "tag_id" + querystring.filtersep() +
      "term" + querystring.filtersep() +
      "tb" + querystring.filtersep() +
      "url" + querystring.filtersep() +
      "w" + querystring.filtersep() +
      "withcomments" + querystring.filtersep() +
      "withoutcomments" + querystring.filtersep() +
      "year");
}
