include "backends-dev";
include "backends-stg";
include "backends-prd";
include "backends-deadend";

sub vcl_recv {
    // use X-Host header, if present
    if ( req.http.X-Host ) {
        set req.http.host = req.http.X-Host;
    }

    // default is NYT4
    call set_www_backend;
    
    set req.http.X-PageType = "legacy";

    // entire paidpost hostname is NYT5
    if (req.http.host == "paidpost.nytimes.com") {
        set req.http.X-PageType = "paidpost";
        call set_www_fe_backend;
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
        call set_www_fe_backend;
        set req.http.x-skip-glogin = "1";
    }

    // newsletter application
    if (   req.url ~ "^/newsletters/"
        || req.url ~ "^/newsletters?"
        || req.url ~ "^/newsletters$"
    ) {
        set req.http.X-PageType = "newsletter";
        call set_www_fe_backend;
        set req.http.x-skip-glogin = "1";
    }

    if (   req.url ~ "^/newsletters/timesvideo"
        || req.url ~ "^/newsletters/timesvideo$"
    ) {
        set req.http.X-PageType = "newsletter-legacy";
        call set_www_backend;
    }

    // slideshow application
    if (   req.url ~ "^/slideshow/20(1[4-9]|[2-9][0-9])/"
        || req.url ~ "^/slideshow/20(1[1-9]|[2-9][0-9])/[0-9][0-9]/[0-9][0-9]/fashion/runway-(couture|mens|womens)/"
    ) {
        set req.http.X-PageType = "slideshow";
        call set_www_fe_backend;
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
        call set_www_fe_backend;
        set req.http.x-skip-glogin = "1";
    }

    // bestseller application
    if (   req.url ~ "^/books/best-sellers/"
        || req.url ~ "^/books/best-sellers?"
        || req.url ~ "^/books/best-sellers$"
    ) {
        set req.http.X-PageType = "bestseller";
        call set_www_fe_backend;
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
        && req.http.host !~ "^(www-cdn\.)?(dev\.|stg\.|)?nytimes.com$"
    ) {
        set req.http.X-PageType = "legacy-override";
        call set_www_backend;
    }

    // article
    if (   req.url ~ "^/2(00[7-9]|(0[1-9][0-9])|([1-9][0-9][0-9]))/" // 2007-future
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
        call set_www_fe_backend;
    }

    // interactive years 2014-forever are NYT5
    if (req.url ~ "^/interactive/20(1[4-9]|[2-9][0-9])/") {
        set req.http.X-PageType = "interactive";
        call set_www_fe_backend;
    }

    // blogs
    if (   req.http.host == "dealbook.nytimes.com"
        || req.http.host == "developers.nytimes.com"
        || req.http.host ~  "blogs\.nytimes\.com$"
        || req.http.host ~  "blogs\.ewr1.nytimes\.com$"
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
    if ( req.http.host == "www.nytimes.com" ) {
        if (   req.url ~  "^/news/"
            || req.url ~  "^/news$"
            || req.url ~  "^/politics/first-draft"
            || req.url ~  "^/times-insider"
            || req.url ~  "^/times-journeys"
            || req.url ~  "^/timesjourneys"
            || req.url ~  "^/live/"
            || req.url ~  "^/live$"
        ) {
            set req.http.X-PageType = "blog";
            call set_www_backend;
        }
    }
    // blog URLs that do not get glogin redirection
    if (req.http.X-PageType == "blog") {
        if (   req.url ~ "^/svc"
            || req.url ~ "^/times-journeys"
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

    if (req.http.X-Is-NYT4 == "1") {
        set req.url = req.http.X-OriginalUri;
        set req.http.cookie = req.http.X-Cookie;
        set req.http.X-PageType = "legacy";
        call set_www_backend;
    }
}

# set a www backend based on host
sub set_www_backend {
    if(req.http.host ~ "\.dev\.") {
        set req.backend = www_dev;
        set req.http.host = "www.dev.nytimes.com";
    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = www_stg;
        set req.http.host = "www.stg.nytimes.com";
    } else {
        set req.backend = www_prd;
        set req.http.host = "www.nytimes.com";
    }
}

# set a www_fe backend based on host
sub set_www_fe_backend {
    if(req.http.host ~ "\.dev\.") {
        set req.backend = www_fe_dev;
        set req.http.host = "www.dev.nytimes.com";
    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = www_fe_stg;
        set req.http.host = "www.stg.nytimes.com";
    } else {
        set req.backend = www_fe_prd;
        set req.http.host = "www.nytimes.com";
    }
}

sub set_www_static_backend {
    if(req.http.host ~ "\.dev\.") {
        set req.backend = www_static_dev;
    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = www_static_stg;
    } else {
        set req.backend = www_static_prd;
    }
}

sub set_blogs_fe_backend {
    if(req.http.host ~ "\.dev\.") {
        set req.backend = blogs_fe_dev;
    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = blogs_fe_stg;
    } else {
        set req.backend = blogs_fe_prd;
    }
}