sub recv_route_fastly_healthcheck {

    # changing this so it just returns 200 all the time on Fastly
    # this is still needed for monitoring not to cry
    # TODO: make a real healthcheck to return backend health status dynamically?
    if (req.url ~ "/.status$") {
        set req.http.x-nyt-route = "healthcheck";
        error 800;
    }
}

sub error_800_fastly_healthcheck {
    if (obj.status == 800) {
        set obj.http.X-API-Version = "0";
        set obj.status = 200;
        set obj.response = "OK";
        synthetic {"200 - STATUS OK"};
        return(deliver);
    }
}
