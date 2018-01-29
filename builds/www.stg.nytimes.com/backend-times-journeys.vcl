sub vcl_recv {
    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
    	// The order of these two checks is important since the second one is a sub path of the first one
        if (req.url.path ~ "^/times-journeys") {
            set req.http.X-PageType = "times-journeys";
            set req.http.x-nyt-backend = "times_journeys";
        }

        if (req.url.path ~ "^/times-journeys/students") {
            set req.http.X-PageType = "times-journeys-students";
            set req.http.x-nyt-backend = "times_journeys_students";
        }
    }
}

sub vcl_miss {
    call set_backend_request;
}

sub vcl_pass {
    call set_backend_request;
}

sub set_backend_request {
    if (req.http.X-PageType ~ "^times-journeys") {
        if (req.http.X-PageType == "times-journeys") {
            if (req.url.path == "/times-journeys") {
                set bereq.url = regsub(req.url, "^/times-journeys", "/");
            } else {
                set bereq.url = regsub(req.url, "^/times-journeys", "");
            }
            set req.backend = F_times_journeys;
            set bereq.http.host = "timesjourneys.nytimes.com";
        }

        if (req.http.X-PageType == "times-journeys-students") {
            if (req.url.path == "/times-journeys/students") {
                set bereq.url = regsub(req.url, "^/times-journeys/students", "/");
            } else {
                set bereq.url = regsub(req.url, "^/times-journeys/students", "");
            }

            set req.backend = F_times_journeys_students;
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

sub vcl_deliver {
    if (req.http.X-PageType ~ "^times-journeys") {
        set resp.http.X-API-Version = "TJ";
    }
}
