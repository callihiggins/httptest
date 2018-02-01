sub vcl_recv {

  // search
  if (req.url ~ "^/search") {
      set req.http.X-PageType = "vi-search";
      call set_projectvi_fe_backend;
      call check_vi_unhealthy;
  }

  // article
  if ( req.http.X-PageType == "article" ) {
      # The articles that are potentially served by the publishing pipeline
      # are limited by a date range of later than 2017/10/09. This date is going
      # to be extended in the future to include older articles and the code will
      # be updated accordingly.
      if (
           req.url ~ "^/(aponline/|reuters/)?201[4-9]"
        && req.url.path !~ "\.amp\.html$" // exclude amp
        && (
            req.http.x--fastly-vi-test-group-story ~ "^[a]"
            || req.http.x--fastly-vi-story-opt == "1" // always in
        )
        && req.http.x--fastly-vi-story-opt != "0" // always out
      ) {
          # if the request was sent to VI and determined
          # to be Incompatible then we don't send to VI again
          if (req.http.x-pre-restart-status == "Incompatible") {

            call set_article_backend_optin;
          } else {
            set req.http.X-PageType = "vi-story";
            set req.http.x-nyt-backend = "projectvi_fe";
            call set_projectvi_fe_backend;
            call check_vi_unhealthy;
          }
      } else {
          # if the request was sent to NYT5 and determined
          # to be an OAK article don't send to NYT5 again
          if (req.http.x-pre-restart-cms-format == "oak") {
            set req.http.X-PageType = "vi-story";
            set req.http.x-nyt-backend = "projectvi_fe";
            call set_projectvi_fe_backend;
            call check_vi_unhealthy;
          } else {

            call set_article_backend_optin;
          }
      }
  }

  // interactive years 2014-forever are served by Vi
  // including all variants, canonical and .(embedded|mobile|app)\.html
  if (req.url ~ "^/interactive/20(1[4-9]|[2-9][0-9])/") {
    set req.http.X-PageType = "vi-interactive";
    set req.http.x-nyt-backend = "projectvi_fe";
    call set_projectvi_fe_backend;
    call check_vi_unhealthy;
  }

  # Home
  # Resources hosted by Vi must go to Vi, dead or alive:
  if (req.url.path ~ "^/((0_vendor-|main-|[0-9]+-).+|fonts).js$") {
      set req.http.x-nyt-backend = "projectvi_fe";
      call set_projectvi_fe_backend;
  } else {
      # For other resources:
      # check if it is a homepage route, has a a/b test group, and is not opted out.
      if (req.http.host ~ "^(www\.)?(www-[a-z0-9\-]+\.)?(dev\.|stg\.|)?nytimes.com$") {
          if ( req.url.path == "/"
            && ((req.http.x--fastly-vi-test-group ~ "^[abd]" && req.http.cookie:vi_www_hp_opt != "0") || req.http.cookie:vi_www_hp_opt == "1")
              ) {
              # homepage, in a test group getting Vi homepage
              set req.http.x-nyt-backend = "projectvi_fe";
              call set_projectvi_fe_backend;
              call check_vi_unhealthy;
          } else if (req.url.path ~ "^/2(01[4-9]|(0[2-9][0-9])|([1-9][0-9][0-9]))" # only 2014 or later
                     && req.url.path !~ "\.amp\.html$" && req.http.x--fastly-vi-test-group ~ "^[ac]") {
              # story page, in a test group getting Vi story pages
              set req.http.x-nyt-backend = "projectvi_fe";
              call set_projectvi_fe_backend;
              call check_vi_unhealthy;
          }
      }
  }


  # A request for assets from VI
  if (req.url ~ "^/vi-assets/") {
    set req.http.X-PageType = "vi-asset";
    set req.http.x-nyt-backend = "projectvi_asset";
    set req.backend = F_projectvi_asset;
  }
}

sub vcl_deliver {
    # if the response was not compatible with VI we
    # restart the request and signal that this happened
    if (resp.http.x-vi-compatibility == "Incompatible") {
        set req.http.x-pre-restart-status = "Incompatible";
        unset resp.http.x-vi-compatibility;
        return (restart);
    }

    # if the response was from NYT5 but this is an OAK article
    # we restart the request and signal that this happened
    if (resp.http.x-cms-format == "oak") {
        set req.http.x-pre-restart-cms-format = "oak";
        unset resp.http.x-cms-format;
        return (restart);
    }
}

sub vcl_hash {
  # create new hashes based on geo if rendering project vi home
  if (req.http.x--fastly-project-vi){
    if (req.url.path == "/"){
      set req.hash += req.http.x-nyt-geo-hash;
      set req.hash += req.http.device_type;
    } else if (req.url ~ "^/(aponline/|reuters/)?201[4-9]") {
      set req.hash += req.http.x--fastly-vi-test-group-story;
    }
  }

  # if a request was restarted from VI due to Incompatiblity
  # append to the hash to keep a separate key
  if (req.http.x-pre-restart-status){
    set req.hash += req.http.x-pre-restart-status;
  }

  # if a request was restarted from NYT5 due to being an OAK Article
  # append to the hash to keep a separate key
  if (req.http.x-pre-restart-cms-format){
    set req.hash += req.http.x-pre-restart-cms-format;
  }
}

sub vcl_miss {
  if (req.http.x-nyt-backend == "projectvi_asset") {
    call handle_viasset_request;
  }
}

sub vcl_pass {
  if (req.http.x-nyt-backend == "projectvi_asset") {
    call handle_viasset_request;
  }
}

sub handle_viasset_request {
    set bereq.http.host = "storage.googleapis.com";
}

# set a vi backend based on host
sub set_projectvi_fe_backend {

    set req.backend = F_projectvi_fe;

    if (req.http.x-environment == "dev") {
        set req.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_stg");
    } else if (req.http.x-environment == "stg") {
        set req.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_stg");
    } else {
        set req.http.X-Api-Key = table.lookup(origin_auth_keys, "projectvi_fe_prd");
    }
    # must set this for hashing and saint mode in default.vcl:
    set req.http.x--fastly-project-vi = "1";
}

sub check_vi_unhealthy {
  if (req.backend == F_projectvi_fe && !req.backend.healthy) {
      # using this full string becasue we do not want this
      # consuming log volume unless it was unhealthy
      set req.http.x-vi-health = "vihealth=[0]";
  }
}
