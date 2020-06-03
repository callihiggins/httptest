sub recv_route_messaging {
  if (req.url.path ~ "^/svc/(pushmobile|message)/") {
    set req.http.x-nyt-route = "messaging";
    set req.http.x-nyt-backend = "messaging";
    set req.url = querystring.remove(req.url);
  }
}

sub miss_pass_route_messaging {
  if (req.http.x-nyt-route == "messaging") {
    call set_messaging_host;
  }
}

sub set_messaging_host {
    // dev and stg are GAE resources that require a host header. Prod however does not
    if (req.http.var-nyt-env == "dev" || req.http.var-nyt-env == "stg") {
        set bereq.http.host = "nyt-messaging-dev.appspot.com";
    }
}
