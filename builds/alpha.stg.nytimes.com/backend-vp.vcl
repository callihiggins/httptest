sub vcl_recv {
    if (req.http.host ~ "^alpha([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (req.url ~ "^/video-media") {
            set req.http.X-PageType = "video-media";
            call set_vp_backend;
            set req.url = regsub(req.url, "^/video-media/", "/video/");

            return(lookup);
        }
    }
}

sub vcl_deliver {
    if (req.http.X-PageType ~ "video-media") {
        set resp.http.X-API-Version = "VM";
    }
}

sub set_vp_backend {
	set req.backend = vp_prd;
    set req.http.host = "vp.nyt.com";
}
