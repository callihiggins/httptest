sub recv_route_times_journeys {
    if (req.http.var-nyt-canonical-www-host) {
    	// The order of these two checks is important since the second one is a sub path of the first one
        if (req.url.path ~ "^/times-journeys") {
            set req.http.x-nyt-route = "times-journeys";
            set req.http.x-nyt-backend = "times_journeys";
            set req.http.var-nyt-send-gdpr = "true";
            set req.url = querystring.remove(req.url);
        }

        if (req.url.path ~ "^/times-journeys/students") {
            set req.http.x-nyt-route = "times-journeys-students";
            set req.http.x-nyt-backend = "times_journeys_students";
            set req.http.var-nyt-send-gdpr = "true";
            set req.url = querystring.remove(req.url);
        }
    }
}

sub miss_pass_route_times_journeys {
  if (req.http.x-nyt-route ~ "^times-journeys") {
    if (req.http.x-nyt-route == "times-journeys") {
        if (req.url.path == "/times-journeys") {
            set bereq.url = regsub(req.url, "^/times-journeys", "/");
        } else {
            set bereq.url = regsub(req.url, "^/times-journeys", "");
        }
        if (req.http.var-nyt-env != "prd"){
            set bereq.http.host = "nytimes-journeys-develop.go-vip.net";
        } else {
            set bereq.http.host = "timesjourneys.nytimes.com";
        }
    }

    if (req.http.x-nyt-route == "times-journeys-students") {
        if (req.url.path == "/times-journeys/students") {
            set bereq.url = regsub(req.url, "^/times-journeys/students", "/");
        } else {
            set bereq.url = regsub(req.url, "^/times-journeys/students", "");
        }
        if (req.http.var-nyt-env != "prd"){
            set bereq.http.host = "nytimes-journeys-develop.go-vip.net";
        } else {
            set bereq.http.host = "timesjourneysstudents.nytimes.com";
        }
        
    }

    // Both of the origins are user agnostic. The wordpress hosting also has the default 8k header size limit
    // We're going to unset the cookies on the request
    unset bereq.http.cookie;
  }
}

sub deliver_times_journeys_api_version {
    if (req.http.x-nyt-route ~ "^times-journeys") {
        set resp.http.X-API-Version = "TJ";
    }
}
