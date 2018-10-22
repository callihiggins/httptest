sub recv_route_adx {

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

        set req.http.x-nyt-route = "adx-static";
        set req.http.x-nyt-backend = "gcs_origin";

        unset req.http.Authorization;
        call recv_post_method_restricted;

        # remove query string parameters
        set req.url = querystring.remove(req.url);
    }
}

sub miss_pass_route_adx {
  if (req.http.x-nyt-route == "adx-static") {
    if(!req.backend.is_shield) {
        unset bereq.http.cookie;
        call miss_pass_set_bucket_auth_headers;
    }

  }
}
