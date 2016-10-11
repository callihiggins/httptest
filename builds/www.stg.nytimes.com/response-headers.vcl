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
}
