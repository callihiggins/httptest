include "glogin-killswitch";

sub vcl_recv {

    # call a function that will check to see if we got a parameter that should FORCE NO redirect to glogin
    # see backends-glogin-healthcheck.vcl for the other side of this logic
    call check_glogin_error_skip;
    # call sub to check if the request should skip glogin (at bottom of file)
    call check_skip_glogin;

    # if we should not skip glogin, enter this logic to validate cookies
    # validate NYT-BCET timestamp and signature, as well as NYT-S existence
    if (!req.http.x-skip-glogin) {
        if (!req.http.x-nyt-s) {
            error 990;
        }

        if (!req.http.x-nyt-bcet) {
            error 990;
        }

        set req.http.x-nyt-bcet = urldecode(req.http.x-nyt-bcet);

        # we switched from 3 to 4 fields pipe-delimited to add data to the cookie
        # if there are not 4 fields, use the 3 field method
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
    set req.http.x-r = regsub(req.http.x-orig-querystring, ".*_r=(.).*", "\1");

    // increment passed-in value if exists
    // else set to zero
    if (req.http.x-r == req.http.x-orig-querystring) {
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
            "nytimes.com/auth/login?URI=" + urlencode("https://" + req.http.host + req.http.X-OriginalUri) + "&REFUSE_COOKIE_ERROR=SHOW_ERROR";
        set req.http.x-redirect-reason = "redir=[login]";
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
        set req.http.x-redirect-reason = "redir=[glogin]";
    }

    set obj.status = 303;
    set obj.response = "See Other";
    set obj.http.X-API-Version = "0";

    return(deliver);
}

/**
  * This logic looks for the GLS (glogin skip) query parameter.
  * it then validates that it is not expired and as well validates
  * the signature using a shared secret
  * If it is valid, glogin must have returned 5xx for this user
  * we will allow them to pass without hitting it again
  *
  */
sub check_glogin_error_skip {
    declare local var.expire_time INTEGER;
    declare local var.signature STRING;
    declare local var.glogin_skip_qparam STRING;

    set req.http.x-glogin-error = req.http.x-glogin-error + req.restarts;

    set var.glogin_skip_qparam = if(req.http.x-orig-querystring ~ "(?i)\?.*GLS=([^&]*)", re.group.1, "");
    if (var.glogin_skip_qparam != ""){
        set var.glogin_skip_qparam = urldecode(var.glogin_skip_qparam);
        set var.expire_time = std.atoi(if(var.glogin_skip_qparam ~ "^([0-9]+)\|.+$", re.group.1, ""));
        set var.signature = if(var.glogin_skip_qparam ~ "^[0-9]+\|(.+)$", re.group.1, "");
    } else {
        # if we are here the GLS parameter did not exist, return
        return;
    }

    # if the GLS param signature matches and is not expired, return
    if ( digest.hmac_sha256_base64(req.http.x-nyt-glogin-error-skip-key, var.expire_time) == var.signature
         && time.is_after(std.integer2time(var.expire_time), now) ) {
        set req.http.x-skip-glogin = "1";
    }

}

sub check_skip_glogin {

    # conditional logic that will check if we should skip glogin for this request


    # anonymous/guest cookie users should skip glogin
    # guest cookie starts with  '0' character
    # staging only feature flag for now (20170613)
    if (req.http.x-environment == "stg") {
        if (req.http.x-nyt-s ~ "^0" || !req.http.x-nyt-s) {
            set req.http.x-skip-glogin = "1";
        }
    }

    # some backends that should skip glogin
    if (req.backend == www_dev
        || req.backend == www_stg
        || req.backend == www_prd
        || req.backend == www_https_dev
        || req.backend == www_https_stg
        || req.backend == www_https_prd
        || req.backend == newsdev_k8s_elb_stg
        || req.backend == newsdev_k8s_elb_prd
        || req.backend == newsdev_k8s_gke_stg
        || req.backend == newsdev_k8s_gke_prd) {

        set req.http.x-skip-glogin = "1";
    }

    # pagetypes that should skip glogin
    if (req.http.X-PageType == "homepage"
        || req.http.X-PageType == "trending"
        || req.http.X-PageType == "collection"
        || req.http.X-PageType == "newsletter"
        || req.http.X-PageType == "blog2"
        || req.http.X-PageType == "service"
        || req.http.X-PageType == "static"
        || req.http.X-PageType == "paidpost"
        || req.http.X-PageType == "elections"
        || req.http.X-PageType == "newsdev-gke"
        || req.http.X-PageType == "community-svc-cacheable"
        || req.http.X-PageType == "video-library"
        || req.http.X-PageType == "video-api"
        || req.http.X-PageType == "messaging-api") {

        set req.http.x-skip-glogin = "1";
    }


    # if we got a fastly purge request, skip glogin
    if (req.request == "FASTLYPURGE") {
        set req.http.x-skip-glogin = "1";
    }

    # clients identified as crawlers/bots should skip glogin
    if (req.http.X-CRWL == "true") {
        set req.http.x-skip-glogin = "1";
    }

    # user agents that match a pattern for facebook native apps should skip glogin
    if (req.http.user-agent ~ "\[FB\_IAB\/FB4A" || req.http.user-agent ~ "\[FBAN\/FBIOS\;") {
        set req.http.x-skip-glogin = "1";
    }

}
