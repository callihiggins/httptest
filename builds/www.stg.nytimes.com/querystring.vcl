sub vcl_recv {
    set req.http.X-OriginalUri = req.url;

    # remove query string parameters
    if (   req.url             !~ "/svc/web-products/" # except from API requests
        && req.http.X-PageType !~ "^blog" # except from blogs requests
        && req.http.X-PageType != "real-estate" # except from real estate requests
        && req.http.X-PageType != "newsletter" # except from newsletter requests
        && req.http.X-PageType != "slideshow" # except from slideshow requests
        && req.http.X-PageType != "video-library" # except from video libarary
        && req.http.X-PageType != "video-api" # except from video libarary
        && req.http.X-PageType != "article" # except from article requests
        && req.http.X-PageType != "bestsellers" # except from bestseller requests
        && req.http.X-PageType != "interactive" # except from interactive requests
        && req.http.X-PageType != "newsdev-static" #except from newsdev
        && req.http.X-PageType != "newsdev-dynamic" #except from newsdev
        && req.http.X-PageType != "newsdev-intl"
        && req.http.X-PageType != "community-svc-cacheable"
        && req.http.X-PageType != "legacy-cacheable"
        && req.http.X-PageType != "collections-svc"
        && req.http.X-PageType != "watching"
        # except from NYT4 requests
        && (req.backend != www_dev
            && req.backend != www_stg
            && req.backend != www_prd
            && req.backend != www_https_dev
            && req.backend != www_https_stg
            && req.backend != www_https_prd
            )
    ) {
        set req.url = querystring.remove(req.url);
    } else {
        if (req.http.X-PageType ~ "^blog") {
            // WP-7352: Don't deal with POST requests
            if (req.request == "POST") {
                return(pass);
            }

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
        } else if (req.http.X-PageType == "real-estate") {
            set req.url = querystring.filter_except(req.url,
                "location" + querystring.filtersep() +
                "locations[]" + querystring.filtersep() +
                {"locations%5B%5D"} + querystring.filtersep() +
                "priceMin" + querystring.filtersep() +
                "priceMax" + querystring.filtersep() +
                "pricemin" + querystring.filtersep() +
                "pricemax" + querystring.filtersep() +
                "price" + querystring.filtersep() +
                "bedrooms" + querystring.filtersep() +
                "bathrooms" + querystring.filtersep() +
                "show[]" + querystring.filtersep() +
                {"show%5B%5D"} + querystring.filtersep() +
                "channel" + querystring.filtersep() +
                "neighborhood" + querystring.filtersep() +
                "p" + querystring.filtersep() +
                "sort" + querystring.filtersep() +
                "filters[]" + querystring.filtersep() +
                {"filters%5B%5D"} + querystring.filtersep() +
                "alerts[]" + querystring.filtersep() +
                {"alerts%5B%5D"} + querystring.filtersep() +
                "alertType[]" + querystring.filtersep() +
                {"alertType%5B%5D"} + querystring.filtersep() +
                "alertFrequency[]" + querystring.filtersep() +
                {"alertFrequency%5B%5D"} + querystring.filtersep() +
                "searchName" + querystring.filtersep() +
                "searchQuery" + querystring.filtersep() +
                "idSearch" + querystring.filtersep() +
                "listingId" + querystring.filtersep() +
                "photo" + querystring.filtersep() +
                "senderEmail" + querystring.filtersep() +
                "itemIds" + querystring.filtersep() +
                "redirect" + querystring.filtersep() +
                "price" + querystring.filtersep() +
                "borough" + querystring.filtersep() +
                "boroughs" + querystring.filtersep() +
                "timeframe" + querystring.filtersep() +
                "count" + querystring.filtersep() +
                "neighborhoods" + querystring.filtersep() +
                "openHouse" + querystring.filtersep() +
                "datePosted" + querystring.filtersep() +
                "priceReduced" + querystring.filtersep() +
                "propertyType[]" + querystring.filtersep() +
                {"propertyType%5B%5D"} + querystring.filtersep() +
                "popularFeatures[]" + querystring.filtersep() +
                {"popularFeatures%5B%5D"} + querystring.filtersep() +
                "parking" + querystring.filtersep() +
                "locationAmenities[]" + querystring.filtersep() +
                {"locationAmenities%5B%5D"} + querystring.filtersep() +
                "petPolicy" + querystring.filtersep() +
                "petPolicy[]" + querystring.filtersep() +
                {"petPolicy%5B%5D"} + querystring.filtersep() +
                "listingType" + querystring.filtersep() +
                "listingType[]" + querystring.filtersep() +
                {"listingType%5B%5D"} + querystring.filtersep() +
                "transit" + querystring.filtersep() +
                "transit[]" + querystring.filtersep() +
                {"transit%5B%5D"} + querystring.filtersep() +
                "transitRadius" + querystring.filtersep() +
                "content" + querystring.filtersep() +
                "content[]" + querystring.filtersep() +
                {"content%5B%5D"} + querystring.filtersep() +
                "agents" + querystring.filtersep() +
                "agents[]" + querystring.filtersep() +
                {"agents%5B%5D"} + querystring.filtersep() +
                "brokerages" + querystring.filtersep() +
                "brokerages[]" + querystring.filtersep() +
                {"brokerages%5B%5D"} + querystring.filtersep() +
                "sortBy");
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
                "mood" + querystring.filtersep() +
                "q" + querystring.filtersep() +
                "sub_genre" + querystring.filtersep() +
                "type" + querystring.filtersep() +
                "services[]");
        } else if (req.http.X-PageType == "bestsellers") {
            set req.url = querystring.filter_except(req.url, "nytapp");
        } else if (req.http.X-PageType == "collection") {
            set req.url = querystring.filter_except(req.url, "nytapp");
        } else if (req.http.X-PageType == "article") {
            set req.url = querystring.filter_except(req.url, "nytapp");
        } else if (req.http.X-PageType == "interactive") {
            set req.url = querystring.filter_except(req.url, "isHybrid");
        } else if (req.http.X-PageType == "community-svc-cacheable"){
            set req.url = querystring.filter(req.url, "_");
        } else if (req.http.X-PageType == "collections-svc"){
            set req.url = querystring.filter_except(req.url,
                "dom" + querystring.filtersep() +
                "limit" + querystring.filtersep() +
                "page" + querystring.filtersep() +
                "q" + querystring.filtersep() +
                "sort" + querystring.filtersep() +
                "type" + querystring.filtersep() +
                "dedupe_hl");
        } else if (req.http.X-PageType == "newsdev-intl"){
            set req.url = querystring.filter_except(req.url,
                "sort" + querystring.filtersep() +
                "q" + querystring.filtersep() +
                "dom" + querystring.filtersep() +
                "dedupe_hl" + querystring.filtersep() +
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
