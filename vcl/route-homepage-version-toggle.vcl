sub recv_route_homepage_version_toggle {
    # classic homepage toggle
    declare local var.is_classic STRING;
    if (   req.url == "/homescreen"
        && req.http.x-nyt-nyhq-access == "1"
        && req.http.var-nyt-canonical-www-host == "true") {

      if (req.http.cookie:vi_www_hp_opt != "0") {
        set var.is_classic = "0";
      } else {
        set var.is_classic = "1";
      }
      error 762 var.is_classic;
    }
}

sub error_762_route_homepage_version_toggle {

    # classic homepage toggle
    if (obj.status == 762) {
        set obj.http.Cache-Control = "no-store, no-cache";
        set obj.http.Set-Cookie =
            "vi_www_hp_opt=" + obj.response + "; path=/; domain=.nytimes.com; expires=" + time.add(now, 365d);
        set obj.http.Location = "https://" + req.http.host + "/";
        set obj.status = 302;
        set obj.response = "Temporarily Redirected";
        return(deliver);
    }
}
