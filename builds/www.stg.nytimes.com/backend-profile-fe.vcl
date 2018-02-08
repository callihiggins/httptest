sub vcl_recv {
    // /svc/profile/v2/email/verified-product-subscriptions-address is a special content switch rule that
    // goes to paperboy-profileapi backend on netscaler. We need to filter it out from reqeusts to
    // profile_fe. This endpoint will soon not be accessible through www with messaging team migrating
    // paperboy to new app called helix in GCP
    if (req.url.path ~ "^/svc/(user|profile)/" && req.url.path !~ "^/svc/profile/v2/email/verified-product-subscriptions-address") {
        set req.http.X-PageType = "profile-fe";
        set req.http.x-nyt-backend = "profile_fe";

        unset req.http.x-nyt-edition;
        unset req.http.x-nyt-s;
        unset req.http.x-nyt-d;
        unset req.http.x-nyt-wpab;

        // This backend need cookies and query params passed, so returning early
        return(pass);
    }
}

sub vcl_pass {
    if (req.http.X-PageType == "profile-fe") {
        call set_profile_fe_backend;
    }
}

sub vcl_miss {
    if (req.http.X-PageType == "profile-fe") {
        call set_profile_fe_backend;
    }
}

sub vcl_deliver {
    if (req.http.X-PageType == "profile-fe") {
        set resp.http.X-API-Version = "PFE";
    }
}

sub set_profile_fe_backend {

    set req.backend = F_profile_fe;

    if (req.http.x-environment == "dev") {
        set bereq.http.host = "profile-fe.dev.nyt.net";
    } else if (req.http.x-environment == "stg") {
        set bereq.http.host = "profile-fe.stg.nyt.net";
    } else {
        set bereq.http.host = "profile-fe.prd.nyt.net";
    }
}
