sub vcl_recv {
    if (req.http.host ~ "\.dev\.") {
        set req.http.x-environment = "dev";
    } else if (req.http.host ~ "\.stg\.") {
        set req.http.x-environment = "stg";
    } else {
        set req.http.x-environment = "prd";
    }
}
