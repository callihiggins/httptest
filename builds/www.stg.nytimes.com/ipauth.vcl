include "acl-crawlers";

sub vcl_recv {

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
