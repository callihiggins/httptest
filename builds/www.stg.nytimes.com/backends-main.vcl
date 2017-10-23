sub vcl_recv {
#FASTLY recv

    // use X-Host header, if present
    if ( req.http.X-Host ) {
        set req.http.host = req.http.X-Host;
    }

    // default is NYT4
    call set_www_backend;

    set req.http.X-PageType = "legacy";

    // entire paidpost hostname is NYT5
    if (req.http.host ~ "^paidpost([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$"
        && req.url.ext == "html") {
        set req.http.X-PageType = "paidpost";
        call set_www_paidpost_backend;
    }

    // homepages, domestic and international, are NYT5
    if (   req.url ~ "^/$"
        || req.url ~ "^/\?"
        || req.url ~ "^/index.html"
    ) {
        set req.http.X-PageType = "homepage";
        call set_www_fe_backend;
        set req.http.x-skip-glogin = "1";
    }

    // set the https backend for routes that require it
    if (   req.url ~ "^/svc/"
        || req.url ~ "^/content/help/itunes/privacy-policy.html"
        || req.url ~ "^/content/help/rights/privacy/policy/privacy-policy.html"
        || req.url ~ "^/apple-app-site-association"
        || req.url ~ "^/google34e0037c9fda7c66.html"
        || (req.url ~ "^/adx/" && req.http.x-environment == "prd")
        || req.url ~ "^/store"
        || req.url ~ "^/auth/hdlogin"
        || req.url ~ "^/membercenter/emailus.html"
        || req.url ~ "^/gst/emailus.html"
        || req.url ~ "^/subscriptions"
        || req.url ~ "^/services/xml/rss"
        || req.url ~ "^/tips(/)?(\?.*)?$"
        || req.url == "/securedrop"
        || req.url ~ "^/newsgraphics/2016/news-tips"

    ) {
        set req.http.x-PageType = "legacy";
        call set_www_https_backend;
        set req.http.x-skip-glogin = "1";
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
        call set_www_collection_backend_gke;
        set req.http.x-skip-glogin = "1";
    }

    // newsletter application
    if (   req.url ~ "^/newsletters/"
        || req.url ~ "^/newsletters?"
        || req.url ~ "^/newsletters$"
    ) {
        set req.http.X-PageType = "newsletter";
        call set_www_newsletter_backend;
        set req.http.x-skip-glogin = "1";
    }

    // slideshow application
    if (   req.url ~ "^/slideshow/20(1[4-9]|[2-9][0-9])/"
        || req.url ~ "^/slideshow/20(1[1-9]|[2-9][0-9])/[0-9][0-9]/[0-9][0-9]/fashion/runway-(couture|mens|womens)/"
        || (req.url ~ "^/slideshow/" && req.http.x-environment == "stg")
    ) {
        set req.http.X-PageType = "slideshow";
        call set_www_slideshow_backend;
    }

    // slideshow JSON files
    if (req.url ~ "\.slideshow\.json$") {
        set req.http.X-PageType = "slideshow-legacy";
        call set_www_backend;
    }

    // realestate application
    if (   req.url ~ "^/real-estate/"
        || req.url ~ "^/real-estate?"
        || req.url ~ "^/real-estate$"
        || req.url ~ "^/section/realestate/commercial"
    ) {
        set req.http.X-PageType = "real-estate";
        # set this to www instead of www_fe_vert so that it will PASS for now
        call set_www_backend;
        set req.http.x-skip-glogin = "1";
    }

    // trending application
    if (   req.url ~ "^/trending/"
        || req.url ~ "^/trending?"
        || req.url ~ "^/trending$"
    ) {
        set req.http.X-PageType = "trending";
        call set_www_misc_backend;
        set req.http.x-skip-glogin = "1";
    }

    // podcasts application
    if (req.url ~ "^/podcasts") {
        set req.http.X-PageType = "podcasts";
        call set_www_misc_backend;
    }

    // bestseller application
    if (   req.url ~ "^/books/best-sellers/"
        || req.url ~ "^/books/best-sellers?"
        || req.url ~ "^/books/best-sellers$"
    ) {
        set req.http.X-PageType = "bestseller";
        call set_www_misc_backend;
    }

    // collection reviews diningmap pattern is part of misc
    if (req.url ~ "^/reviews/dining/map") {
        set req.http.X-PageType = "collection";
        call set_www_misc_backend;
    }

    if (req.url ~ "^/404\.html") {
        set req.http.X-PageType = "miscellany";
        call set_www_fe_backend;
    }

    // NYT5 services EXCEPT userinfo
    if (   req.url ~ "/.status$"
        || (req.url ~ "^/svc/web-products/"
            && req.url !~ "^/svc/web-products/userinfo")
    ) {
        set req.http.X-PageType = "service";
        call set_www_fe_backend;
        set req.http.x-skip-glogin = "1";
    }

    // hostnames fastly doesn't serve go to www backend for a pass
    if (   req.http.host !~ "^(www\.)?(dev\.|stg\.|)?nytimes.com$"
        && req.http.host !~ "^(www-[a-z0-9]+\.)(dev\.|stg\.|)?nytimes.com$"
        && req.http.host !~ "^international\.(dev\.|stg\.|)?nytimes.com$"
        && req.http.host !~ "^feeds1?\.(dev\.|stg\.|)?nytimes.com$"
        && req.http.host !~ "^paidpost([\-a-z0-9]+)?\.(dev\.|stg\.)?nytimes.com$"
    ) {
        set req.http.X-PageType = "legacy-override";
        call set_www_backend;
    }

    // article
    if (   //req.url ~ "^/2(00[7-9]|(0[1-9][0-9])|([1-9][0-9][0-9]))/" // 2007-future
            req.url ~ "^/2(01[4-9]|(0[2-9][0-9])|([1-9][0-9][0-9]))" // 2014-future
        || req.url ~ "^/200[4-5]/" // 2004-2005
        || req.url ~ "^/197[0-9]/" // 1970-1979
        || req.url ~ "^/1964/" // 1964
        || req.url ~ "^/1959/" // 1959
        || req.url ~ "^/(aponline|reuters)/" // wire sources
        || req.url ~ "^/blog/" // all blogposts
        || req.url ~ "^/2001/01/20/technology/20ANNIVERSARY.html" // WP-16051
        || req.url ~ "^/2001/01/20/technology/the-new-york-times-five-years-on-the-web.html" // WP-16051
        || req.url ~ "^/2006/01/29/fashion/sundaystyles/29LOVE.html" // WP-16010
        || req.url ~ "^/2006/02/26/fashion/sundaystyles/26LOVE.html" // WP-16010
        || req.url ~ "^/2006/11/12/fashion/12love.html" //WP-18092
    ) {
        set req.http.X-PageType = "article";
        if ( req.http.X-Article-Backend == "article-GKE" ) {
            call set_www_article_backend_gke;
        } else {
            call set_www_article_backend;
        }
    }

    // Send to GCP
    if ( req.url ~ "^/svc/int/qa" ) {
        call set_ask_well_backend;
    } else if ( req.http.x-environment == "stg" && req.url ~ "^/svc/int/attribute" ) {
      set req.http.X-PageType = "newsdev-attribute-cloud-function";
      set req.http.X-OldURL = req.url;
      set req.url = regsub(req.url, "^/svc/int/attribute/projects/([^/]+)/submissions.json", "/attribute-submission/\1");
      set req.http.x-skip-glogin = "1";
      call set_www_newsdev_attribute_gclod_function_backend;
    } else if (    req.url ~ "^/svc/int/"
        || (req.url ~ "^/interactive/projects/(notable-deaths|guantanamo)")
        || (req.url == "/fashion/runway" || req.url ~ "^/fashion/runway")
    ) {
        set req.http.X-PageType = "newsdev-gke";
        set req.http.x-skip-glogin = "1";
        call set_www_newsdev_gke_backend;
    }

    if ((req.url == "/es") || (req.url ~ "^/es/")
        || (req.url == "/global") || (req.url ~ "^/global/")) {
        set req.http.X-PageType = "intl";
        set req.http.x-skip-glogin = "1";
        call set_www_intl_backend;
    }

    // interactive years 2014-forever are NYT5/Vi
    if (req.url ~ "^/interactive/20(1[4-9]|[2-9][0-9])/") {
      // keep .embedded/mobile/app.html on NYT5 in production
      if (req.http.x-environment == "prd"
      &&  req.url.path ~ "\.(embedded|mobile|app)\.html$") {
        set req.http.X-PageType = "interactive";
        call set_www_fe_backend;
      } else {
          set req.http.X-PageType = "vi-interactive";
          call set_projectvi_fe_backend;
      }
    }

    // embedded interactives on mobile should not go to glogin
    if (req.url ~ "^/interactive/.*([0-9]+).embedded.html") {
        set req.http.x-skip-glogin = "1";
    }

    // blogs
    if (   req.http.host == "dealbook.nytimes.com"
        || req.http.host == "developers.nytimes.com"
        || req.http.host ~  "(blogs|blogs5)\.(dev\.|stg\.|)?nytimes\.com$"
        || req.http.host ~  "(blogs|blogs5)\.ewr1.nytimes\.com$"
        || req.http.host ~  "(www\.)?nytco\.com$"
    ) {
        set req.http.X-PageType = "blog";
        call set_blogs_fe_backend;
    }
    // vanity hostnames for blogs
    // skip glogin check
    if (   req.http.host == "beta620.nytimes.com"
        || req.http.host == "bits.nytimes.com"
        || req.http.host == "lessonplans.nytimes.com"
        || req.http.host == "open.nytimes.com"
        || req.http.host ~  "(www\.)?dealbook\.com$"
        || req.http.host ~  "(www\.)?dealbook\.me$"
        || req.http.host ~  "(www\.)?nytimesjourneys\.com$"
        || req.http.host ~  "(www\.)?nytjourneys\.com$"
        || req.http.host ~  "(www\.)?timesjourneys\.com$"
        || req.http.host ~  "(www\.)?newyorktimesjourneys\.com$"
        || req.http.host ~  "jobs\.nytco\.com$"
    ) {
        set req.http.X-PageType = "blog2";
        call set_blogs_fe_backend;
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
            call set_www_fe_backend;
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
            set req.http.x-skip-glogin = "1";
        }

        // Send to GCP
        if (    req.http.host ~ "^well\.blogs\.(dev\.|stg\.)?nytimes\.com"
            && (    req.url ~ "^/ask/well/"
                ||  req.url ~ "^/svc/int/qa"
            )
        ) {
            call set_ask_well_backend;
        // Pass those paths to newsdev gke without caching
        } else if ( req.url ~ "^/projects"
                 || req.url ~ "^/svc/int"
        ) {
           set req.http.X-PageType = "newsdev-gke";
           set req.http.x-skip-glogin = "1";
           call set_www_newsdev_gke_backend;
        }
    }

    // Lets cache some video library in fastly
    // The netscaler will send this to video at origin
    // TODO: new backend someday for it's own origin
    if ( req.url == "/video" || req.url ~ "^/video/") {
        set req.http.X-PageType = "video-library";
        set req.http.x-skip-glogin = "1";
        call set_www_fe_backend;
    }

    if ( req.url ~ "^/svc/video" ){
        set req.http.X-PageType = "video-api";
        set req.http.x-skip-glogin = "1";
        call set_www_fe_backend;
    }

    // send global messaging API to the backend that caches
    if (req.url ~ "^/svc/message/v1/list/global.json") {
        set req.http.X-PageType = "messaging-api";
        set req.http.x-skip-glogin = "1";
        call set_www_fe_backend;
    }

    # if the cmd ~= GetCommentsAll, GetCommentSummary, GetUserCommentSummary, GetCommentsReadersPicks, GetCommentsNYTPicks, GetCommentsNYTReplies
    # but NOT GetBasicInfo
    # and if the user is anon / guest cookie
    if ( req.url ~ "^/svc/community" ) {

        if (req.url ~ "cmd=Get((?!BasicInfo)[^&]+)"
            && (!req.http.x-nyt-s || req.http.x-nyt-s ~ "^0")) {

            unset req.http.x-community-callback;

            set req.http.X-PageType = "community-svc-cacheable";
            set req.http.x-skip-glogin = "1";
            call set_www_fe_backend;

            # sub in "/esi/jsonp-callback" as the callback parameter
            set req.url = regsub(req.url,
                "([\?&])callback=[a-zA-Z0-9_][^&]+",
                "\1callback=%3Cesi%3Ainclude%2520src%3D%22%2Fesi%2Fjsonp-callback%22%2F%3E");
        } else {
            call set_www_https_backend;
            set req.http.x-PageType = "legacy";
            set req.http.x-skip-glogin = "1";
        }
    }

    // AB Test Config
    if ( req.url == "/appconfig/abtests/nyt-abconfig.json" ) {
        set req.http.X-PageType = "service";
        call set_www_fe_backend;
    }

    if ( req.url == "/js/nyt5/ab/abconfig.json" ) {
        set req.http.X-PageType = "static";
        call set_www_static_backend;
    }

    # various paths we CAN cache from legacy systems
    # relying on the netscaler to send it to the correct place for now
    if ( req.url ~ "^/newsgraphics/"
         || req.url ~ "^/regilite"
         || req.url ~ "^/svc/comscore/"
         || req.url ~ "^/services/xml/"){
        set req.http.X-PageType = "legacy-cacheable";
        call set_www_fe_backend;
        set req.http.x-skip-glogin = "1";
    }

    if( req.url ~ "^/svc/collections"){
        set req.http.X-PageType = "collections-svc";
        call set_www_fe_backend;
        set req.http.x-skip-glogin = "1";
    }

    if (req.http.X-Is-NYT4 == "1") {
        set req.url = req.http.X-OriginalUri;
        set req.http.cookie = req.http.X-Cookie;
        set req.http.X-PageType = "legacy";
        call set_www_backend;
    }

    if (req.http.X-Vi-Cluster == "story") {
        set req.url = req.http.X-OriginalUri;
        //set req.http.cookie = req.http.X-Cookie;
        set req.http.X-PageType = "vi-story";
        call set_projectvi_fe_backend;

        // If the VI backend is not healthy, we reset the backend
        // to www-fe, and set a header to prevent the request from restarting
        if (!req.backend.healthy) {
            set req.http.X-PageType = "article";
            # using this full string becasue we do not want this
            # consuming log volume unless it was unhealthy and we failed over
            set req.http.x-vi-health = "vihealth=[0]";
            set req.http.X-RelevantBackendStatus = "unchanged";
            call set_www_fe_backend;
        }
    }

    // A request for assets from VI
    if (req.url ~ "^/vi-assets/") {
        set req.http.X-PageType = "vi-asset";
        set req.http.host = "storage.googleapis.com";
        call set_projectvi_asset_backend;
        set req.http.x-skip-glogin = "1";
    }
}

