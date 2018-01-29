# handle surrogate key headers from non-standard origins

sub fetch_surrogate_key_handler {

    # Use custom GCS metadata header as value of surrogate key, if set
    if (beresp.http.x-goog-meta-Surrogate-Key) {
        set beresp.http.Surrogate-Key = beresp.http.x-goog-meta-Surrogate-Key;
    }

    if (beresp.http.Surrogate-Key) {
        # keep the existing Surrogate-Key header, if present
    } else {
        # set surrogate key to 'video/<production-id>' if regex matches
        # the video asset naming convention
        if (req.url ~ "^/video/\d{4}/\d{2}/\d{2}/\d*_1_.*_wg.*") {
            set beresp.http.Surrogate-Key = regsub(req.url, "^/video/\d{4}/\d{2}/\d{2}/(\d*)_1_.*_wg.*", "video/\1");
        }
    }
}
