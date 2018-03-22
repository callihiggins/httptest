// Weddings has it's own VCL because it needs a longer timeout than the other DU content APIs.
sub vcl_recv {

    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (req.url ~ "^/svc/weddings") {
            set req.http.x-nyt-backend = "du_weddings_api";
            call set_du_weddings_api_backend;
            set req.http.X-PageType = "weddings-api";
            set req.http.x-nyt-force-pass = "true";
            #return(pass);
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "weddings-api") {
        set resp.http.X-API-Version = "DUW";
    }
}

sub set_du_weddings_api_backend {
    set req.backend = F_du_weddings_api;
}