# set a www backend based on host
sub set_www_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = www_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = www_stg;
    } else {
        set req.backend = www_prd;
    }
}

# set a www backend based on host
sub set_www_https_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = www_https_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = www_https_stg;
    } else {
        set req.backend = www_https_prd;
    }
}

# set paidpost backend to prepare for migration
sub set_www_paidpost_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = www_https_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = www_https_stg;
    } else {
        set req.backend = www_https_prd;
    }
}

# set a www_fe backend based on host
sub set_www_fe_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = www_fe_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = www_fe_stg;
    } else {
        set req.backend = www_fe_prd;
    }

    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}

# set backend for each NYT5 app to prepare GKE migration
# first step is to separate backend per each app
sub set_www_collection_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = www_fe_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = www_fe_stg;
    } else {
        set req.backend = www_fe_prd;
    }
    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}

sub set_www_collection_backend_gke {
    if(req.http.x-environment == "dev") {
        set req.backend = collection_fe_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = collection_fe_stg;
    } else {
        set req.backend = collection_fe_prd;
    }
    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}


# set backend for each NYT5 app to prepare GKE migration
# first step is to separate backend per each app
sub set_www_article_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = www_fe_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = www_fe_stg;
    } else {
        set req.backend = www_fe_prd;
    }

    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}

