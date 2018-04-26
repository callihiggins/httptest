sub recv_route_times_journeys {
    if (req.http.x-nyt-canonical-www-host) {
    	// The order of these two checks is important since the second one is a sub path of the first one
        if (req.url.path ~ "^/times-journeys") {
            set req.http.x-nyt-route = "times-journeys";
            set req.http.x-nyt-backend = "times_journeys";
        }

        if (req.url.path ~ "^/times-journeys/students") {
            set req.http.x-nyt-route = "times-journeys-students";
            set req.http.x-nyt-backend = "times_journeys_students";
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
        set bereq.http.host = "timesjourneys.nytimes.com";
    }

    if (req.http.x-nyt-route == "times-journeys-students") {
        if (req.url.path == "/times-journeys/students") {
            set bereq.url = regsub(req.url, "^/times-journeys/students", "/");
        } else {
            set bereq.url = regsub(req.url, "^/times-journeys/students", "");
        }
        set bereq.http.host = "timesjourneysstudents.nytimes.com";
    }

    unset bereq.http.x-nyt-edition;
    unset bereq.http.x-nyt-s;
    unset bereq.http.x-nyt-wpab;
    // Both of the origins are user agnostic. The wordpress hosting also has the default 8k header size limit
    // We're going to unset the cookies on the request
    unset bereq.http.Cookie;
    unset bereq.http.X-Cookie;
  }
}

sub deliver_times_journeys_api_version {
    if (req.http.x-nyt-route ~ "^times-journeys") {
        set resp.http.X-API-Version = "TJ";
    }
}
