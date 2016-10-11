sub vcl_recv {
  
  // For right now, we're only going to deal with
  // useers that are NOT logged in
  // if the cookie does not start with "0" we will
  // fall through this and it will be a backend hit
  // to the API on the origin

  if (req.http.x-nyt-s ~ "^0" || !req.http.x-nyt-s){ 
    if (req.url ~ "^/svc/web-products/userinfo.jsonp") {
      set req.http.X-PageType = "service";
      error 901;
    }
    if (req.url ~ "^/svc/web-products/userinfo.json") {
      set req.http.X-PageType = "service";
      error 902;
    }
    if (req.url ~ "^/svc/web-products/userinfo-v2.jsonp") {
      set req.http.X-PageType = "service";
      error 903;
    }
    if (req.url ~ "^/svc/web-products/userinfo-v2.json") {
      set req.http.X-PageType = "service";
      error 904;
    }
    if (req.url ~ "^/svc/web-products/userinfo-v3.jsonp") {
      set req.http.X-PageType = "service";
      error 905;
    }
    if (req.url ~ "^/svc/web-products/userinfo-v3.json") {
      set req.http.X-PageType = "service";
      error 906;
    }
  }

}

sub vcl_error {
  // "/svc/web-products/userinfo.jsonp" requests
  if (obj.status == 901) {
    call deliver_v1_jsonp_string;
  }

  // "/svc/web-products/userinfo.json" requests
  if (obj.status == 902) {
    call deliver_v1_json_string;
  }

  // "/svc/web-products/userinfo-v2.jsonp" requests
  if (obj.status == 903) {
    call deliver_v2_jsonp_string;
  }

  // "/svc/web-products/userinfo-v2.json" requests
  if (obj.status == 904) {
    call deliver_v2_json_string;
  }

  // "/svc/web-products/userinfo-v3.jsonp" requests
  if (obj.status == 905) {
    call deliver_v3_jsonp_string;
  }

  // "/svc/web-products/userinfo-v3.json" requests
  if (obj.status == 906) {
    call deliver_v3_json_string;
  }
}


sub deliver_v1_json_string {

  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/json";
  set obj.http.X-API-Version = "0";

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


sub deliver_v1_jsonp_string {
  
  call set_callback_querystring_param;

  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/javascript";
  set obj.http.X-API-Version = "0";

  synthetic "/**/" + req.http.x-callback-param + {"({ "meta": {},
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


sub deliver_v2_json_string {

  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/json";
  set obj.http.X-API-Version = "0";

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

sub deliver_v2_jsonp_string {
  
  call set_callback_querystring_param;

  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/javascript";
  set obj.http.X-API-Version = "0";

  synthetic "/**/" + req.http.x-callback-param + {"({ "meta": {},
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

sub deliver_v3_json_string {

  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/json";
  set obj.http.X-API-Version = "0";

  synthetic {"{ "meta": {},
  "data": {
    "id": "0",
    "name": "",
    "subscription": [],
    "demographics": {},
    "geo": {"country": ""} + geoip.country_name.ascii + {"" }
  }
}"};

  return (deliver);
}

sub deliver_v3_jsonp_string {

  call set_callback_querystring_param;


  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/javascript";
  set obj.http.X-API-Version = "0";

  synthetic "/**/" + req.http.x-callback-param + {"({ "meta": {},
  "data": {
    "id": "0",
    "name": "",
    "subscription": [],
    "demographics": {},
    "geo": {"country": ""} + geoip.country_name.ascii + {"" }
  }
});"};

  return (deliver);
}



sub set_callback_querystring_param {

  // use "callback" querystring param for javascript callback function name
  // if not set, default to "userInfoCallback"
  set req.http.x-callback-param = regsub(req.url, ".*[\?&]callback=([\.A-Za-z0-9_]+).*", "\1");
  if (req.http.x-callback-param == req.url) {
    set req.http.x-callback-param = "userInfoCallback";
  }

}
