sub vcl_recv {

    // redirect nytimes.com to www.nytimes.com
    if (req.http.host == "nytimes.com") {
        // forcing this to https, if the asset does not support https it will be redirected again
        set req.http.x-Redir-Url = "https://www.nytimes.com" + req.url;
        set req.http.x-redirect-reason = "redir=[zone-apex]";
        error 750 req.http.x-Redir-Url;
    }

    // redirect international to www
    if (req.http.host ~ "^international\.(dev\.|stg\.)?nytimes.com$") {
        set req.http.x-Redir-Url = 
            "https://" +
            regsub(req.http.host, "^international.","www.") +
            req.url;
        error 750 req.http.x-Redir-Url;
    }


    # remove query strings like login-email, login-password etc.
    if (req.url ~ "[?&]login-[^=&]+") {
        set req.url = querystring.regfilter(req.url, "^login-*");
        set req.http.X-Redir-Url =  "https://" + req.http.host + req.url;
        error 750 req.http.X-Redir-Url;
    }

}

sub vcl_error {
    if (obj.status == 750) {
        set obj.http.Location = obj.response;
        set obj.http.x-api-version = "0";
        set obj.status = 301;
        set obj.response = "Moved Permanently";
        return(deliver);
    }
}
