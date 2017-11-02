sub vcl_recv {

    # various ADX related path patterns that we will send to a GCS bucket
    if ( req.url.path ~ "^/adx" ||
         req.url.path == "/gst/svc/adx.html" ||
         req.url.path ~ "^/svc/adxmulti"
        ) {

        # clientside URL is generated dynamically
        # rewrite it so that we can serve a static file from GCS
        if (req.url.path ~ "^/adx/bin/clientside") {
            set req.url = "/adx/bin/clientside.txt";
        }

        ## send anything /adxbin to a specific file
        if (req.url.path ~ "^/adxbin/") {
            set req.url = "/adxbin/response.txt";
        }

        # adxmulti needs to rewrite to a specific file
        if (req.url.path ~ "^/svc/adxmulti") {
            set req.url = "/svc/adxmulti/response.json";
        }

        set req.http.X-PageType = "adx-static";
        unset req.http.Cookie;
        unset req.http.X-Cookie;
        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-wpab;
        unset req.http.Authorization;

        # remove query string parameters
        set req.url = querystring.remove(req.url);
        return(lookup);

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
