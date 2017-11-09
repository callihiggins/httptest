backend blogs_fe_prd {
    .host = "blogs.gtm.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 60s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status-for-fastly";
        .timeout = 10s;
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}

backend www_fe_prd {
    .host = "www.gtm.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status-for-fastly";
        .timeout = 10s;
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}

backend www_prd {
    .host = "www.gtm.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status-for-fastly";
        .timeout = 10s;
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}

backend www_https_prd {
    .host = "www.gtm.nytimes.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "www.nytimes.com";
    .connect_timeout = 10s;
    .first_byte_timeout = 30s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status-for-fastly";
        .timeout = 10s;
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}

backend www_static_prd {
    .host = "static.gtm.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status";
        .timeout = 10s;
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}

backend intl_gcp_prd {
    .host = "intl.prd.nytimes.com";
    .ssl_cert_hostname = "intl.prd.nytimes.com";
    .ssl_sni_hostname = "intl.prd.nytimes.com";
    .ssl_check_cert = always;
    .ssl = true;
    .port = "443";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .request =
            "GET /healthcheck.php HTTP/1.1"
            "Host: www.nytimes.com"
            "Connection: close"
            "Accept: */*";
        .timeout = 10s;
        .interval = 30s;
        .window = 5;
        .threshold = 4;
    }
}
backend newsdev_attribute_gclod_function_prd {
    .host = "us-central1-nytint-prd.cloudfunctions.net";
    .port = "443";
    .ssl_cert_hostname = "us-central1-nytint-prd.cloudfunctions.net";
    .ssl_sni_hostname =  "us-central1-nytint-prd.cloudfunctions.net";
    .dynamic = true;
    .ssl = true;
    .connect_timeout = 300s;
    .first_byte_timeout = 300s;
    .between_bytes_timeout = 300s;
    .probe = {
        .request =
            "GET /attribute-submission/healthz HTTP/1.1"
            "Host: us-central1-nytint-prd.cloudfunctions.net"
            "Connection: close"
            "Accept: */*";
        .timeout = 300s;
        .interval = 60s;
        .window = 5;
        .threshold = 4;
    }
}

backend newsdev_k8s_gke_prd {
    .host = "gke.newsdev.nytimes.com";
    .port = "443";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .request =
            "GET /healthz HTTP/1.1"
            "Host: gke.newsdev.nytimes.com"
            "Connection: close"
            "Accept: */*";
        .timeout = 10s;
        .interval = 30s;
        .window = 5;
        .threshold = 4;
    }
}

backend newsdev_elections_prd {
    .host = "storage.googleapis.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "storage.googleapis.com";
    .ssl_sni_hostname = "storage.googleapis.com";
    .ssl_check_cert = always;
    .ssl = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .request = "HEAD /healthcheck.txt HTTP/1.1" "Host: nytint-prd-elections.storage.googleapis.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
        .threshold = 3;
        .window = 5;
        .timeout = 2s;
        .initial = 2;
        .expected_response = 200;
        .interval = 5s;
    }
}

backend newsdev_elections_s3_prd {
    .host = "s3.amazonaws.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "s3.amazonaws.com";
    .ssl_sni_hostname = "s3.amazonaws.com";
    .ssl_check_cert = always;
    .ssl = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .request = "HEAD /healthcheck.txt HTTP/1.1" "Host: nytint-prd-elections.s3.amazonaws.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
        .threshold = 3;
        .window = 5;
        .timeout = 2s;
        .initial = 2;
        .expected_response = 200;
        .interval = 5s;
    }
}

backend newsdev_gcs_prd {
    .host = "storage.googleapis.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "storage.googleapis.com";
    .ssl_sni_hostname = "storage.googleapis.com";
    .ssl_check_cert = always;
    .ssl = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .request = "HEAD /healthcheck.txt HTTP/1.1" "Host: nytint-prd-www.storage.googleapis.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
        .threshold = 3;
        .window = 5;
        .timeout = 2s;
        .initial = 2;
        .expected_response = 200;
        .interval = 5s;
    }
}


