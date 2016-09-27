
sub vcl_recv {
    set req.http.X-url = regsub(req.url, "(\?.*)$", "");

    if (req.http.X-url ~ "^/blogs/(6thfloor|runway|intransit|boss|bittman|cityroom|nocera|carpetbagger|sinosphere|artsbeat)(/)?$") {
        error 771 "/";
    }

    if (req.http.X-url ~ "^/timeswire(/)?$") {
        error 771 "/";
    }
}

sub vcl_error {
    if (obj.status == 771) {
        set obj.http.Location = obj.response;
        set obj.status = 301;
        return(deliver);
    }
}
