sub vcl_deliver {
    # remove BS headers
    remove resp.http.nnCoection;
    remove resp.http.Via;
    remove resp.http.X-Backend;
    remove resp.http.X-DetectedRuntimeConfigFlag;
    remove resp.http.X-ESI-Status;
    remove resp.http.X-Hash;
    remove resp.http.X-Killswitch-01;
    remove resp.http.X-Powered-By;
    remove resp.http.X-Varnish;
    remove resp.http.X-VarnishCacheDuration;

    # set some headers
    set resp.http.Connection = "close";

    # set NYT specific headers
    set resp.http.X-NYT-Backend = req.http.X-NYT-Backend;
    if (resp.http.X-API-Version) {
        set resp.http.X-API-Version = "F-" + resp.http.X-API-Version;
    } else {
        set resp.http.X-API-Version = "F-X";
    }
}
