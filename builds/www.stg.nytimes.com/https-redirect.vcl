sub vcl_recv {
    /*
     * Items that are HTTPS internally only but not assigned to a phase
     */
    if (   req.http.X-PageType == "blog"
        || req.url ~ "^/newsletters"
    ) {
        set req.http.x-https-phase = "internal";
    }

    /*
     * Items permanently on HTTPS
     */
    if (   req.http.X-PageType == "homepage"
        || ( req.http.X-PageType == "article"
                && req.url ~ "^/2(01[4-9]|(0[2-9][0-9])|([1-9][0-9][0-9]))" ) // 2014 - future
        || ( req.http.X-PageType == "article" && req.url ~ "^/(aponline|reuters)/" ) // wire sources
        || ( req.http.X-PageType == "blog" && req.http.host !~ "^tmagazine\.blogs" ) // all blogs, but not tmag
        || ( req.http.X-PageType == "blog2" && req.http.host !~ "(nytco|dealbook|(n(ew)?y(ork)?)?t(imes)?journeys).(com|me)" )
        || req.http.X-PageType == "collection"
        || req.http.X-PageType == "video-library"
        || req.http.X-PageType == "podcasts"
        || ( req.http.X-PageType == "interactive"
                && req.url ~ "^/interactive/2(01[4-9]|(0[2-9][0-9])|([1-9][0-9][0-9]))" )// 2014 - future
        || req.url ~ "^/projects/2020-report/"
        || req.url ~ "^/content/help"             // help pages
        || req.http.X-PageType ~ "^watching"
        || req.http.X-PageType == "newsdev-intl"  // espanol/international
        || req.http.X-PageType == "newsdev-gke"   // interative news
        || req.http.X-PageType == "well"          // beta - well guides
        || req.http.X-PageType == "trending"
        || req.http.X-PageType == "bestseller"
        || req.url ~ "^/pages/(politics|opinion|world|dining)"        // NYT4 sectionfronts
        || req.http.X-PageType == "real-estate"
        || req.url ~ "^/crosswords" // games pages, except for /ref/crosswords
        || req.url.path == "/recommendations"
        || req.url.path ~ "^/.well-known/" // https://tools.ietf.org/html/rfc5785
        || req.http.X-PageType == "times-journeys"
        || req.http.X-PageType == "times-journeys-students"
        || req.http.X-PageType == "askwell"
        || req.http.X-PageType == "vi-asset"
        || req.url ~ "^/ads/RE/"
    ) {
        set req.http.x-https-phase = "live";
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
            || req.url ~ "^/tips(/)?$"
            || req.url == "/securedrop"
            || req.url ~ "^/es/wp-json/nyt/"
            || req.url ~ "^/mem/email-this.html"
            || req.url ~ "^/packages/html/mobile/"
            || req.url ~ "^/interactive/.*([0-9]+).embedded.html"
            || req.url ~ "^/export_html/common/new_login_iframe.html"
            || req.url ~ "^/ads/AdCade/adcadebuster.html"
            || req.url ~ "^/ads/AdGear/iframe_placement.html"
            || req.url ~ "^/ads/adtech/iframeproxy.html"
            || req.url ~ "^/ads/checkm8/CM8IframeBuster_v2.html"
            || req.url ~ "^/ads/doubleclick/DARTIframe.html"
            || req.url ~ "^/ads/eyeblaster/addineyeV2.html"
            || req.url ~ "^/ads/flashtalking/ftlocal.html"
            || req.url ~ "^/ads/Flite/fif.html"
            || req.url ~ "^/ads/flite/flight.html"
            || req.url ~ "^/ads/interpolls/cachebuster.html"
            || req.url ~ "^/ads/Interpolls/pub_interpolls.html"
            || req.url ~ "^/ads/Jivox/Jivoxibuster.html"
            || req.url ~ "^/ads/linkstorm/linkstorm_nyt_bridge.html"
            || req.url ~ "^/ads/mediaplex/mojofb_v9.html"
            || req.url ~ "^/ads/mediaplex/mojofb_v9-4.html"
            || req.url ~ "^/ads/pickle/eval_banner.html"
            || req.url ~ "^/ads/pickle/eval_banner_v3.html"
            || req.url ~ "^/ads/Spongecell/spongecell_iframe_buster.html"
            || req.url ~ "^/ads/Weborama/adrime_burst_2_0_0.htm"
            || req.url ~ "^/glogin"
        ) {

        // Urls already live over HTTPS
        } else if (req.http.x-https-phase == "live") {

        // Urls live over HTTPS internally
        } else if (
               client.ip ~ internal
            && req.http.x-https-phase == "internal"
            && !req.http.x-internal-https-opt-out
        ) {

        // internal https cookie-based test
        } else if (
               client.ip ~ internal
            && req.http.x-nyt-np-enable-https == "1"
            && !req.http.x-internal-https-opt-out
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
            || req.url ~ "^/tips(/)?$"
            || req.url == "/securedrop"
        ) {
            call redirect_to_https;

        // Urls that are on HTTPS internally
        } else if (
            client.ip ~ internal
            && req.request != "FASTLYPURGE"
            && req.http.x-https-phase == "internal"
            && !req.http.x-internal-https-opt-out
        ) {
            call redirect_to_https;

        // URLs that are launched on HTTPS should redirect to HTTPS
        } else if ( req.http.x-https-phase == "live" && req.request != "FASTLYPURGE" ) {
            call redirect_to_https;

        // internal https cookie-based test
        } else if (
               client.ip ~ internal
            && req.http.x-nyt-np-enable-https == "1"
            && !req.http.x-internal-https-opt-out
        ) {
            call redirect_to_https;

        }
    }

}

sub vcl_error {
    if (obj.status == 443) {
        set obj.http.Location = obj.response;
        set obj.status = 301;
        set obj.response = "Moved Permanently";
        set obj.http.X-API-Version = "0";
        return(deliver);
    }
}

sub redirect_to_http {
    set req.http.x-Redir-Url = "http://" + req.http.host + req.url;
    error 443 req.http.x-Redir-Url;
}

sub redirect_to_https {
    set req.http.x-Redir-Url = "https://" + req.http.host + req.url;
    error 443 req.http.x-Redir-Url;
}
