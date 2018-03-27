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

    if (req.url ~ "\.amp\.html"
        && (req.http.host ~ "^(www-[a-z0-9]+\.)(dev\.|stg\.|)?nytimes.com$" 
            || req.http.host ~ "^www\.(dev\.|stg\.|)?nytimes.com$"))
    {
        set req.http.x-Redir-Url = "https://" + req.http.host + regsub(req.url, "\.amp\.html","\.html");
        error 750 req.http.x-Redir-Url;
    }

    # remove query strings like login-email, login-password etc.
    if (req.url ~ "[?&]login-[^=&]+") {
        set req.url = querystring.regfilter(req.url, "^login-*");
        set req.http.X-Redir-Url =  "https://" + req.http.host + req.url;
        error 750 req.http.X-Redir-Url;
    }
    
    # classic homepage toggle
    if (req.url == "/homescreen" && req.http.x-nyt-internal-access == "1") {
      if (req.http.cookie:vi_www_hp_opt != "0") {
        set req.http.x-Homescreen-Classic = "0";
      } else {
        set req.http.x-Homescreen-Classic = "1";
      }

      error 762 req.http.x-Homescreen-Classic;
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

    # classic homepage toggle
    if (obj.status == 762) {
        set obj.http.Cache-Control = "no-store, no-cache";
        set obj.http.Set-Cookie =
            "vi_www_hp_opt=" + obj.response + "; path=/; domain=.nytimes.com; expires=" + time.add(now, 365d);
        set obj.http.Location = "https://www.nytimes.com";
        set obj.status = 302;
        set obj.response = "Temporarily Redirected";
        return(deliver);
    }
}
