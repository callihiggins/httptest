sub recv_route_real_estate {
  // realestate application
    if (   req.url ~ "^/real-estate/"
        || req.url ~ "^/real-estate?"
        || req.url ~ "^/real-estate$"
    ) {
        // set req.http.X-UA-Device
        set req.http.x-nyt-route = "real-estate";
        set req.http.x-nyt-backend = "realestate_fe";
        set req.http.var-nyt-wf-auth = "true";
        set req.http.var-nyt-send-gdpr = "true";

        # we have to pass directly here
        # so that we don't cache private user data.
        if (   req.url ~ "^/real-estate/api/mail"
            || req.url ~ "^/real-estate/api/personalization"
        ) {
            set req.http.x-nyt-route = "real-estate-pass";
            set req.http.var-nyt-force-pass = "true";
        } else {
            # this was not a force pass, filter the qparams
            call recv_route_real_estate_filter_querystring;
        }

        # Re-configute backend by page
        if (req.http.var-nyt-env != "dev") {
          if (
            req.url ~ "^/real-estate/mortgage-calculator" ||
            req.url ~ "^/real-estate/find-a-home" ||
            req.url ~ "^/real-estate/the-high-end" ||
            req.url ~ "^/real-estate(?:\/.*)?\/building/" ||
            req.url ~ "^/real-estate/my-real-estate"  ||
            req.url ~ "^/real-estate/guide/\w.+" ||
            req.url ~ "^/real-estate/homes-for-rent" ||
            req.url ~ "^/real-estate/homes-for-sale" ||
            # this is to match the listing page only
            req.url ~ "^/real-estate/(.*)/homes-for-(sale|rent)/([^/]+)/([^/]+)" ||
            # this is to match the search results page only
            req.url ~ "^/real-estate/(.*)/homes-for-(sale|rent)$" ||
            # this is to match the search results page building
            req.url ~ "^/real-estate/(.*)/homes-for-(sale|rent)/([^/]+)-building" ||
            req.url ~ "^/real-estate/home/([^/]+)"
          ) {
            set req.http.x-nyt-backend = "realestate_fe_vi";
          }
        }
    }
}

sub miss_pass_route_real_estate {

    # We want to pass the NYT-S cookie only to the realestate backend
    # becasue of the 8k headers size limit
    if (req.http.x-nyt-route == "real-estate-pass") {
        set bereq.http.cookie = "NYT-S=" req.http.cookie:NYT-S ";";
    }

    if (req.http.x-nyt-route == "real-estate") {
        unset bereq.http.cookie;
    }
}

sub recv_route_real_estate_filter_querystring {
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
}
