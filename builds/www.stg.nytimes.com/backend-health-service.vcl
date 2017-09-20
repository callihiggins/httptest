sub vcl_pass {
  call process_backend_health_req;
}

sub vcl_miss {
  call process_backend_health_req;
}

sub process_backend_health_req {
  if (req.url ~ "^/backendhealth/([^/\.]*)" && client.ip ~ internal) {

    declare local var.backend_choice STRING;


    set var.backend_choice = std.tolower(re.group.1);

    # validate the passed in parameter
    if (var.backend_choice !~ "^[0-9a-z\-\_]+$" || req.url.ext !~ "^(json|html)$" ) {
      error 500;
    }

    unset req.http.x-nyt-appended-status;

    # create json structure head
    call create_response_head;

    if (var.backend_choice == "www" || var.backend_choice == "all_backends") {
      call set_www_backend;
      set req.http.x-nyt-temp-backend-name = "www";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "www_https" || var.backend_choice == "all_backends") {
      call set_www_https_backend;
      set req.http.x-nyt-temp-backend-name = "www_https";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "www_fe" || var.backend_choice == "all_backends") {
      call set_www_fe_backend;
      set req.http.x-nyt-temp-backend-name = "www_fe";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "www_static" || var.backend_choice == "all_backends") {
      call set_www_static_backend;
      set req.http.x-nyt-temp-backend-name = "www_static";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "blogs" || var.backend_choice == "all_backends") {
      call set_blogs_fe_backend;
      set req.http.x-nyt-temp-backend-name = "blogs";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "intl" || var.backend_choice == "all_backends") {
      call set_www_intl_backend;
      set req.http.x-nyt-temp-backend-name = "intl";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "newsdev_gke" || var.backend_choice == "all_backends") {
      call set_www_newsdev_gke_backend;
      set req.http.x-nyt-temp-backend-name = "newsdev_gke";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "askwell" || var.backend_choice == "all_backends") {
      call set_ask_well_backend;
      set req.http.x-nyt-temp-backend-name = "askwell";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "projectvi_fe" || var.backend_choice == "all_backends") {
      call set_projectvi_fe_backend;
      set req.http.x-nyt-temp-backend-name = "projectvi_fe";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "project_vi_asset" || var.backend_choice == "all_backends") {
      call set_projectvi_asset_backend;
      set req.http.x-nyt-temp-backend-name = "project_vi_asset";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "beta_well" || var.backend_choice == "all_backends") {
      call set_beta_well_backend;
      set req.http.x-nyt-temp-backend-name = "beta_well";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "du_weddings_api" || var.backend_choice == "all_backends") {
      call set_du_weddings_api_backend;
      set req.http.x-nyt-temp-backend-name = "du_weddings_api";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "beta_watching" || var.backend_choice == "all_backends") {
      call set_beta_watching_backend;
      set req.http.x-nyt-temp-backend-name = "beta_watching";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "vp_prd" || var.backend_choice == "all_backends") {
      set req.backend = vp_prd;
      set req.http.x-nyt-temp-backend-name = "vp_prd";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "times_journeys_prd" || var.backend_choice == "all_backends") {
      set req.backend = times_journeys_prd;
      set req.http.x-nyt-temp-backend-name = "times_journeys_prd";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "times_journeys_students_prd" || var.backend_choice == "all_backends") {
      set req.backend = times_journeys_students_prd;
      set req.http.x-nyt-temp-backend-name = "times_journeys_students_prd";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "tbooks_prd" || var.backend_choice == "all_backends") {
      set req.backend = tbooks_prd;
      set req.http.x-nyt-temp-backend-name = "tbooks_prd";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "subscription" || var.backend_choice == "all_backends") {
      call set_subscription_backend;
      set req.http.x-nyt-temp-backend-name = "subscription";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "games_svc" || var.backend_choice == "all_backends") {
      call set_games_web_backend;
      set req.http.x-nyt-temp-backend-name = "games_svc";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "games_web" || var.backend_choice == "all_backends") {
      call set_games_svc_backend;
      set req.http.x-nyt-temp-backend-name = "games_web";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "newsdev_elections" || var.backend_choice == "all_backends") {
      call set_newsdev_elections_backend;
      set req.http.x-nyt-temp-backend-name = "newsdev_elections";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "content_api" || var.backend_choice == "all_backends") {
      call set_content_api_backend;
      set req.http.x-nyt-temp-backend-name = "content_api";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    if (var.backend_choice == "glogin_health_check" || var.backend_choice == "all_backends") {
      call set_glogin_healthcheck_backend;
      set req.http.x-nyt-temp-backend-name = "glogin_health_check";
      call append_backend_status;
      set req.http.x-nyt-appended-status = "true";
    }

    # create json structure tail
    call create_response_tail;

    error 995;
  }
}

sub vcl_error {
  if (obj.status == 995) {

    set obj.status = 200;
    set obj.response = "OK";

    if(req.url.ext == "json") {
      set obj.http.Content-Type = "application/json";
    } else {
      set obj.http.Content-Type = "text/html";
    }

    set obj.http.X-API-Version = "0";

    synthetic req.http.x-nyt-behealth-response;
    return(deliver);
  }
}

sub create_response_head {

  if (req.url.ext == "json") {
    set req.http.x-nyt-behealth-response = {" {
    "HealthData": [
      {
        "backend": { "};
  } else {
    set req.http.x-nyt-behealth-response = {"<!DOCTYPE html><title>Backend Health</title><style>.divTable{width:800px;display:block;height:100%!important;border:1px solid #000;padding:0;background-color:transparent;margin:0;line-Height:26px}.divCaption{width:100%;background-color:transparent;position:relative;font-size:30px;color:#2293ff;text-align:center;line-height:20px;font-family:arial,helvetica,sans-serif;font-weight:700;border:1px solid #f2f2f2}.divHeaderRow{width:100%;position:relative}.divHeaderCell{border:1px solid #000;width:49.5%;position:relative;font-family:arial,helvetica,sans-serif;font-size:24px;font-style:bold;background-color:#c1c4c9;float:left}.divRow{width:100%;display:table;position:relative;color:#000}.divCell-healthy{border:1px solid #000;width:49.5%;display:block;position:relative;background-color:#64c46f;color:#000;font-size:24px;float:left;font-family:arial,helvetica,sans-serif;text-align:center;vertical-align:middle;font-weight:700;letter-spacing:0;word-spacing:0}.divCell-unhealthy{border:1px solid #000;width:49.5%;display:block;position:relative;background-color:#d12b25;color:#000;font-size:24px;float:left;font-family:arial,helvetica,sans-serif;text-align:center;vertical-align:middle;font-weight:700;letter-spacing:0;word-spacing:0}.divCellBackend{border:1px solid #000;width:49.5%;display:block;position:relative;background-color:#fff;color:#000;font-size:24px;float:left;font-family:arial,helvetica,sans-serif;text-align:left;vertical-align:middle;font-weight:700;letter-spacing:0;word-spacing:0}</style><div class=divTable id=divTable><div class=divCaption id=divCaption>Backend Health</div><div class=divHeaderRow><div class=divHeaderCell id=divHeaderCell1>Backend</div><div class=divHeaderCell id=divHeaderCell2>Status</div></div>"};
  }

}

sub create_response_tail {

  if (req.url.ext == "json") {
    set req.http.x-nyt-behealth-response = req.http.x-nyt-behealth-response + {"
        }
      }
    ]
  } "};
  } else {
    set req.http.x-nyt-behealth-response = req.http.x-nyt-behealth-response + {"
      </div><!-- Ends Main div  -->

      </body></html>
    "};
  }
}

sub append_backend_status {
  if (req.url.ext == "json") {
    if(req.http.x-nyt-appended-status == "true"){
      set req.http.x-nyt-behealth-response = req.http.x-nyt-behealth-response + ",";
    }

    set req.http.x-nyt-behealth-response = req.http.x-nyt-behealth-response + {"
          ""} + req.http.x-nyt-temp-backend-name + {"": {
            "health": ""} + if(req.backend.healthy,"healthy","unhealthy") + {""
          }"};
  } else {
    # markup is larger, minifying
    set req.http.x-nyt-behealth-response = req.http.x-nyt-behealth-response + {"<div id="divRow1" class="divRow"><div class="divCellBackend">"}+req.http.x-nyt-temp-backend-name+{"</div><div class="divCell-"} + if(req.backend.healthy,"healthy","unhealthy") +  {"">"}+if (req.backend.healthy,"HEALTHY","UNHEALTHY") +{"</div></div>"};
  }

}