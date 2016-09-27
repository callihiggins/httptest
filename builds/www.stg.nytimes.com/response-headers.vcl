sub vcl_hit {
    set req.http.X-Cache = "hit";
}

sub vcl_miss {
    set req.http.X-Cache = "miss";
}

sub vcl_pass {
    set req.http.X-Cache = "pass";
}

sub vcl_deliver {
    # XXX -- use fastly syslog --stephen
    # log "appTagForLogging:" + req.http.X-PageType;

    # leave these headers if we're internal on stg
    if(client.ip !~ internal && req.url !~ "\.stg\."){
        remove resp.http.Via;
        remove resp.http.X-ESI-Status;
        remove resp.http.X-Powered-By;
        remove resp.http.X-ServerName;
        remove resp.http.X-Varnish;
        remove resp.http.X-VarnishCacheDuration;

    } else {
        # set some additional headers for internal stg
        set resp.http.X-NYT-Backend = req.http.X-NYT-Backend;
    }
    
    if (req.http.X-Experiment626 == "IAmAFunctionalTest") {
        set resp.http.X-CRWL = req.http.X-CRWL;
        set resp.http.X-Hash = req.url;
    }

    /*
    if (req.http.X-PageType == "service") {
        set resp.http.X-API-Version = "F-0";
    } elseif (req.http.X-PageType == "review") {
        set resp.http.X-API-Version = "5-5s";
    } elseif (req.http.X-PageType ~ "^blog") {
        set resp.http.X-API-Version = "5-5b";
    } elseif (resp.http.X-API-Version) {
        set resp.http.X-API-Version = "F-" + resp.http.X-API-Version;
    } elseif (req.backend == www) {
        set resp.http.X-API-Version = "F-5-4";
    } else {
        set resp.http.X-API-Version = "F-?";
    }
    */

    set resp.http.X-API-Version = "F-" + resp.http.X-API-Version;

    if (req.http.X-Cache) {
        set resp.http.X-Cache = req.http.X-Cache;
    }
    if (req.http.X-PageType) {
        set resp.http.X-PageType = req.http.X-PageType;
    }
    if (req.http.x-is-https) {
        #Set resp.http.Strict-Transport-Security = "max-age=60";
        set resp.http.Content-Security-Policy = "default-src data: 'unsafe-inline' 'unsafe-eval' https:; script-src data: 'unsafe-inline' 'unsafe-eval' https: blob:; style-src data: 'unsafe-inline' https:; img-src data: https:; font-src data: https:; connect-src https: wss:; media-src https:; object-src https:; child-src https: data: blob:; form-action https:; block-all-mixed-content; report-uri https://nytimes.report-uri.io/r/default/csp/enforce;";
    }

    set resp.http.Connection = "close";

}
