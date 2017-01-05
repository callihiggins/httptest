sub vcl_recv {


    // IPs that are blocked from all environments
    if ( client.ip ~ blacklist) {
        error 403 "Forbidden";
    }

    // block everyone but the internal ACL to dev service
    if ( client.ip !~ internal && req.http.x-environment == "dev") {
      error 403 "Forbidden";
    }

    // block everyone but internal acl and staging access acl to staging service
    if ( client.ip !~ internal && client.ip !~ external_staging_access && req.http.x-environment == "stg") {
      error 403 "Forbidden";
    }


    if (req.http.user-agent ~ "(?i)googlebot|mediapartners-google|adsbot-google|amphtml|developers\.google\.com/\+/web/snippet/") {
        # Googlebot user-agents: https://support.google.com/webmasters/answer/1061943

        if (client.ip ~ googlebot) {
            # TODO: replace with https://support.google.com/webmasters/answer/80553?hl=en
            # and libvmod-dns
            set req.http.X-CRWL = "true"; # googlebot user-agent from Google IP range
        } else {
            set req.http.X-CRWL = "false"; # user-agent claims googlebot, but is outside Google's IP range
        }

    } else if (client.ip ~ crawlers) { # this list excludes Googlebot
        set req.http.X-CRWL = "true";

    } else {
        set req.http.X-CRWL = "false";
    }
}