backend beta_guides_prd {
    .host = "guides.prd.nyt.net";
    .port = "443";
    .ssl_cert_hostname = "guides.prd.nyt.net";
    .ssl_sni_hostname = "guides.prd.nyt.net";
    .dynamic = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/api/health";
        .timeout = 3s;
        .interval = 5s;
        .window = 5;
        .threshold = 4;
    }
}

backend ask_well_prd {
    .host = "ask-well.nyt.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 15s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/health";
        .timeout = 3s;
        .interval = 5s;
        .window = 5;
        .threshold = 4;
    }
}

backend beta_watching_prd {
    .host = "np-watching-prd-public-1330526356.us-east-1.elb.amazonaws.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/api/health";
        .timeout = 3s;
        .interval = 5s;
        .window = 5;
        .threshold = 4;
    }
}

backend du_weddings_api_prd {
    .host = "content.api.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 120s;
    .first_byte_timeout = 120s;
    .between_bytes_timeout = 120s;
    .probe = {
        .url = "/version.json";
        .timeout = 3s;
        .interval = 5s;
        .window = 5;
        .threshold = 4;
    }
}

backend games_svc_prd {
    .host = "nyt-games-prd.appspot.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "nyt-games-prd.appspot.com";
    .host_header = "nyt-games-prd.appspot.com";
    .connect_timeout = 10s;
    .first_byte_timeout = 15s;
    .between_bytes_timeout = 15s;
    .probe = {
        .url = "/status.txt";
        .timeout = 10s;
        .interval = 10s;
        .window = 5;
        .threshold = 3;
    }
}

backend games_web_prd {
    .host = "puzzles.prd.nyt.net";
    .port = "443";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .ssl_cert_hostname = "puzzles.prd.nyt.net";
    .ssl_sni_hostname  = "puzzles.prd.nyt.net";
    .ssl = true;
    .ssl_check_cert = never;
    .probe = {
        .url = "/health-web";
        .timeout = 10s;
        .interval = 5s;
        .window = 5;
        .threshold = 3;
    }
}

backend games_assets_prd {
    .host = "storage.googleapis.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "storage.googleapis.com";
    .ssl_sni_hostname = "storage.googleapis.com";
    .ssl_check_cert = always;
    .ssl = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/games-assets/fastly-up.txt";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
        .expected_response = 200;
    }
}

backend subscription_prd {
    .host = "mwcm-pub-est-prd-iad1-121757-1072184006.us-east-1.elb.amazonaws.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status";
        .timeout = 3s;
        .interval = 5s;
        .window = 5;
        .threshold = 4;
    }
}

backend gae_oembed_content_api_prd {
    .host = "nyt-du-prd.appspot.com";
    .ssl_cert_hostname = "nyt-du-prd.appspot.com";
    .port = "443";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .ssl = true;
    .probe = {
        .url = "/healthcheck";
        .timeout = 3s;
        .interval = 60s;
        .window = 5;
        .threshold = 4;
    }
}

backend content_api_prd {
    .host = "content.api.nytimes.com";
    .ssl_cert_hostname = "content.api.nytimes.com";
    .port = "443";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .ssl = true;
    .probe = {
        .url = "/version.json";
        .timeout = 3s;
        .interval = 5s;
        .window = 5;
        .threshold = 4;
    }
}

backend times_journeys_prd {
    .host = "timesjourneys.nytimes.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "timesjourneys.nytimes.com";
    .ssl_sni_hostname = "timesjourneys.nytimes.com";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .ssl = true;
    .ssl_check_cert = always;
    .probe = {
        .request = "HEAD / HTTP/1.1" "Host: timesjourneys.nytimes.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
        .threshold = 1;
        .window = 2;
        .timeout = 5s;
        .initial = 1;
        .expected_response = 200;
        .interval = 10s;
    }
}

backend times_journeys_students_prd {
    .host = "timesjourneysstudents.nytimes.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "timesjourneysstudents.nytimes.com";
    .ssl_sni_hostname = "timesjourneysstudents.nytimes.com";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .ssl = true;
    .ssl_check_cert = always;
    .probe = {
        .request = "HEAD / HTTP/1.1" "Host: timesjourneysstudents.nytimes.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
        .threshold = 1;
        .window = 2;
        .timeout = 5s;
        .initial = 1;
        .expected_response = 200;
        .interval = 10s;
    }
}

