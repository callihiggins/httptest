sub vcl_recv {

    // NOT a HTTPS connection
    if (!req.http.Fastly-SSL) {
        call redirect_to_https;
    }

}

sub vcl_error {
    if (obj.status == 443) {
        set obj.http.Location = obj.response;
        set obj.status = 301;
        set obj.response = "Moved Permanently";
        set obj.http.X-API-Version = "0";
        return(deliver);
    }
}

sub redirect_to_https {
    set req.http.x-Redir-Url = "https://" + req.http.host + req.url;
    error 443 req.http.x-Redir-Url;
}
