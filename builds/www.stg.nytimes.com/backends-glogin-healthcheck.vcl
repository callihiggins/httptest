# this logic will cause glogin to fail open if it is unhealthy in two cases
# 1. the backend with glogin as a healthcheck goes unhealthy
# 2. we get a 5xx back from a /glogin call, in this case we 
#    set a signed param to cause skip when redirecting back to the content

sub vcl_recv {
  
  if (req.http.x-environment == "stg") {
    call set_glogin_healthcheck_backend; # lets create a sub for this like all others..

    if(!req.backend.healthy) {
       set req.http.x-skip-glogin = "1";
    }
  }
}

sub vcl_fetch {
  declare local var.redirect_url STRING;
  declare local var.expire_time INTEGER;
  declare local var.glogin_skip_qparam STRING;

  if (req.http.x-environment == "stg") {
    # if this was a glogin request and it returned an error, send the user back to the page
    # they came from, as well set a parameter so that glogin is skipped on that view
    if ( req.url.path == "/glogin" && beresp.status != 302 ) {

      set var.redirect_url = if(req.http.x-orig-querystring ~ "(?i)\?.*URI=([^&]*)", re.group.1, "");
      if (var.redirect_url == ""){
        set var.redirect_url = "https://" + req.http.host + "/";
      } else {
        set var.redirect_url = urldecode(var.redirect_url);
      }

      # create a signed query param that will last 30 seconds so that glogin will be skipped
      # when we redirect the user to back to the page they came from
      # the partner login is in glogin-redirect.vcl
      set var.expire_time = std.atoi(now.sec);
      set var.expire_time += 30;
      set var.glogin_skip_qparam = var.expire_time + "|" + digest.hmac_sha256_base64(req.http.x-nyt-glogin-error-skip-key, var.expire_time);

      set var.redirect_url = var.redirect_url + if(var.redirect_url ~ "\?","&","?") + "GLS=" + urlencode(var.glogin_skip_qparam);

      error 751 var.redirect_url;
    }
  }
}

sub vcl_error {
  if (obj.status == 751) {
      set obj.http.Location = obj.response;
      set obj.status = 302;
      set obj.response = "Moved Temporarily";
      return(deliver);
  }
}

sub set_glogin_healthcheck_backend {
  if (req.http.x-environment == "dev") {
      set req.backend = glogin_healthcheck_dev;
  } else if (req.http.x-environment == "stg") {
      set req.backend = glogin_healthcheck_stg;
  } else {
      set req.backend = glogin_healthcheck_prd;
  }
}
