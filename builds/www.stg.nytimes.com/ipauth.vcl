sub vcl_recv {

    // IPs that are blocked from all environments
    if (client.ip ~ blacklist) {
        error 403 "Forbidden";
    }

    // block everyone but the internal ACL to dev service
    if (req.http.x-environment == "dev" && !req.http.x-nyt-internal-access && !req.http.x-nyt-external-access) { //this req.http.x-nyt-external-access header is sharing with both watching app and the drone's access to fastly tests image, is this fine to add this? will this cause any error on the watching side?
      error 403 "Forbidden";
    }

    // block everyone but internal acl, aws vpc acl, staging access acl, and whitelisted header to staging service
    if (req.http.x-environment == "stg" && !req.http.x-nyt-internal-access && !req.http.x-nyt-external-access) {
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