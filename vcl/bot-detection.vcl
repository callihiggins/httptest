sub recv_bot_detection {

    # no origin apps are using the X-CRWL request header
    # set to an internal var so it can be used by logic

    if (req.http.user-agent ~ "(?i)googlebot|mediapartners-google|adsbot-google|amphtml|developers\.google\.com/\+/web/snippet/") {
        # Googlebot user-agents: https://support.google.com/webmasters/answer/1061943

        if (client.ip ~ googlebot) {
            # TODO: replace with https://support.google.com/webmasters/answer/80553?hl=en
            # and libvmod-dns
            set req.http.var-nyt-is-crawler = "1"; # googlebot user-agent from Google IP range
        } else {
            set req.http.var-nyt-is-crawler = "0"; # user-agent claims googlebot, but is outside Google's IP range
        }

    } else if (client.ip ~ crawlers) { # this list excludes Googlebot
        set req.http.var-nyt-is-crawler = "1";

    } else {
        set req.http.var-nyt-is-crawler = "0";
    }
}
