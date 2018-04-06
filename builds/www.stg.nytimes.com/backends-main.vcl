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

    // homepages, domestic and international, are NYT5
    if (   req.url ~ "^/$"
        || req.url ~ "^/\?"
        || req.url ~ "^/index.html"
    ) {
        set req.http.X-PageType = "homepage";
        set req.http.x-nyt-backend = "homepage_fe";
        set req.backend = F_homepage_fe;
        call set_www_homepage_backend_gke;
    }

    // collection application
    if (   req.url ~ "^/by/"
        || req.url ~ "^/column/"
        || req.url ~ "^/issue/"
        || req.url ~ "^/series/"
        || req.url ~ "^/news-event/"
        || req.url ~ "^/reviews/"
        || req.url ~ "^/reviews?"
        || req.url ~ "^/reviews$"
        || req.url ~ "^/saved/"
        || req.url ~ "^/saved\?"
        || req.url ~ "^/saved$"
        || req.url ~ "^/section/"
        || req.url ~ "^/spotlight/"
        || req.url ~ "^/topic/person/"
        || req.url ~ "^/topic/company/"
        || req.url ~ "^/topic/destination/"
        || req.url ~ "^/topic/organization/"
        || req.url ~ "^/topic/subject/"
        || req.url ~ "^/upshot"
    ) {
        set req.http.X-PageType = "collection";
        set req.http.x-nyt-backend = "collection_fe";
        call set_www_collection_backend_gke;
    }

    // Route slideshow to NYT5 GKE if slideshow-compatibility is not set.
    // If slideshow-compatibility is set, fallback to Legacy GKE.
    if (req.url ~ "^/slideshow/" && !req.http.x-nyt-slideshow-compatibility) {
        set req.http.X-PageType = "slideshow";
        set req.http.x-nyt-backend = "slideshow_fe";
        call set_www_slideshow_backend_gke;
    }

    // newsletter application
    if (   req.url ~ "^/newsletters/"
        || req.url ~ "^/newsletters?"
        || req.url ~ "^/newsletters$"
    ) {
        set req.http.X-PageType = "newsletter";
        set req.http.x-nyt-backend = "projectvi_fe";
        call set_projectvi_fe_backend;
    }

    // slideshow JSON files
    if (req.url ~ "\.slideshow\.json$") {
        call set_legacy_gke_backend;
    }

    // realestate application
    if (   req.url ~ "^/real-estate/"
        || req.url ~ "^/real-estate?"
        || req.url ~ "^/real-estate$"
    ) {
        set req.http.X-PageType = "real-estate";
        set req.http.x-nyt-backend = "realestate_fe";
        call set_www_realestate_backend_gke;

        # we have to pass directly here
        # so that we don't return users data.
        if (   req.url ~ "^/real-estate/api/mail"
            || req.url ~ "^/real-estate/api/personalization"
        ) {
            // We want to pass the NYT-S cookie only to the realestate backend
            // becasue of the 8k headers size limit
            set req.http.Cookie = "NYT-S=" req.http.Cookie:NYT-S ";";
            set req.http.x-nyt-force-pass = "true";
            #return(pass);
        }
    }

    // trending application
    if (   req.url ~ "^/trending/"
        || req.url ~ "^/trending?"
        || req.url ~ "^/trending$"
    ) {
        set req.http.X-PageType = "trending";
        set req.http.x-nyt-backend = "misc_fe";
        call set_nyt5_misc_backend;
    }

    // podcasts application
    if (req.url ~ "^/podcasts") {
        set req.http.X-PageType = "podcasts";
        set req.http.x-nyt-backend = "misc_fe";
        call set_nyt5_misc_backend;
    }

    // bestseller application
    if (   req.url ~ "^/books/best-sellers/"
        || req.url ~ "^/books/best-sellers?"
        || req.url ~ "^/books/best-sellers$"
    ) {
        set req.http.X-PageType = "bestseller";
        set req.http.x-nyt-backend = "misc_fe";
        call set_nyt5_misc_backend;
    }

    // collection reviews diningmap pattern is part of misc
    if (req.url ~ "^/reviews/dining/map") {
        set req.http.X-PageType = "collection";
        set req.http.x-nyt-backend = "misc_fe";
        call set_nyt5_misc_backend;
    }

    // userinfo routing (userinfo is the only svc under web-products)
    if ( req.url ~ "^/svc/web-products/") {
        set req.http.X-PageType = "service";
        set req.http.x-nyt-backend = "www_userinfo";
        call set_www_userinfo_backend;
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

    // article
    if (   req.url ~ "^/(18[5-9][0-9]|19[0-9][0-9]|20[0-9][0-9])/" // Route 1850-future
        || req.url ~ "^/(aponline|reuters)/" // wire sources
        || req.url ~ "^/blog/" // all blogposts
    ) {
        set req.http.X-PageType = "article";
        call set_www_article_backend;
    }

    if (   req.url ~ "^/newsgraphics/"
        || req.url ~ "^/projects/"
    ) {
      set req.http.X-PageType = "newsgraphics-gcs";
      set req.http.x-nyt-backend = "gcs_origin";
    }

    // Send to GCP
    if ( req.url ~ "^/svc/int/attribute/projects/" ) {
        set req.http.x-nyt-backend = "newsdev_attribute_gclod_function";
        call set_www_newsdev_attribute_gclod_function_backend;
    } else if (
           (req.url ~ "^/svc/int/" && !(req.url ~ "^/svc/int/functions/"))
        || (req.url ~ "^/interactive/projects/(notable-deaths|guantanamo)")
        || (req.url == "/fashion/runway" || req.url ~ "^/fashion/runway")
    ) {
        set req.http.X-PageType = "newsdev-gke";
        set req.http.x-nyt-backend = "newsdev_k8s_gke";
        call set_www_newsdev_gke_backend;
    }

    if ( req.url ~ "^/files/" ) {
      set req.http.X-PageType = "newsroom-files-gcs";
      set req.http.x-nyt-backend = "gcs_origin";
    }

    // vanity hostnames for blogs
    // skip glogin check
    if (   req.http.host == "beta620.nytimes.com"
        || req.http.host == "bits.nytimes.com"
        || req.http.host ~  "(www\.)?dealbook\.com$"
        || req.http.host ~  "(www\.)?dealbook\.me$"
        || req.http.host ~  "jobs\.nytco\.com$"
    ) {
        set req.http.X-PageType = "blog2";
        set req.http.x-nyt-backend = "blogs_gcs";
        set req.backend = F_blogs_gcs;
    }
    // blogs under WWW hostname
    if (   req.http.host ~ "^www\.(dev\.|stg\.|)?nytimes.com$"
        || req.http.host ~ "^(www-[a-z0-9]+\.)(dev\.|stg\.|)?nytimes.com$"
    ) {
        if (   req.url ~  "^/news/"
            || req.url ~  "^/news$"
            || req.url ~  "^/politics/first-draft"
            || req.url ~  "^/times-insider"
            || req.url ~  "^/timesjourneys"
            || req.url ~  "^/live/"
            || req.url ~  "^/live$"
        ) {
            set req.http.X-PageType = "blog";
            set req.http.x-nyt-backend = "blogs_gcs";
            set req.backend = F_blogs_gcs;
        }
    }
    // blog URLs that do not get glogin redirection
    if (req.http.X-PageType == "blog") {
        if (   req.url ~ "^/svc"
            || req.url ~ "^/timesjourneys"
            || req.url ~ "^/robots\.txt"
            || req.url ~ "/live-updates/(json|text)/"
            || req.url ~ "/renderstyle/(phone|tablet)/"
            || req.url ~ "/wp-content/"
            || req.url ~ "/feed/"
            || req.url ~ "/xml"
            || req.url ~ "\.xml"
            || req.url ~ "/json/posts"
            || req.url ~ "/blogs\.json"
            || req.url ~ "/glassjson/"
            || req.url ~ "/papijson/"
            || req.url ~ "^/premier/"
            || req.url ~ "^/premier$"
            || req.url ~ "^/live/"
            || req.url ~ "^/live$"
            || req.http.X-QueryString ~ "nytapp=(.*)"
            || req.http.host ~ "(www\.)?nytco\.com$"
        ) {
            set req.http.X-PageType = "blog2";
        }

        // Send to GCP
        // Pass those paths to newsdev gke without caching
        if ( req.url ~ "^/svc/int"
        ) {
           set req.http.X-PageType = "newsdev-gke";
           set req.http.x-nyt-backend = "newsdev_k8s_gke";
           call set_www_newsdev_gke_backend;
        }
    }

    // Lets cache some video library in fastly
    // The netscaler will send this to video at origin
    // TODO: new backend someday for it's own origin
    if ( req.url.path == "/video" || req.url.path ~ "^/video/") {
        set req.http.X-PageType = "video-library";
        call set_video_library_backend;
    }

    if ( req.url ~ "^/svc/video" ) {
        set req.http.X-PageType = "video-api";
        set req.http.x-nyt-ttl-override = "30";
        call set_video_api_backend;
    }

}

