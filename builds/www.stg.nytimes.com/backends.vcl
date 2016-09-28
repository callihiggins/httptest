backend blogs_fe {
    .host = "www.stg.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/status.txt";
        .timeout = 10s;
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}

backend www_fe {
    .host = "www.stg.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status";
        .timeout = 10s;
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}

# Not using this backend yet
/* 
backend aballoc {
   .host = "www.stg.gtm.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
     .url = "/.status";
     .timeout = 10s;
     .interval = 30s;
     .window = 10;
     .threshold = 8;
    }
}*/

# Using backend www for now as we need a return (pass)
# Some real estate URLS require USERID and we DON'T HAVE IT YET
/*
backend www_fe_vert {
    .host = "www.stg.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status";
        .timeout = 10s;
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}
*/

backend www {
    .host = "www.stg.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status";
        .timeout = 10s;
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}

backend www_static {
    .host = "static.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status";
        .timeout = 10s;
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}

backend deadend {
    .host = "localhost";
    .port = "8080";
    .dynamic = true;
    .probe = {
        .url = "/.status";
        .initial = 0;
        .interval = 1d;
    }
}

sub vcl_recv {
    // use X-Host header, if present
    if ( req.http.X-Host ) {
        set req.http.host = req.http.X-Host;
    }

    // default is NYT4
    set req.backend = www;
    set req.http.X-PageType = "legacy";

    // entire paidpost hostname is NYT5
    if (req.http.host == "paidpost.nytimes.com") {
        set req.http.X-PageType = "paidpost";
        set req.backend = www_fe;
    }

    // homepages, domestic and international, are NYT5
    if (   req.url ~ "^/$"
        || req.url ~ "^/\?"
        || req.url ~ "^/index.html"
    ) {
        set req.http.X-PageType = "homepage";
        set req.backend = www_fe;
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
        set req.backend = www_fe;
        set req.http.x-skip-glogin = "1";
    }

    // newsletter application
    if (   req.url ~ "^/newsletters/"
        || req.url ~ "^/newsletters?"
        || req.url ~ "^/newsletters$"
    ) {
        set req.http.X-PageType = "newsletter";
        set req.backend = www_fe;
        set req.http.x-skip-glogin = "1";
    }

    if (   req.url ~ "^/newsletters/timesvideo"
        || req.url ~ "^/newsletters/timesvideo$"
    ) {
        set req.http.X-PageType = "newsletter-legacy";
        set req.backend = www;
    }

    // slideshow application
    if (   req.url ~ "^/slideshow/20(1[4-9]|[2-9][0-9])/"
        || req.url ~ "^/slideshow/20(1[1-9]|[2-9][0-9])/[0-9][0-9]/[0-9][0-9]/fashion/runway-(couture|mens|womens)/"
    ) {
        set req.http.X-PageType = "slideshow";
        set req.backend = www_fe;
    }

    // slideshow JSON files
    if (req.url ~ "\.slideshow\.json$") {
        set req.http.X-PageType = "slideshow-legacy";
        set req.backend = www;
    }

    // realestate application
    if (   req.url ~ "^/real-estate/"
        || req.url ~ "^/real-estate?"
        || req.url ~ "^/real-estate$"
    ) {
        set req.http.X-PageType = "real-estate";
        # set this to www instead of www_fe_vert so that it will PASS for now
        set req.backend = www;
        set req.http.x-skip-glogin = "1";
    }

    // trending application
    if (   req.url ~ "^/trending/"
        || req.url ~ "^/trending?"
        || req.url ~ "^/trending$"
    ) {
        set req.http.X-PageType = "trending";
        set req.backend = www_fe;
        set req.http.x-skip-glogin = "1";
    }

    // bestseller application
    if (   req.url ~ "^/books/best-sellers/"
        || req.url ~ "^/books/best-sellers?"
        || req.url ~ "^/books/best-sellers$"
    ) {
        set req.http.X-PageType = "bestseller";
        set req.backend = www_fe;
    }


    if (req.url ~ "^/404\.html") {
        set req.http.X-PageType = "miscellany";
        set req.backend = www_fe;
    }

    // NYT5 services EXCEPT userinfo
    if (   req.url ~ "/.status$"
        || req.url ~ "^/svc/web-products/"
        || req.url !~ "^/svc/web-products/userinfo"
    ) {
        set req.http.X-PageType = "service";
        set req.backend = www_fe;
        set req.http.x-skip-glogin = "1";
    }

    // non-canonical hostnames override to NYT4
    if (   req.http.host != "www.nytimes.com"
        && req.http.host != "www.stg.nytimes.com"
        && req.http.host != "international.nytimes.com"
        && req.http.host != "paidpost.nytimes.com"
        && req.http.host != "nytlive.nytimes.com"
        && req.http.host != "www2.sea1.nytimes.com"
        && req.http.host != "www.prd.ewr1.nytimes.com"
        && req.http.host != "www.prd.nytimes.com"
        && req.http.host != "www.ewr1.nytimes.com"
        && req.http.host != "www.sea1.nytimes.com"
        && req.http.host !~ "^www-varnish"
        && req.http.host !~ "^www-fastly"
        && req.http.host !~ "^www-cdn"
    ) {
        set req.http.X-PageType = "legacy-override";
        set req.backend = www;
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
        set req.backend = www_fe;
    }

    // interactive years 2014-forever are NYT5
    if (req.url ~ "^/interactive/20(1[4-9]|[2-9][0-9])/") {
        set req.http.X-PageType = "interactive";
        set req.backend = www_fe;
    }

    // blogs
    if (   req.http.host == "dealbook.nytimes.com"
        || req.http.host == "developers.nytimes.com"
        || req.http.host ~  "blogs\.nytimes\.com$"
        || req.http.host ~  "blogs\.ewr1.nytimes\.com$"
        || req.http.host ~  "(www\.)?nytco\.com$"
    ) {
        set req.http.X-PageType = "blog";
        set req.backend = blogs_fe;
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
        set req.backend = blogs_fe;
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
            set req.backend = blogs_fe;
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
        set req.backend = www_fe;
    }

    if ( req.url == "/js/nyt5/ab/abconfig.json" ) {
        set req.http.X-PageType = "static";
        set req.backend = www_static;
    }

    if (req.http.X-Is-NYT4 == "1") {
        set req.url = req.http.X-OriginalUri;
        set req.http.cookie = req.http.X-Cookie;
        set req.http.X-PageType = "legacy";
        set req.backend = www;
    }
}

include "backend-well";