sub set_www_article_backend_gke {
    if(req.http.x-environment == "dev") {
        set req.backend = article_fe_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = article_fe_stg;
    } else {
        set req.backend = www_fe_prd;
    }

    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}


# set backend for each NYT5 app to prepare GKE migration
# first step is to separate backend per each app
sub set_www_slideshow_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = www_fe_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = www_fe_stg;
    } else {
        set req.backend = www_fe_prd;
    }

    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}

# set backend for each NYT5 app to prepare GKE migration
# first step is to separate backend per each app
sub set_www_newsletter_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = www_fe_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = www_fe_stg;
    } else {
        set req.backend = www_fe_prd;
    }

    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}

# set backend for each NYT5 app to prepare GKE migration
# first step is to separate backend per each app
sub set_www_misc_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = www_fe_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = www_fe_stg;
    } else {
        set req.backend = www_fe_prd;
    }

    # if we needed to switch back to NYT5, unset the vi flag
    unset req.http.x--fastly-project-vi;
}

sub set_www_static_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = www_static_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = www_static_stg;
    } else {
        set req.backend = www_static_prd;
    }
}

sub set_blogs_fe_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = blogs_fe_dev;
    } else if (req.http.x-environment == "stg") {
        set req.backend = blogs_fe_stg;
    } else {
        set req.backend = blogs_fe_prd;
    }
}