# set a video library backend based on env
sub set_video_library_backend {
    set req.http.x-nyt-backend = "video_library";
    set req.backend = F_video_library;
}

# set a video api backend based on env
sub set_video_api_backend {
    set req.http.x-nyt-backend = "video_api";
    set req.backend = F_video_api;
}

sub set_legacy_gke_backend {
    set req.http.X-PageType = "legacy-gke";
    set req.http.x-nyt-backend = "www_legacy_gke";
    set req.backend = F_www_legacy_gke;
}

## userinfo backend
sub set_www_userinfo_backend {
    set req.backend = F_www_userinfo;
    call vi_ce_auth;
    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}

# set backend for each NYT5 app to prepare GKE migration
# first step is to separate backend per each app
sub set_www_collection_backend_gke {
    set req.backend = F_collection_fe;
    call vi_ce_auth;
    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}

# set backend for each NYT5 app to prepare GKE migration
# first step is to separate backend per each app
sub set_www_article_backend {
    set req.http.x-nyt-backend = "article_fe";
    set req.backend = F_article_fe;
    call vi_ce_auth;

    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}

# set backend for each NYT5 app to prepare GKE migration
# first step is to separate backend per each app
sub set_www_slideshow_backend_gke {
    set req.backend = F_slideshow_fe;
    call vi_ce_auth;
    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}
# set backend for each NYT5 app to prepare GKE migration
# first step is to separate backend per each app
sub set_www_misc_backend_gke {
    set req.backend = F_misc_fe;

    call vi_ce_auth;

    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}
sub set_nyt5_misc_backend {
    call set_www_misc_backend_gke;
}

# set backend for nyt5 homepage migration
sub set_www_homepage_backend_gke {
    call vi_ce_auth;

    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}

sub set_www_realestate_backend_gke {
    set req.backend = F_realestate_fe;

    call vi_ce_auth;

    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}

sub set_www_newsdev_gke_backend {
    set req.backend = F_newsdev_k8s_gke;
}

sub set_www_newsdev_attribute_gclod_function_backend {

    set req.backend = F_newsdev_attribute_gclod_function;

    if(req.http.x-environment == "dev" || req.http.x-environment == "stg") {
      set req.http.x-cf-host = "us-central1-nytint-stg.cloudfunctions.net";
    } else {
      set req.http.x-cf-host = "us-central1-nytint-prd.cloudfunctions.net";
    }
}

sub vi_ce_auth {
    if(req.http.x-environment == "prd") {
        set req.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_prd");
    } else {
        set req.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_stg");
    }
}
