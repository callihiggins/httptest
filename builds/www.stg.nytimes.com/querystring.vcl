sub vcl_recv {
    set req.http.X-OriginalUri = req.url;
    if (req.url ~ "\?") {
        set req.http.X-QueryString = regsub(req.url, ".*(\?.*)", "\1");
    } else {
        set req.http.X-QueryString = "";
    }

    // remove query string parameters
    if (   req.url             !~ "/svc/web-products/" // except from API requests
        && req.http.X-PageType !~ "^blog" // except from blogs requests
        && req.http.X-PageType != "real-estate" // except from real estate requests
        && req.http.X-PageType != "newsletter" // except from newsletter requests
        && req.http.X-PageType != "slideshow" // except from slideshow requests
        // except from NYT4 requests
        && (req.backend != www_dev && req.backend != www_stg && req.backend != www_prd)
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
                "locations%5B%5D" + querystring.filtersep() + 
                "priceMin" + querystring.filtersep() + 
                "priceMax" + querystring.filtersep() + 
                "pricemin" + querystring.filtersep() + 
                "pricemax" + querystring.filtersep() + 
                "price" + querystring.filtersep() + 
                "bedrooms" + querystring.filtersep() + 
                "bathrooms" + querystring.filtersep() + 
                "show[]" + querystring.filtersep() + 
                "show%5B%5D" + querystring.filtersep() + 
                "channel" + querystring.filtersep() + 
                "neighborhood" + querystring.filtersep() + 
                "p" + querystring.filtersep() + 
                "sort" + querystring.filtersep() + 
                "filters[]" + querystring.filtersep() + 
                "filters%5B%5D" + querystring.filtersep() + 
                "alerts[]" + querystring.filtersep() + 
                "alerts%5B%5D" + querystring.filtersep() + 
                "alertType[]" + querystring.filtersep() + 
                "alertType%5B%5D" + querystring.filtersep() + 
                "alertFrequency[]" + querystring.filtersep() + 
                "alertFrequency%5B%5D" + querystring.filtersep() + 
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
                "propertyType%5B%5D" + querystring.filtersep() + 
                "popularFeatures[]" + querystring.filtersep() + 
                "popularFeatures%5B%5D" + querystring.filtersep() + 
                "parking" + querystring.filtersep() + 
                "locationAmenities[]" + querystring.filtersep() + 
                "locationAmenities%5B%5D" + querystring.filtersep() + 
                "petPolicy" + querystring.filtersep() + 
                "petPolicy[]" + querystring.filtersep() + 
                "petPolicy%5B%5D" + querystring.filtersep() + 
                "listingType" + querystring.filtersep() + 
                "listingType[]" + querystring.filtersep() + 
                "listingType%5B%5D" + querystring.filtersep() + 
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
        }

        # now sort them
        set req.url = querystring.sort(req.url);

    }
}
