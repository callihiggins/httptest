sub vcl_recv {
    if (req.http.x-environment != "prd" && req.url ~ "^/adx") {

        # clientside URL is generated dynamically
        # rewrite it so that we can serve a static file from GCS
        if (req.url.path ~ "^/adx/bin/clientside") {
            set req.url = "/adx/bin/clientside.txt";
        }

        set req.http.X-PageType = "adx-static";
        unset req.http.Cookie;
        unset req.http.X-Cookie;
        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-wpab;
        unset req.http.Authorization;

        return(lookup);

    } else if(req.url ~ "^/adx"){
        set req.http.X-PageType = "adx-legacy";
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "adx-static") {
        set resp.http.X-API-Version = "AS";
    }
}

sub vcl_miss {
    if (req.http.X-PageType == "adx-static") {
        call set_adx_static_backend;
    }
}

sub vcl_pass {
    if (req.http.X-PageType == "adx-static") {
        call set_adx_static_backend;
    }
}

sub set_adx_static_backend {
    set req.backend = adx_static_prd;
    set bereq.http.host = "nyt-adx-static.storage.googleapis.com";
}
