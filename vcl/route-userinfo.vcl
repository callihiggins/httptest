sub recv_route_userinfo {
  // This deals with useers that are not logged in
  // if the cookie does not start with "0" we will
  // fall through this and it will be a backend hit
  // to the API on the origin
  if (req.http.var-cookie-nyt-s ~ "^0" || !req.http.var-cookie-nyt-s){
    if (req.url ~ "^/svc/web-products/userinfo.jsonp") {
      set req.http.x-nyt-route = "service";
      error 901;
    }
    if (req.url ~ "^/svc/web-products/userinfo.json") {
      set req.http.x-nyt-route = "service";
      error 902;
    }
    if (req.url ~ "^/svc/web-products/userinfo-v2.jsonp") {
      set req.http.x-nyt-route = "service";    
      error 903;
    }
    if (req.url ~ "^/svc/web-products/userinfo-v2.json") {
      set req.http.x-nyt-route = "service";
      error 904;
    }
    if (req.url ~ "^/svc/web-products/userinfo-v3.jsonp") {
      set req.http.x-nyt-route = "service";
      error 905;
    }
    if (req.url ~ "^/svc/web-products/userinfo-v3.json") {
      set req.http.x-nyt-route = "service";
      error 906;
    }
  }

  // Logged in users (userinfo is the only svc under web-products)
  if (req.url ~ "^/svc/web-products/") {
    set req.http.x-nyt-route = "service";
    set req.http.x-nyt-backend = "www_userinfo";
    set req.http.var-nyt-force-pass = "true";
    set req.http.var-nyt-wf-auth = "true";
  }
}

sub error_901_to_906_route_userinfo {
  // "/svc/web-products/userinfo.jsonp" requests
  if (obj.status == 901) {
    call route_userinfo_deliver_v1_jsonp_string;
  }

  // "/svc/web-products/userinfo.json" requests
  if (obj.status == 902) {
    call route_userinfo_deliver_v1_json_string;
  }

  // "/svc/web-products/userinfo-v2.jsonp" requests
  if (obj.status == 903) {
    call route_userinfo_deliver_v2_jsonp_string;
  }

  // "/svc/web-products/userinfo-v2.json" requests
  if (obj.status == 904) {
    call route_userinfo_deliver_v2_json_string;
  }

  // "/svc/web-products/userinfo-v3.jsonp" requests
  if (obj.status == 905) {
    call route_userinfo_deliver_v3_jsonp_string;
  }

  // "/svc/web-products/userinfo-v3.json" requests
  if (obj.status == 906) {
    call route_userinfo_deliver_v3_json_string;
  }
}


sub route_userinfo_deliver_v1_json_string {
  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/json";

  synthetic {"{ "meta": {},
  "data": {
    "id": "0",
    "name": "",
    "subscription": {
      "web": "0",
      "mobile": "0",
      "crosswords": "0",
      "hd": "0",
      "now": "0"
    }
  }
}"};

  return (deliver);
}


sub route_userinfo_deliver_v1_jsonp_string {

  call route_userinfo_set_callback_querystring_param;

  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/javascript";

  synthetic "/**/" + req.http.var-nyt-userinfo-callback-param  + {"({ "meta": {},
    "data": {
      "id": "0",
      "name": "",
      "subscription": {
        "web": "0",
        "mobile": "0",
        "crosswords": "0",
        "hd": "0",
        "now": "0"
      }
    }
  });"};

  return (deliver);
}


sub route_userinfo_deliver_v2_json_string {

  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/json";

  synthetic {"{ "meta": {},
    "data": {
      "id": "0",
      "name": "",
      "subscription": [],
      "country": "(null)",
      "gender": "(null)",
      "income_low": "0",
      "income_high": "0",
      "jobtitle": "0",
      "jobindustry": "0"
    }
  }"};

  return (deliver);
}

sub route_userinfo_deliver_v2_jsonp_string {

  call route_userinfo_set_callback_querystring_param;

  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/javascript";

  synthetic "/**/" + req.http.var-userinfo-callback-param  + {"({ "meta": {},
    "data": {
      "id": "0",
      "name": "",
      "subscription": [],
      "country": "(null)",
      "gender": "(null)",
      "income_low": "0",
      "income_high": "0",
      "jobtitle": "0",
      "jobindustry": "0"
    }
  });"};

  return (deliver);
}

sub route_userinfo_deliver_v3_json_string {

  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/json";

  synthetic {"{ "meta": {},
  "data": {
    "id": "0",
    "name": "",
    "subscription": [],
    "demographics": {},
    "geo": {"country": ""} + client.geo.country_name + {"" }
  }
}"};

  return (deliver);
}

sub route_userinfo_deliver_v3_jsonp_string {
  call route_userinfo_set_callback_querystring_param;

  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/javascript";

  synthetic "/**/" + req.http.var-nyt-userinfo-callback-param  + {"({ "meta": {},
  "data": {
    "id": "0",
    "name": "",
    "subscription": [],
    "demographics": {},
    "geo": {"country": ""} + client.geo.country_name + {"" }
  }
});"};

  return (deliver);
}

sub route_userinfo_set_callback_querystring_param {
  // use "callback" querystring param for javascript callback function name
  // if not set, default to "userInfoCallback"
  set req.http.var-nyt-userinfo-callback-param = if (subfield(req.url.qs, "callback", "&"), subfield(req.url.qs, "callback", "&"), "userInfoCallback");
}
