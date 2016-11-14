sub vcl_deliver {

    # remove extraneous response headers
    remove resp.http.nnCoection;
    remove resp.http.Via;
    remove resp.http.X-Backend;
    remove resp.http.X-DetectedRuntimeConfigFlag;
    remove resp.http.X-ESI-Status;
    remove resp.http.X-Hash;
    remove resp.http.X-Killswitch-01;
    remove resp.http.X-Powered-By;
    remove resp.http.X-Varnish;
   

    # set some headers
    set resp.http.Connection = "close";

    # lets return some headers to internal clients for debugging
    if(client.ip !~ internal){
        # if you're not internal, remove these
        remove resp.http.X-VarnishCacheDuration;
        remove resp.http.X-Origin-Server;
    } else {
        # if you are internal, set these
        set resp.http.X-NYT-Backend = req.http.X-NYT-Backend;
    }
    
    if (resp.http.X-API-Version) {
        set resp.http.X-API-Version = "F-" + resp.http.X-API-Version;
    } else {
        set resp.http.X-API-Version = "F-X";
    }

    if(!resp.http.X-PageType){
        set resp.http.X-PageType = req.http.X-PageType;
    }

    // if we found two NYT-S cookies, try to expire the possible non-canonical versions
    // only dev/stg for now
    if (req.http.x-environment != "prd"){
        if(req.http.x-nyt-s2){

            // delete a docroot cookie under www.nytimes.com
            add resp.http.Set-Cookie = 
                "NYT-S=; "+
                "Expires=" + time.sub(now, 365d) + "; "+
                "Path=/; "+
                "Domain=www.nytimes.com";

            // delete dir path cookies if we are not rendering the homepage
            if (req.http.X-PageType != "homepage") {          
                add resp.http.Set-Cookie = 
                    "NYT-S=" + req.http.x-nyt-a + "; "+
                    "Expires=" + time.sub(now, 365d) + "; "+
                    "Path=" + req.url.dirname + "; " +
                    "Domain=www.nytimes.com";

                add resp.http.Set-Cookie = 
                    "NYT-S=" + req.http.x-nyt-a + "; "+
                    "Expires=" + time.sub(now, 365d) + "; "+
                    "Path=" + req.url.dirname + "; " +
                    "Domain=.nytimes.com";
            }
        }
    }

    // for HTTPS
    if (req.http.Fastly-SSL && client.ip ~ internal) {
        if (req.http.x-environment == "prd") {
            set resp.http.Content-Security-Policy = "default-src data: 'unsafe-inline' 'unsafe-eval' https:; script-src data: 'unsafe-inline' 'unsafe-eval' https: blob:; style-src data: 'unsafe-inline' https:; img-src data: https:; font-src data: https:; connect-src https: wss:; media-src https:; object-src https:; child-src https: data: blob:; form-action https:; block-all-mixed-content; report-uri https://nytimes.report-uri.io/r/default/csp/enforce;";
        } else {
            set resp.http.Content-Security-Policy = "default-src data: 'unsafe-inline' 'unsafe-eval' https:; script-src data: 'unsafe-inline' 'unsafe-eval' https: blob:; style-src data: 'unsafe-inline' https:; img-src data: https:; font-src data: https:; connect-src https: wss:; media-src https:; object-src https:; child-src https: data: blob:; form-action https:; block-all-mixed-content;";
        }
    }
}