backend projectvi_asset_prd {
    .host = "storage.googleapis.com";
    .port = "443";
    .dynamic = true;
    .host_header = "storage.googleapis.com";
    .ssl_cert_hostname = "storage.googleapis.com";
    .ssl_sni_hostname = "storage.googleapis.com";
    .ssl_check_cert = always;
    .ssl = true;
    .probe = {
        .url = "/vi-assets/up.txt";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
        .expected_response = 200;
    }
}

backend projectvi_fe_prd {
    .host = "alpha.nyt.net";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "alpha.nyt.net";
    .ssl_sni_hostname = "alpha.nyt.net";
    .ssl = true;
    .ssl_check_cert = always;
    .connect_timeout = 10s;
    .first_byte_timeout = 30s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.healthcheck";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
    }
}

backend collection_fe_prd {
    .host = "nyt5-app-collection.prd.oma1.nyt.net";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "nyt5-app-collection.prd.oma1.nyt.net";
    .ssl_sni_hostname = "nyt5-app-collection.prd.oma1.nyt.net";
    .ssl = true;
    .ssl_check_cert = always;
    .connect_timeout = 10s;
    .first_byte_timeout = 30s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
    }
}

backend article_fe_prd {
    .host = "nyt5-app-article.prd.oma1.nyt.net";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "nyt5-app-article.prd.oma1.nyt.net";
    .ssl_sni_hostname = "nyt5-app-article.prd.oma1.nyt.net";
    .ssl = true;
    .ssl_check_cert = always;
    .connect_timeout = 10s;
    .first_byte_timeout = 30s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
    }
}

director nyt5_article_director_prd random {
  {
    .backend = www_fe_prd;
    .weight  = 50;
  }{
    .backend = article_fe_prd;
    .weight  = 50;
  }
}

backend slideshow_fe_prd {
    .host = "nyt5-app-slideshow.prd.oma1.nyt.net";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "nyt5-app-slideshow.prd.oma1.nyt.net";
    .ssl_sni_hostname = "nyt5-app-slideshow.prd.oma1.nyt.net";
    .ssl = true;
    .ssl_check_cert = always;
    .connect_timeout = 10s;
    .first_byte_timeout = 30s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
    }
}

backend vp_prd {
    .host = "vp.nyt.com";
    .port = "443";
    .dynamic = true;
    .host_header = "vp.nyt.com";
    .ssl_cert_hostname = "vp.nyt.com";
    .ssl_sni_hostname = "vp.nyt.com";
    .ssl_check_cert = always;
    .ssl = true;
    .probe = {
        .request = "HEAD /video/360/video.min.js HTTP/1.1" "Host: vp.nyt.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
        .expected_response = 200;
    }
}

backend tbooks_prd {
    .host = "nytinsider.wordpress.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "nytinsider.wordpress.com";
    .ssl_sni_hostname = "nytinsider.wordpress.com";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .ssl = true;
    .ssl_check_cert = always;
    .probe = {
        .request = "HEAD / HTTP/1.1" "Host: nytinsider.wordpress.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
        .threshold = 1;
        .window = 2;
        .timeout = 5s;
        .initial = 1;
        .expected_response = 200;
        .interval = 10s;
    }
}

backend glogin_healthcheck_prd {
    .host = "www.gtm.nytimes.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "www.nytimes.com";
    .connect_timeout = 10s;
    .first_byte_timeout = 30s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/glogin";
        .timeout = 3s;
        .interval = 3s;
        .window = 15;
        .threshold = 1;
        .initial = 15;
        .expected_response = 302;
    }
}

backend adx_static_prd {
    .host = "storage.googleapis.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "storage.googleapis.com";
    .ssl_sni_hostname = "storage.googleapis.com";
    .ssl_check_cert = always;
    .ssl = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .request = "HEAD /healthcheck.txt HTTP/1.1" "Host: nyt-adx-static.storage.googleapis.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
        .threshold = 3;
        .window = 5;
        .timeout = 2s;
        .initial = 2;
        .expected_response = 200;
        .interval = 5s;
    }
}
