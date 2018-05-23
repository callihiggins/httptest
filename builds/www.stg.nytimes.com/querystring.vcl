sub recv_querystring {
    set req.http.X-OriginalUri = req.url;

    # remove query string parameters
    if (   req.url             !~ "^/svc/web-products/" # except from API requests
        && req.url             !~ "^/svc/community" # except /svc/community requests
        && req.url             != "/esi/jsonp-callback" # except esi's for jsonp requests
        && req.http.x-nyt-route !~ "^blog" # except from blogs requests
        && req.http.x-nyt-route != "real-estate" # except from real estate requests
        && req.http.x-nyt-route != "newsletter" # except from newsletter requests
        && req.http.x-nyt-route != "slideshow" # except from slideshow requests
        && req.http.x-nyt-route != "video-library" # except from video libarary
        && req.http.x-nyt-route != "video-api" # except from video libarary
        && req.http.x-nyt-route != "article" # except from article requests
        && req.http.x-nyt-route != "vi-story" # except from vi-story requests
        && req.http.x-nyt-route != "vi-search" # except from vi-search requests
        && req.http.x-nyt-route != "vi-homepage" # except from vi-homepage requests
        && req.http.x-nyt-route != "bestsellers" # except from bestseller requests
        && req.http.x-nyt-route != "newsdev-gke" #except from newsdev
        && req.http.x-nyt-route != "intl"
        && req.http.x-nyt-route != "legacy-cacheable"
        && req.http.x-nyt-route != "collections-svc"
        && req.http.x-nyt-route != "add-svc"
        && req.http.x-nyt-route != "watching"
        && req.http.x-nyt-route != "content-api"
        && req.http.x-nyt-route != "programs-service"
        && req.http.x-nyt-route != "programs-gcs"
        && req.http.x-nyt-route != "shaq-service"
        && req.http.x-nyt-route != "profile-fe"
        && req.http.x-nyt-route != "content-api-gae"
        && req.http.x-nyt-route != "games-service"
        && req.http.x-nyt-route != "games-phoenix"
        && req.http.x-nyt-route != "games-assets"
        && req.http.x-nyt-route != "games-web"
        && req.http.x-nyt-route ~ "^mwcm"
        && req.http.x-nyt-route != "newsdev-gke"
        && req.http.x-nyt-route != "video-media"
        && req.http.x-nyt-route != "search-suggest"
        # early lookups and passes were already skipping this previously
        # routes will need to do this IN THEIR ROUTE in the future
        # but for now we will not remove the query params for force passes
        # TODO: WE REALLY NEED TO MOVE ALL THIS INTO THE ROUTES SPECIFICALLY
        && req.http.var-nyt-force-pass != "true"
        && req.http.x-nyt-route != "switchboard"
        # except from legacy requests
        && req.backend != F_www_legacy_gke
    ) {
        set req.url = querystring.remove(req.url);
    } else if ( req.backend == F_www_legacy_gke
                && req.url ~ "^/svc/comscore/") {
        set req.url = querystring.remove(req.url);
    } else {
        if (req.http.x-nyt-route ~ "^blog") {
            // WP-7352: Don't deal with POST requests
            if (req.request == "POST") {
                set req.http.var-nyt-force-pass = "true";
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
        } else if (req.http.x-nyt-route == "real-estate") {
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
        } else if (req.http.x-nyt-route == "newsletter") {
            set req.url = querystring.filter_except(req.url,
                "precheck" + querystring.filtersep() +
                "product" + querystring.filtersep() +
                "title");
        } else if (req.http.x-nyt-route == "slideshow") {
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
        } else if (req.http.x-nyt-route == "video-library"){
            set req.url = querystring.filter_except(req.url, "playlistId");
        } else if (req.http.x-nyt-route == "watching") {
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
        } else if (req.http.x-nyt-route == "well") {
            set req.url = querystring.filter_except(req.url,
                "price" + querystring.filtersep() +
                "category");
        } else if (req.http.x-nyt-route == "bestsellers") {
            set req.url = querystring.filter_except(req.url, "nytapp");
        } else if (req.http.x-nyt-route == "collection") {
            set req.url = querystring.filter_except(req.url, "nytapp");
        } else if (req.http.x-nyt-route == "article") {
            set req.url = querystring.filter_except(req.url, "nytapp");
        } else if (req.http.x-nyt-route == "vi-story") {
            set req.url = querystring.filter_except(req.url, "nytapp");
        } else if (req.http.x-nyt-route == "vi-search") {
            set req.url = querystring.filter_except(req.url,
                "query" + querystring.filtersep() +
                "startDate" + querystring.filtersep() +
                "endDate" + querystring.filtersep() +
                "sort");
        } else if (req.http.x-nyt-route == "vi-homepage") {
            set req.url = querystring.filter_except(req.url, "alphalayoutB");
        } else if (req.http.x-nyt-route == "search-suggest") {
            set req.url = querystring.filter_except(req.url,
                "query" + querystring.filtersep() +
                "filter" + querystring.filtersep() +
                "max");
        } else if (req.http.x-nyt-route == "collections-svc"){
            set req.url = querystring.filter_except(req.url,
                "dom" + querystring.filtersep() +
                "limit" + querystring.filtersep() +
                "page" + querystring.filtersep() +
                "q" + querystring.filtersep() +
                "sort" + querystring.filtersep() +
                "type" + querystring.filtersep() +
                "show_embedded" + querystring.filtersep() +
                "dedupe_hl");
        } else if (req.http.x-nyt-route == "intl"){
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
