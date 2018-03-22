sub vcl_recv {
    set req.http.X-OriginalUri = req.url;

    # remove query string parameters
    if (   req.url             !~ "/svc/web-products/" # except from API requests
        && req.url             !~ "^/svc/community" # except /svc/community requests
        && req.url             != "/esi/jsonp-callback" # except esi's for jsonp requests
        && req.http.X-PageType !~ "^blog" # except from blogs requests
        && req.http.X-PageType != "real-estate" # except from real estate requests
        && req.http.X-PageType != "newsletter" # except from newsletter requests
        && req.http.X-PageType != "slideshow" # except from slideshow requests
        && req.http.X-PageType != "video-library" # except from video libarary
        && req.http.X-PageType != "video-api" # except from video libarary
        && req.http.X-PageType != "article" # except from article requests
        && req.http.X-PageType != "vi-story" # except from vi-story requests
        && req.http.X-PageType != "vi-search" # except from vi-search requests
        && req.http.X-PageType != "bestsellers" # except from bestseller requests
        && req.http.X-PageType != "interactive" # except from interactive requests
        && req.http.X-PageType != "newsdev-gke" #except from newsdev
        && req.http.X-PageType != "intl"
        && req.http.X-PageType != "legacy-cacheable"
        && req.http.X-PageType != "collections-svc"
        && req.http.X-PageType != "watching"
        && req.http.x-pagetype != "content-api"
        && req.http.x-pagetype != "programs-service"
        && req.http.x-pagetype != "programs-gcs"
        && req.http.x-pagetype != "shaq-service"
        && req.http.x-pagetype != "profile-fe"
        && req.http.x-pagetype != "content-api-gae"
        && req.http.x-pagetype != "games-service"
        && req.http.x-pagetype != "games-phoenix"
        && req.http.x-pagetype != "games-assets"
        && req.http.x-pagetype != "games-web"
        && req.http.x-pagetype != "mwcm"
        && req.http.x-pagetype != "newsdev-gke"
        && req.http.x-pagetype != "video-media"
        # early lookups and passes were already skipping this previously
        # routes will need to do this IN THEIR ROUTE in the future
        # but for now we will not remove the query params for force passes
        # TODO: WE REALLY NEED TO MOVE ALL THIS INTO THE ROUTES SPECIFICALLY
        && req.http.x-nyt-force-pass != "true"
        && req.http.X-PageType != "switchboard"
        # except from NYT4 requests
        && (   req.backend != F_www
            && req.backend != F_www_https
            && req.backend != F_www_legacy_gke)
    ) {
        set req.url = querystring.remove(req.url);
    } else if ( req.backend == F_www_legacy_gke
                && req.url ~ "^/svc/comscore/") {
        set req.url = querystring.remove(req.url);
    } else {
        if (req.http.X-PageType ~ "^blog") {
            // WP-7352: Don't deal with POST requests
            if (req.request == "POST") {
                set req.http.x-nyt-force-pass = "true";
                #return(pass);
            } else {
                set req.url = querystring.filter_except(req.url,
                    "_jsonp" + querystring.filtersep() +
                    "apagenum" + querystring.filtersep() +
                    "apikey" + querystring.filtersep() +
                    "apitoken" + querystring.filtersep() +
                    "asset_id" + querystring.filtersep() +
                    "author" + querystring.filtersep() +
                    "callback" + querystring.filtersep() +
                    "category" + querystring.filtersep() +
                    "chromeless" + querystring.filtersep() +
                    "entry" + querystring.filtersep() +
                    "feed_type" + querystring.filtersep() +
                    "homepage" + querystring.filtersep() +
                    "nytapp" + querystring.filtersep() +
                    "offset" + querystring.filtersep() +
                    "p" + querystring.filtersep() +
                    "pagewanted" + querystring.filtersep() +
                    "post_not_in" + querystring.filtersep() +
                    "post_type" + querystring.filtersep() +
                    "posts_per_page" + querystring.filtersep() +
                    "s" + querystring.filtersep() +
                    "tag");
            }
        } else if (req.http.X-PageType == "real-estate") {
            set req.url = querystring.filter_except(req.url,
                "agents" + querystring.filtersep() +
                "agents[]" + querystring.filtersep() +
                {"agents%5B%5D"} + querystring.filtersep() +
                "alertFrequency[]" + querystring.filtersep() +
                {"alertFrequency%5B%5D"} + querystring.filtersep() +
                "alerts[]" + querystring.filtersep() +
                {"alerts%5B%5D"} + querystring.filtersep() +
                "alertType[]" + querystring.filtersep() +
                {"alertType%5B%5D"} + querystring.filtersep() +
                "bathrooms" + querystring.filtersep() +
                "bedrooms" + querystring.filtersep() +
                "borough" + querystring.filtersep() +
                "boroughs" + querystring.filtersep() +
                "brokerages" + querystring.filtersep() +
                "brokerages[]" + querystring.filtersep() +
                {"brokerages%5B%5D"} + querystring.filtersep() +
                "channel" + querystring.filtersep() +
                "content" + querystring.filtersep() +
                "content[]" + querystring.filtersep() +
                {"content%5B%5D"} + querystring.filtersep() +
                "count" + querystring.filtersep() +
                "datePosted" + querystring.filtersep() +
                "filters[]" + querystring.filtersep() +
                {"filters%5B%5D"} + querystring.filtersep() +
                "idSearch" + querystring.filtersep() +
                "itemIds" + querystring.filtersep() +
                "listingId" + querystring.filtersep() +
                "listingType" + querystring.filtersep() +
                "listingType[]" + querystring.filtersep() +
                {"listingType%5B%5D"} + querystring.filtersep() +
                "location" + querystring.filtersep() +
                "locationAmenities[]" + querystring.filtersep() +
                {"locationAmenities%5B%5D"} + querystring.filtersep() +
                "locations[]" + querystring.filtersep() +
                {"locations%5B%5D"} + querystring.filtersep() +
                "neighborhood" + querystring.filtersep() +
                "neighborhoods" + querystring.filtersep() +
                "openHouse" + querystring.filtersep() +
                "p" + querystring.filtersep() +
                "parking" + querystring.filtersep() +
                "petPolicy" + querystring.filtersep() +
                "petPolicy[]" + querystring.filtersep() +
                {"petPolicy%5B%5D"} + querystring.filtersep() +
                "photo" + querystring.filtersep() +
                "popularFeatures[]" + querystring.filtersep() +
                {"popularFeatures%5B%5D"} + querystring.filtersep() +
                "price" + querystring.filtersep() +
                "price" + querystring.filtersep() +
                "priceMax" + querystring.filtersep() +
                "pricemax" + querystring.filtersep() +
                "priceMin" + querystring.filtersep() +
                "pricemin" + querystring.filtersep() +
                "priceReduced" + querystring.filtersep() +
                "propertyType[]" + querystring.filtersep() +
                {"propertyType%5B%5D"} + querystring.filtersep() +
                "redirect" + querystring.filtersep() +
                "region" + querystring.filtersep() +
                "searchName" + querystring.filtersep() +
                "searchQuery" + querystring.filtersep() +
                "senderEmail" + querystring.filtersep() +
                "show[]" + querystring.filtersep() +
                {"show%5B%5D"} + querystring.filtersep() +
                "sort" + querystring.filtersep() +
                "sortBy" + querystring.filtersep() +
                "timeframe" + querystring.filtersep() +
                "transit" + querystring.filtersep() +
                "transit[]" + querystring.filtersep() +
                {"transit%5B%5D"} + querystring.filtersep() +
                "transitRadius" + querystring.filtersep() +
                "utm_campaign" + querystring.filtersep() +
                "utm_medium" + querystring.filtersep() +
                "utm_source");
        } else if (req.http.X-PageType == "newsletter") {
            set req.url = querystring.filter_except(req.url,
                "precheck" + querystring.filtersep() +
                "product" + querystring.filtersep() +
                "title");
        } else if (req.http.X-PageType == "slideshow") {
            set req.url = querystring.filter_except(req.url,
                "action" + querystring.filtersep() +
                "contentCollection" + querystring.filtersep() +
                "contentPlacement" + querystring.filtersep() +
                "currentSlide" + querystring.filtersep() +
                "entrySlide" + querystring.filtersep() +
                "module" + querystring.filtersep() +
                "pgtype" + querystring.filtersep() +
                "region" + querystring.filtersep() +
                "slideshowTitle" + querystring.filtersep() +
                "url" + querystring.filtersep() +
                "version");
        } else if (req.http.X-PageType == "video-library"){
            set req.url = querystring.filter_except(req.url, "playlistId");
        } else if (req.http.X-PageType == "watching") {
            set req.url = querystring.filter_except(req.url,
                "genre" + querystring.filtersep() +
                "ids[]" + querystring.filtersep() +
                {"ids%5B%5D"} + querystring.filtersep() +
                "mood" + querystring.filtersep() +
                "q" + querystring.filtersep() +
                "services[]" + querystring.filtersep() +
                {"services%5B%5D"} + querystring.filtersep() +
                "sub_genre" + querystring.filtersep() +
                "type");
        } else if (req.http.X-PageType == "well") {
            set req.url = querystring.filter_except(req.url,
                "price" + querystring.filtersep() +
                "category");
        } else if (req.http.X-PageType == "bestsellers") {
            set req.url = querystring.filter_except(req.url, "nytapp");
        } else if (req.http.X-PageType == "collection") {
            set req.url = querystring.filter_except(req.url, "nytapp");
        } else if (req.http.X-PageType == "article") {
            set req.url = querystring.filter_except(req.url, "nytapp");
        } else if (req.http.X-PageType == "vi-story") {
            set req.url = querystring.filter_except(req.url, "nytapp");
        } else if (req.http.X-PageType == "vi-search") {
            set req.url = querystring.filter_except(req.url, "query");
        } else if (req.http.X-PageType == "interactive") {
            set req.url = querystring.filter_except(req.url, "isHybrid");
        } else if (req.http.X-PageType == "collections-svc"){
            set req.url = querystring.filter_except(req.url,
                "dom" + querystring.filtersep() +
                "limit" + querystring.filtersep() +
                "page" + querystring.filtersep() +
                "q" + querystring.filtersep() +
                "sort" + querystring.filtersep() +
                "type" + querystring.filtersep() +
                "show_embedded" + querystring.filtersep() +
                "dedupe_hl");
        } else if (req.http.X-PageType == "intl"){
            set req.url = querystring.filter_except(req.url,
                "sort" + querystring.filtersep() +
                "q" + querystring.filtersep() +
                "dom" + querystring.filtersep() +
                "dedupe_hl" + querystring.filtersep() +
                "mc" + querystring.filtersep() +
                "mcid" + querystring.filtersep() +
                "mccr" + querystring.filtersep() +
                "subid" + querystring.filtersep() +
                "ref" + querystring.filtersep() +
                "filter" + querystring.filtersep() +
                "attachment" + querystring.filtersep() +
                "attachment_id" + querystring.filtersep() +
                "author" + querystring.filtersep() +
                "author_name" + querystring.filtersep() +
                "cat" + querystring.filtersep() +
                "calendar" + querystring.filtersep() +
                "category_name" + querystring.filtersep() +
                "comments_popup" + querystring.filtersep() +
                "cpage" + querystring.filtersep() +
                "day" + querystring.filtersep() +
                "dedupe_hl" + querystring.filtersep() +
                "dom" + querystring.filtersep() +
                "error" + querystring.filtersep() +
                "exact" + querystring.filtersep() +
                "exclude" + querystring.filtersep() +
                "feed" + querystring.filtersep() +
                "hour" + querystring.filtersep() +
                "m" + querystring.filtersep() +
                "minute" + querystring.filtersep() +
                "monthnum" + querystring.filtersep() +
                "more" + querystring.filtersep() +
                "name" + querystring.filtersep() +
                "nyt_interactive" + querystring.filtersep() +
                "nyt_kicker" + querystring.filtersep() +
                "nyt_slideshow" + querystring.filtersep() +
                "order" + querystring.filtersep() +
                "orderby" + querystring.filtersep() +
                "p" + querystring.filtersep() +
                "page_id" + querystring.filtersep() +
                "page" + querystring.filtersep() +
                "paged" + querystring.filtersep() +
                "pagename" + querystring.filtersep() +
                "pb" + querystring.filtersep() +
                "post_type" + querystring.filtersep() +
                "posts" + querystring.filtersep() +
                "preview" + querystring.filtersep() +
                "q" + querystring.filtersep() +
                "robots" + querystring.filtersep() +
                "s" + querystring.filtersep() +
                "search" + querystring.filtersep() +
                "second" + querystring.filtersep() +
                "sentence" + querystring.filtersep() +
                "smid" + querystring.filtersep() +
                "smtyp" + querystring.filtersep() +
                "smvar" + querystring.filtersep() +
                "sort" + querystring.filtersep() +
                "static" + querystring.filtersep() +
                "subpost" + querystring.filtersep() +
                "subpost_id" + querystring.filtersep() +
                "taxonomy" + querystring.filtersep() +
                "tag" + querystring.filtersep() +
                "tb" + querystring.filtersep() +
                "tag_id" + querystring.filtersep() +
                "term" + querystring.filtersep() +
                "tb" + querystring.filtersep() +
                "url" + querystring.filtersep() +
                "w" + querystring.filtersep() +
                "withcomments" + querystring.filtersep() +
                "withoutcomments" + querystring.filtersep() +
                "year");
        }
        # now sort them
        set req.url = querystring.sort(req.url);

    }

}
