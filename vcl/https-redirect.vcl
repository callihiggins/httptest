sub recv_https_redirect {
    /*
     * Items that are HTTPS internally only but not assigned to a phase
     */
    if ( req.http.x-nyt-route == "blog" ) {

        set req.http.var-nyt-https-phase = "internal";
    }

    /*
     * Items permanently on HTTPS
     */
    if (   req.http.x-nyt-route == "homepage"
        || ( req.http.x-nyt-route == "article"
            && req.url ~ "^/(18[5-9][0-9]|19[0-9][0-9]|20[0-9][0-9])/") // Route 1850-future
        || ( req.http.x-nyt-route == "article" && req.url ~ "^/(aponline|reuters)/" ) // wire sources
        || ( req.http.x-nyt-route == "blog" && req.http.host !~ "^tmagazine\.blogs" ) // all blogs, but not tmag
        || ( req.http.x-nyt-route == "blog-legacy" && req.http.host !~ "(nytco|dealbook|(n(ew)?y(ork)?)?t(imes)?journeys).(com|me)" )
        || req.http.x-nyt-route == "collection"
        || req.http.x-nyt-route == "amp"
        || req.http.x-nyt-route == "vi-collection"
        || req.http.x-nyt-route == "video-offsite-player"
        || req.url ~ "^/projects/2020-report/"
        || req.url ~ "^/content/help"             // help pages
        || req.http.x-nyt-route ~ "^watching"
        || req.http.x-nyt-route == "intl"  // espanol/international
        || req.http.x-nyt-route == "newsdev-gke"   // interative news
        || req.http.x-nyt-route == "newsdev-gcs"   // interative news
        || req.http.x-nyt-route == "newsdev-attribute"   // interative news
        || req.http.x-nyt-route == "newsdev-cloud-functions"   // interative news
        || req.http.x-nyt-route == "newsroom-files-gcs"   // newsroom digital transition
        || req.http.x-nyt-route == "tips-html-gcs"   // tips html page
        || req.http.x-nyt-route == "guides"          // beta - well guides
        || req.http.x-nyt-route == "trending"
        || req.http.x-nyt-route == "bestseller"
        || req.url ~ "^/(arts|politics|health)"
        || req.http.x-nyt-route == "real-estate"
        || req.url ~ "^/crosswords" // games pages, except for /ref/crosswords
        || req.http.x-nyt-route == "recommendations"
        || req.http.x-nyt-route == "times-journeys"
        || req.http.x-nyt-route == "times-journeys-students"
        || req.http.x-nyt-route == "askwell"
        || req.http.x-nyt-route == "vi-assets"
        || req.http.x-nyt-route == "vi-bestsellers"
        || req.http.x-nyt-route == "vi-story"
        || req.http.x-nyt-route == "vi-weekender"
        || req.http.x-nyt-route == "vi-search"
        || req.http.x-nyt-route == "vi-timeswire"
        || req.http.x-nyt-route == "vi-weddings"
        || req.http.x-nyt-route == "vi-info"
        || req.http.x-nyt-route == "vi-code"
        || req.http.x-nyt-route == "vi-refer"
        || req.http.x-nyt-route == "vi-video"
        || req.http.x-nyt-route == "gdpr-form"
        || req.http.x-nyt-route == "vi-interactive"
        || req.http.x-nyt-route == "interactive-s3-failover"
        || req.http.x-nyt-route == "ads-static-assets"
        || req.http.x-nyt-route == "elections"
        || ( req.http.x-nyt-route == "newsgraphics-gcs"
                && req.url ~ "^/newsgraphics/2(01[7-9]|(0[2-9][0-9])|([1-9][0-9][0-9]))" )// 2017 - future
        || req.http.x-nyt-route == "games-web"
        || req.http.x-nyt-route == "games-assets"
        || req.http.x-nyt-route == "games-service"
        || req.http.x-nyt-route == "games-phoenix"
        || req.http.x-nyt-route == "vi-paidpost"
        || req.http.x-nyt-route == "programs-service"
        || req.http.x-nyt-route == "shaq-service"
        || req.http.x-nyt-route == "programs-gcs"
        || req.http.x-nyt-route == "video-media"
        || req.http.x-nyt-route == "adx-static"
        || req.http.x-nyt-route == "add-svc"
        || req.http.x-nyt-route == "vi-slideshow"
        || req.http.x-nyt-route == "audio"
        || req.http.x-nyt-route == "ask"
        || req.http.x-nyt-route == "tbooks"
        || req.http.x-nyt-route == "tbooks-pass"
        || req.url ~ "^/live/20(19|[2-9][0-9])" // 2019 - future
        || req.url ~ "^/newsletters"
        || req.url ~ "^/(js|js2|css|bi)/"
        || req.url ~ "^/packages/images/email/" // newsletters
        || req.url.path == "/interactive/us/faces-of-the-dead.html" // special 9/11 interactive
        || req.url.path == "/cookie-policy"
        || req.url.path == "/robots.txt"
        || req.http.x-nyt-route == "sitemap"
        || req.http.x-nyt-route == "new_sitemap"
        || req.http.x-nyt-route == "vi-get-started"
        || req.http.x-nyt-route == "vi-code"
        || req.url.path == "/BingSiteAuth.xml"
        || req.url ~ "^/(digital|hdleftnav|subscribe|homedelivery|edu|gift|redeem|college|professor|student|campus)" //CMOTS-referrer-issue-fix
    ) {
        set req.http.var-nyt-https-phase = "live";
    }

    // IS a HTTPS connection
    if (req.http.Fastly-SSL) {

        // whitelist of URIs that must be supported via both HTTP and HTTPS
        if (   req.url ~ "^/svc/"
            || req.url ~ "^/content/help/itunes/privacy-policy.html"
            || req.url ~ "^/content/help/rights/privacy/policy/privacy-policy.html"
            || req.url ~ "^/apple-app-site-association"
            || req.url ~ "^/google34e0037c9fda7c66.html"
            || req.url ~ "^/adx/"
            || req.url ~ "^/store"
            || req.url ~ "^/auth/hdlogin"
            || req.url ~ "^/membercenter/emailus.html"
            || req.url ~ "^/gst/emailus.html"
            || req.url ~ "^/subscription"
            || req.url ~ "^/services/xml/rss"
            || req.url ~ "^/regilite"
            || req.url ~ "^/newsletters/regilite"
            || req.url ~ "^/wrapper.html"
            || req.url ~ "^/newsgraphics/2016/news-tips"
            || req.url ~ "^/tips(/)?(\?.*)?$"
            || req.url.path ~ "^/.well-known/" // https://tools.ietf.org/html/rfc5785
            || req.url ~ "^/es/wp-json/nyt/"
            || req.url ~ "^/mem/email-this.html"
            || req.url ~ "^/packages/html/mobile/"
            || req.url ~ "^/interactive/.*([0-9]+).embedded.html"
            || req.url ~ "^/export_html/common/new_login_iframe.html"
            || req.url ~ "^/glogin"
            || req.url ~ "^/help"
            || req.url ~ "^/pages/"  // NYT4 sectionfronts
            || req.url ~ "^/sitemap_news.xml.gz"
            || req.url ~ "^/nyt/rss/"
            || req.url ~ "^/timeswire/feeds/"
            || req.url ~ "^/podcasts"
            || req.url ~ "^/movies"
            || req.url.path ~ "^/images/"
            || req.url.path == "/esi/jsonp-callback"
            || req.http.x-nyt-route ~ "^mwcm"
            # content that was previously passing early can do both protocols
            || req.http.var-nyt-force-pass == "true"
            || req.url.path == "/favicon.ico"
        ) {

        // Urls already live over HTTPS
        } else if (req.http.var-nyt-https-phase == "live") {

        // Urls live over HTTPS internally
        } else if (
               req.http.x-nyt-nyhq-access == "1"
            && req.http.var-nyt-https-phase == "internal"
            && !req.http.var-cookie-nyt-np-internal-https-opt-out
        ) {

        // internal https cookie-based test
        } else if (
               req.http.x-nyt-nyhq-access == "1"
            && req.http.var-cookie-np-enable-https == "1"
            && !req.http.var-cookie-nyt-np-internal-https-opt-out
        ) {

        // if not in the above categories, redirect to http
        } else {
            call redirect_to_http;
        }

    // NOT a HTTPS connection
    } else {
        // MUST be over HTTPS
        if (   req.url ~ "^/store"
            || req.url ~ "^/auth/hdlogin"
            || req.url ~ "^/membercenter/emailus.html"
            || req.url ~ "^/gst/emailus.html"
            || req.url ~ "^/newsgraphics/2016/news-tips"
            || req.url ~ "^/tips(/)?(\?.*)?$"
        ) {
            call redirect_to_https;

        // Urls that are on HTTPS internally
        } else if (
            req.http.x-nyt-nyhq-access == "1"
            && req.request != "FASTLYPURGE"
            && req.http.var-nyt-https-phase == "internal"
            && !req.http.var-cookie-nyt-np-internal-https-opt-out
        ) {
            call redirect_to_https;

        // URLs that are launched on HTTPS should redirect to HTTPS
        } else if ( req.http.var-nyt-https-phase == "live" && req.request != "FASTLYPURGE" ) {
            call redirect_to_https;

        // internal https cookie-based test
        } else if (
               req.http.x-nyt-nyhq-access == "1"
            && req.http.var-cookie-np-enable-https == "1"
            && !req.http.var-cookie-nyt-np-internal-https-opt-out
        ) {
            call redirect_to_https;

        }
    }
}

sub error_770_perform_301_redirect {
    if (obj.status == 770) {
        set obj.http.Location = obj.response;
        set obj.status = 301;
        set obj.response = "Moved Permanently";
        set obj.http.X-API-Version = "0";
        return(deliver);
    }
}

sub redirect_to_http {
    declare local var.redirect_target STRING;
    set var.redirect_target = "http://" + req.http.host + req.url.path + req.http.x-nyt-orig-querystring;
    set req.http.var-nyt-redirect-reason = "redir=[http]";
    error 770 var.redirect_target;
}

sub redirect_to_https {
    declare local var.redirect_target STRING;
    set var.redirect_target = "https://" + req.http.host + req.url.path + req.http.x-nyt-orig-querystring;
    set req.http.var-nyt-redirect-reason = "redir=[https]";
    error 770 var.redirect_target;
}
