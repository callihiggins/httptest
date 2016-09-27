sub vcl_recv {
    if (req.http.host == "nytimes.com") {
        set req.http.host = "www.nytimes.com";
        set req.http.x-Redir-Url = "http://" + req.http.host + req.url;
        error 750 req.http.x-Redir-Url;
    }
}

sub vcl_error {
    if (obj.status == 750) {
        set obj.http.Location = obj.response;
        set obj.status = 301;
        set obj.response = "Moved Permanently";
        return(deliver);
    }
}
