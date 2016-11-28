sub vcl_recv {
    // @TODO: remove environment condition once in Production
    if (req.http.x-environment != "prd") {
        if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
            if (req.url ~ "^/svc/weddings") {
                call set_du_weddings_api_backend;
                set req.http.X-PageType = "weddings-api";
                set req.http.x-skip-glogin = "1";
                return(pass);
            }
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "weddings-api") {
        set resp.http.X-API-Version = "DUW";
    }
}

sub set_du_weddings_api_backend {
    if (req.http.x-environment == "dev") {
//        set req.backend = du_weddings_api_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = du_weddings_api_stg;
    } else {
//        set req.backend = du_weddings_api_prd;
    }
}
