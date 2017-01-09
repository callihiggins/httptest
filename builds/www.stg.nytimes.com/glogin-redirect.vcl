include "glogin-killswitch";

sub vcl_recv {
    // glogin check: if nyt-bcet cookie timestamp is expired, redirect to glogin

    if (
        (req.backend != www_dev 
        && req.backend != www_stg 
        && req.backend != www_prd
        && req.backend != www_https_dev
        && req.backend != www_https_stg
        && req.backend != www_https_prd
        && req.backend != newsdev_k8s_elb_stg
        && req.backend != newsdev_k8s_elb_prd) 
        && req.http.X-CRWL != "true"
        && req.request != "FASTLYPURGE"
        && !req.http.x-skip-glogin
        && req.http.X-PageType != "homepage"
        && req.http.X-PageType != "trending"
        && req.http.X-PageType != "collection"
        && req.http.X-PageType != "newsletter"
        && req.http.X-PageType != "blog2"
        && req.http.X-PageType != "service"
        && req.http.X-PageType != "static"
        && req.http.X-PageType != "paidpost"
        && req.http.X-PageType != "elections"
        && req.http.X-PageType != "newsdev-static"
        && req.http.X-PageType != "newsdev-dynamic"
        && req.http.X-PageType != "community-svc-cacheable"
        && req.http.X-PageType != "video-library"
        && req.http.X-PageType != "video-api"
        && req.http.X-PageType != "messaging-api"
    ) {
        if (!req.http.x-nyt-s) {
            error 990;
        }

        if (!req.http.x-nyt-bcet) {
            error 990;
        }

        set req.http.x-nyt-bcet = urldecode(req.http.x-nyt-bcet);

        # we switched from 3 to 4 fields pipe-delimited to add data to the cookie
        # if there aren't 4 fields, use the 3 field method
        if (req.http.x-nyt-bcet ~ "^[0-9]+\|.+\|.+\|.+$"){
            # 4 fields
            set req.http.x-bcet-timestamp = if(req.http.x-nyt-bcet ~ "^([0-9]+)\|.+\|.+\|.+$", re.group.1, "");
            set req.http.x-bcet-uidhash =   if(req.http.x-nyt-bcet ~ "^[0-9]+\|(.+)\|.+\|.+$", re.group.1, "");
            set req.http.x-bcet-reginfo =   if(req.http.x-nyt-bcet ~ "^[0-9]+\|.+\|(.+)\|.+$", re.group.1, "");
            set req.http.x-bcet-sig =       if(req.http.x-nyt-bcet ~ "^[0-9]+\|.+\|.+\|(.+)$", re.group.1, "");

            if ( digest.hmac_sha256_base64(req.http.x-bcet-secret-key, req.http.x-bcet-timestamp + "|" + req.http.x-bcet-uidhash + "|" + req.http.x-bcet-reginfo)
                != req.http.x-bcet-sig){
                error 990;
            } else if (time.is_after(now, std.integer2time(std.atoi(req.http.x-bcet-timestamp)))) {
                error 990;
            }

        } else {
            # 3 fields
            set req.http.x-bcet-timestamp = if(req.http.x-nyt-bcet ~ "^([0-9]+)\|.+\|.+$", re.group.1, "");
            set req.http.x-bcet-uidhash =   if(req.http.x-nyt-bcet ~ "^[0-9]+\|(.+)\|.+$", re.group.1, "");
            set req.http.x-bcet-sig =       if(req.http.x-nyt-bcet ~ "^[0-9]+\|.+\|(.+)$", re.group.1, "");

            if ( digest.hmac_sha256_base64(req.http.x-bcet-secret-key, req.http.x-bcet-timestamp + "|" + req.http.x-bcet-uidhash )
                != req.http.x-bcet-sig){
                error 990;
            } else if (time.is_after(now, std.integer2time(std.atoi(req.http.x-bcet-timestamp)))) {
                error 990;
            }

        }

    }
}

sub vcl_error {
    // glogin check failed: redirect to /glogin
    if (obj.status == 990) {
        call redirect_to_glogin;
    }
}

sub redirect_to_glogin {

    // use "_r" querystring param to indicate number of times this request was redirected to glogin
    set req.http.x-r = regsub(req.http.X-QueryString, ".*_r=(.).*", "\1");

    // increment passed-in value if exists
    // else set to zero
    if (req.http.x-r == req.http.X-QueryString) {
        set req.http.x-r = "0";
    } else {
        if (req.http.x-r == "0"){
            set req.http.x-r = "1";
        } else if (req.http.x-r == "1"){
            set req.http.x-r = "2";
        } else if (req.http.x-r == "2"){
            set req.http.x-r = "3";
        } else if (req.http.x-r == "3"){
            set req.http.x-r = "4";
        } else if (req.http.x-r == "4"){
            set req.http.x-r = "5";
        } else if (req.http.x-r == "5"){
            set req.http.x-r = "6";
        } else {
            set req.http.x-r = "6";
        }
    }

    // if new value is 6, redirect to login page
    // else redirect to glogin
    if (req.http.x-r == "6") {
        set obj.http.location = 
            "https://myaccount." +
            if(req.http.x-environment == "dev","dev.","") + 
            if(req.http.x-environment == "stg","stg.","") +
            "nytimes.com/auth/login?URI=" + urlencode("http://" + req.http.host + req.http.X-OriginalUri) + "&REFUSE_COOKIE_ERROR=SHOW_ERROR";
    } else {
        if (req.http.X-OriginalUri ~ "_r=") { 
            set req.http.x-rq = "_r=" + req.http.x-r;
            set req.http.X-OriginalUri = regsub(req.http.X-OriginalUri, "_r=[^&]*", req.http.x-rq);
        } else if (req.http.X-OriginalUri ~ "\?") {
            set req.http.X-OriginalUri = req.http.X-OriginalUri + "&_r=" + req.http.x-r;
        } else {
            set req.http.X-OriginalUri = req.http.X-OriginalUri + "?_r=" + req.http.x-r;
        }
        set obj.http.Location = 
            "https://www." + 
            if(req.http.x-environment == "dev","dev.","") + 
            if(req.http.x-environment == "stg","stg.","") +            
            "nytimes.com/glogin?URI=" + urlencode("https://" + req.http.host + req.http.X-OriginalUri);
    }

    set obj.status = 303;
    set obj.response = "See Other";
    set obj.http.X-API-Version = "0";

    return(deliver);
}
