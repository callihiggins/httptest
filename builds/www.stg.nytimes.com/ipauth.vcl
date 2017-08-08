# use keys in x-fastly-stg header for staging access from non-whitelisted IPs
table staging_access_tokens {
  # "app-<random>" : "<issue date>"
  "watching-2gk6" : "20170614"
}

sub vcl_recv {


    // IPs that are blocked from all environments
    if ( client.ip ~ blacklist) {
        error 403 "Forbidden";
    }

    // block everyone but the internal ACL to dev service
    if ( client.ip !~ internal && req.http.x-environment == "dev") {
      error 403 "Forbidden";
    }

    // block everyone but internal acl, aws vpc acl, staging access acl, and whitelisted header to staging service
    if (    req.http.x-environment == "stg" &&
            client.ip !~ internal &&
            client.ip !~ vpc_nat_gateway &&
            client.ip !~ external_staging_access &&
            (table.lookup(staging_access_tokens, req.http.x-fastly-stg) !~ "^[0-9]{8}$") ) {
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
