sub vcl_recv {
    // server health check pattern
    // this intentionally matches end of URI due to nonstandard Nagios requests
    // example: <http://www-varnish01.prd.sea1.nytimes.comhttp://www.nytimes.com/.status>
    // thus: req.url = |http://www.nytimes.com/.status|
    if (req.url ~ "/.status$") {
        set req.http.X-PageType = "healthcheck";
        error 800;
    }
}

sub vcl_error {
    if (obj.status == 800) {
        set obj.http.X-API-Version = "0";
        # XXX -- What does utils.exists do? Temporarily commented it out -- stephen
        
        #if (utils.exists("/opt/nyt/www/.rotate-out")) {
        if (req.url) {
            set obj.status = 503;
            set obj.response = "Service Unavailable";
            synthetic {"503 - STATUS ROTATED OUT"};
        } else {
            set obj.status = 200;
            set obj.response = "OK";
            synthetic {"200 - STATUS OK"};
        } 

        return(deliver);
    }
}