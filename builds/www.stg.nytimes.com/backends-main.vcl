sub vcl_recv {

    // use X-Host header, if present
    if ( req.http.X-Host ) {
        set req.http.host = req.http.X-Host;
    }

    // default is WWW Legacy GKE
    set req.http.x-nyt-backend = "www_legacy_gke";
    call set_legacy_gke_backend;

    set req.http.X-PageType = "legacy-gke";

    // entire paidpost hostname is NYT5
    if (req.http.host ~ "^paidpost([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$"
        && req.url.ext == "html") {
        set req.http.X-PageType = "paidpost";
        set req.http.x-nyt-backend = "paidpost_fe";
        set req.backend = F_paidpost_fe;
        call vi_ce_auth;
    }

    // route the path's below to Legacy WWW GKE
    if ( req.url ~ "^/favicon.ico"
        || req.url ~ "^/(js|js2|css|bi)/"
        || req.url ~ "^/svc/comscore/"
        || req.url ~ "^/svc/web/"
        || req.url ~ "^/robots.txt"
        || req.url ~ "^/crossdomain.xml"
        || req.url ~ "^/.well-known/"
        || req.url ~ "^/apple-app-site-association"
        || req.url ~ "^/ap/"
        || req.url ~ "^/cfr/"
        || req.url ~ "^/classifieds/"
        || req.url ~ "^/college/"
        || req.url ~ "^/cwire/"
        || req.url ~ "^/external/"
        || req.url ~ "^/features/"
        || req.url ~ "^/fodors/"
        || req.url ~ "^/frommers/"
        || req.url ~ "^/gift-guide/"
        || req.url ~ "^/gwire/"
        || req.url ~ "^/imagepages/"
        || req.url ~ "^/indexes/"
        || req.url ~ "^/learning/"
        || req.url ~ "^/library/"
        || req.url ~ "^/pages/"
        || req.url ~ "^/packages/"
        || req.url ~ "^/services/xml/rss/"
        || req.url ~ "^/specials/"
        || req.url ~ "^/sports/"
        || req.url ~ "^/top/"
        || req.url ~ "^/travel/"
        || req.url ~ "^/webapps/"
        || req.url ~ "^/your-money/"
        || req.url ~ "^/travel"
        || req.url ~ "^/recipes"
        || req.url ~ "^/most-popular" # for most-popular, most-popular-emailed, most-popular-viewed
        || req.url ~ "^/technology/personaltech/"
        || req.url ~ "^/keyword/"
        || req.url ~ "^/gst/tmagazine/video"
        || req.url ~ "^/svc/movies/"
        || req.url ~ "^/premium/"
        || req.url ~ "^/events"
        || req.url ~ "^/mem/theater/"
        || req.url ~ "^/gst/theater/"
        || req.url ~ "^/tv"
        || req.url ~ "^/health/guides"
        || req.url ~ "^/RealMedia"
        || req.url ~ "^/guests/"
        || req.url ~ "^/new/"
        || req.url ~ "^/admin/"
        || req.url ~ "^/administrator/"
        || req.url ~ "^/allbusiness/"
        || (req.url ~ "^/books/" && req.url !~ "^/books/best-sellers") #books but not best sellers
        || req.url ~ "^/rss/"
        || req.url ~ "^/nyt/rss/HomePage"
        || req.url ~ "^/sports"
        || req.url ~ "^/logout"
        || req.url ~ "^/hdleftnav"
        || (req.url ~ "^/membercenter" && req.url !~ "^/membercenter/emailus.html")
        || req.url ~ "^/thedailyoffer"
        || req.url ~ "^/ref/"
        || req.url ~ "^/movie/"
        || req.url ~ "^/export_html/common/new_login_iframe.html"
        || req.url ~ "^/mem/email-this.html"
        || req.url ~ "^/gst/movies/"
        || req.url ~ "^/websvc"
        || req.url ~ "^/js/nyt5/ab/abconfig.json"
    ) {
        call set_legacy_gke_backend;
        unset req.http.Cookie;
        unset req.http.X-Cookie;
    }

    // hostnames fastly doesn't serve go to www backend for a pass
    if (   req.http.host !~ "^(www\.)?(dev\.|stg\.|)?nytimes.com$"
        && req.http.host !~ "^(www-[a-z0-9]+\.)(dev\.|stg\.|)?nytimes.com$"
        && req.http.host !~ "^international\.(dev\.|stg\.|)?nytimes.com$"
        && req.http.host !~ "^feeds1?\.(dev\.|stg\.|)?nytimes.com$"
        && req.http.host !~ "^paidpost([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$"
    ) {
        call set_legacy_gke_backend;
    }
}

sub set_legacy_gke_backend {
    set req.http.X-PageType = "legacy-gke";
    set req.http.x-nyt-backend = "www_legacy_gke";
    set req.backend = F_www_legacy_gke;
}

sub vi_ce_auth {
    if(req.http.x-environment == "prd") {
        set req.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_prd");
    } else {
        set req.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_stg");
    }
}
