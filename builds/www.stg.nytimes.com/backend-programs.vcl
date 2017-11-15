sub vcl_recv {
    if (req.url.path ~ "^/programs/svc/") {
        return(pass);
    }
    
    if (req.http.host ~ "^www([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$") {
        if (req.url.path ~ "^/programs/" ) {
            set req.http.X-PageType = "programs-service";
            unset req.http.Cookie;
            unset req.http.X-Cookie; 
            return(lookup);           
        }
    }
}

sub vcl_pass {
    if (req.http.X-PageType == "programs-service") {
        call set_programs_web_backend;
    }
}

sub vcl_miss {
    if (req.http.X-PageType == "programs-service") {
        call set_programs_web_backend;
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "programs-service") {
        set resp.http.X-API-Version = "PS";
    }
}

sub set_programs_web_backend {
    if (req.http.x-environment == "dev") {
        // No dev
    } else if (req.http.x-environment == "stg") {
        set req.backend = programs_svc_stg;
        set bereq.http.host = "ftu-dot-nyt-betaprog-dev.appspot.com";
    } else {
        set req.backend = programs_svc_prd;
        set bereq.http.host = "ftu-dot-nyt-betaprog-prd.appspot.com";
    }

}
