sub vcl_recv {

    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
    	// The order of these two checks is important since the second one is a sub path of the first one
        if (req.url ~ "^/times-journeys") {
            set req.http.X-PageType = "times-journeys";
        }

        if (req.url ~ "^/times-journeys/students") {
            set req.http.X-PageType = "times-journeys-students";
        }

        if (req.http.X-PageType == "times-journeys") {
    	    set req.url = regsub(req.url, "^/times-journeys", "");
            set req.backend = times_journeys_prd;
            set req.http.host = "timesjourneys.nytimes.com";
        }

        if (req.http.X-PageType == "times-journeys-students") {
        	set req.url = regsub(req.url, "^/times-journeys/students", "");
            set req.backend = times_journeys_students_prd;
            set req.http.host = "timesjourneysstudents.nytimes.com";
        }

        if (req.http.X-PageType ~ "^times-journeys") {
	        set req.grace = 24h;
	        set req.http.x-skip-glogin = "1";
	        unset req.http.x-nyt-edition;
	        unset req.http.x-nyt-s;
	        unset req.http.x-nyt-wpab;
	        // Both of the origins are user agnostic. The wordpress hosting also has the default 8k header size limit
	        // We're going to unset the cookies on the request
	        unset req.http.Cookie;
            unset req.http.X-Cookie;
        }
    }

    if (req.http.magicmarker-times-journeys == "fake") {
        unset req.http.magicmarker-times-journeys;
        set req.backend = deadend;
        return(lookup);
    }

    return(pass);
}

sub vcl_fetch {
    if (req.http.X-PageType ~ "^times-journeys") {
        // use very short cache TTL for HTTP 4XXs
        if (beresp.status >= 400 && beresp.status < 500) {
            set beresp.ttl = 3s;
        }

        // use saint mode for HTTP 5XXs
        if (beresp.status >= 500) {
            /* deliver stale if the object is available */
            if (stale.exists) {
                return(deliver_stale);
            }
            return(restart);
        }

        set beresp.stale_if_error = 86400s;
        set beresp.stale_while_revalidate = 60s;
    }
}

sub vcl_deliver {
    if (req.http.X-PageType ~ "^times-journeys") {
        set resp.http.X-API-Version = "TJ";
    }
}

sub vcl_error {
    if (req.http.X-PageType ~ "^times-journeys" && obj.status >= 500 && obj.status < 600) {
        set req.http.magicmarker-times-journeys = "fake";
        return(restart);
    }
}
