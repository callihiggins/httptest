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

    if (req.url == "/classic") {
      set req.http.x-Redir-Url = "https://www.nytimes.com";
      if (req.http.cookie:vi_www_hp_classic == "1") {
        # Classic homepage is on
        error 760 req.http.x-Redir-Url;
      } else {
        # Classic homepage is off
        error 770 req.http.x-Redir-Url;
      }
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

    # Classic homepage is on, turn off
    if (obj.status == 760) {
        set obj.http.Set-Cookie =
            "vi_www_hp_classic=0; path=/; domain=.nytimes.com; expires=" +
            std.time(
                "Sun, 1 Jan " + var.expire_year + " 00:00:00 GMT", # the "Sun" part doesn't matter
                time.add(var.now_dt, 730d) # default to 2 years from now if std.time parsing fails
            );
        set obj.http.Location = obj.response;
        set obj.status = 301;
        set obj.response = "Moved Permanently";
        return(deliver);
    }

    # Classic homepage is off, turn on
    if (obj.status == 770) {
        set obj.http.Set-Cookie =
            "vi_www_hp_classic=1; path=/; domain=.nytimes.com; expires=" +
            std.time(
                "Sun, 1 Jan " + var.expire_year + " 00:00:00 GMT", # the "Sun" part doesn't matter
                time.add(var.now_dt, 730d) # default to 2 years from now if std.time parsing fails
            );
        set obj.http.Location = obj.response;
        set obj.status = 301;
        set obj.response = "Moved Permanently";
        return(deliver);
    }
}
