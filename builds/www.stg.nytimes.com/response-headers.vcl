sub vcl_deliver {
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
    set resp.http.X-API-Version = "F-" + resp.http.X-API-Version;
    set resp.http.Connection = "close";
    set resp.http.X-NYT-Backend = req.backend;
}