sub set_www_intl_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = intl_gcp_stg;
    } else if (req.http.x-environment == "stg") {
        set req.backend = intl_gcp_stg;
    } else {
        set req.backend = intl_gcp_prd;
    }
}

sub set_www_newsdev_gke_backend {
    if(req.http.x-environment == "dev") {
        set req.backend = newsdev_k8s_gke_stg;
    } else if (req.http.x-environment == "stg") {
        set req.backend = newsdev_k8s_gke_stg;
    } else {
        set req.backend = newsdev_k8s_gke_prd;
    }
}

sub set_www_newsdev_attribute_gclod_function_backend {
    if(req.http.x-environment == "dev" || req.http.x-environment == "stg") {
      set req.http.host = "us-central1-nytint-stg.cloudfunctions.net";
      set req.backend = newsdev_attribute_gclod_function_stg;
    } else {
        set req.backend = newsdev_k8s_gke_prd;
    }
}

sub set_ask_well_backend {
    if(req.http.x-environment == "dev") {
      // no dev
    } else if (req.http.x-environment == "stg") {
        set req.backend = ask_well_stg;
    } else {
        set req.backend = ask_well_prd;
    }

    set req.http.X-PageType = "askwell";
    set req.http.x-skip-glogin = "1";

    if (req.url ~ "^(/svc/int/qa/questions/[a-z0-9\-]*/votes|/svc/int/qa/questions/[a-z0-9\-]*/submit|/ask/well/questions/yours)") {
        # we have to pass directly here, so that req.http.Cookie passes through
        return (pass);
    }

    if (req.url ~ "^/ask/well/questions") {
      set req.url = querystring.regfilter(req.url, "^(?!limit|offset|partial)");
      set req.url = querystring.sort(req.url);
    } elsif (req.url ~ "^/svc/int/qa/questions") {
      set req.url = querystring.regfilter(req.url, "^(?!limit|offset|sort)");
      set req.url = querystring.sort(req.url);
    } else {
      set req.url = querystring.remove(req.url);
    }
}

# set a vi backend based on host
sub set_projectvi_fe_backend {
    if(req.http.x-environment == "dev") {
        set req.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_stg");
        set req.backend = projectvi_fe_stg;
    } else if (req.http.x-environment == "stg") {
        set req.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_stg");
        set req.backend = projectvi_fe_stg;
    } else {
        set req.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_prd");
        set req.backend = projectvi_fe_prd;
    }
    # must set this for hashing and saint mode in default.vcl:
    set req.http.x--fastly-project-vi = "1";
}

# set a vi asset backend based on host
sub set_projectvi_asset_backend {
    set req.backend = projectvi_asset_prd;
}
