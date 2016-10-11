sub vcl_recv {

    // redirect nytimes.com to www.nytimes.com
    if (req.http.host == "nytimes.com") {
        set req.http.host = "www.nytimes.com";
        set req.http.x-Redir-Url = "http://" + req.http.host + req.url;
        error 750 req.http.x-Redir-Url;
    }

    // redirect international to www
    // dev/stg only for now
    if (req.http.host ~ "^international\.(dev\.|stg\.)?nytimes.com$") {
        set req.http.x-Redir-Url = 
        "http://" + 
        regsub(req.http.host, "^international.","www.") +
        req.url;
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
