backend blogs_fe_stg {
    .host = "blogs.stg.gtm.nytimes.com";
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

backend www_fe_stg {
    .host = "www.stg.gtm.nytimes.com";
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

backend www_stg {
    .host = "www.stg.gtm.nytimes.com";
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

backend www_https_stg {
    .host = "www.stg.gtm.nytimes.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "www.stg.nytimes.com";
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

backend www_static_stg {
    .host = "static.stg.gtm.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/.status";
        .timeout = 10s;
        .interval = 10s;
        .window = 5;
        .threshold = 4;
    }
}

backend intl_gcp_stg {
    .host = "intl.stg.nytimes.com";
    .ssl_cert_hostname = "intl.stg.nytimes.com";
    .ssl_sni_hostname = "intl.stg.nytimes.com";
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
            "Host: www.stg.nytimes.com"
            "Connection: close"
            "Accept: */*";
        .timeout = 10s;
        .interval = 30s;
        .window = 5;
        .threshold = 4;
    }
}

backend newsdev_attribute_gclod_function_stg {
    .host = "us-central1-nytint-stg.cloudfunctions.net";
    .port = "443";
    .ssl_cert_hostname = "us-central1-nytint-stg.cloudfunctions.net";
    .ssl_sni_hostname =  "us-central1-nytint-stg.cloudfunctions.net";
    .dynamic = true;
    .connect_timeout = 300s;
    .first_byte_timeout = 300s;
    .between_bytes_timeout = 300s;
    .probe = {
        .request =
            "GET /attribute-submission/healthz HTTP/1.1"
            "Host: us-central1-nytint-stg.cloudfunctions.net"
            "Connection: close"
            "Accept: */*";
        .timeout = 300s;
        .interval = 60s;
        .window = 5;
        .threshold = 4;
    }
}

backend newsdev_k8s_gke_stg {
    .host = "gke.stg.newsdev.nytimes.com";
    .port = "443";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .request =
            "GET /healthz HTTP/1.1"
            "Host: gke.stg.newsdev.nytimes.com"
            "Connection: close"
            "Accept: */*";
        .timeout = 10s;
        .interval = 30s;
        .window = 5;
        .threshold = 4;
    }
}

backend newsdev_elections_stg {
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
        .request = "HEAD /healthcheck.txt HTTP/1.1" "Host: nytint-stg-elections.storage.googleapis.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
        .threshold = 3;
        .window = 5;
        .timeout = 2s;
        .initial = 2;
        .expected_response = 200;
        .interval = 5s;
    }
}

backend newsdev_elections_s3_stg {
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
        .request = "HEAD /healthcheck.txt HTTP/1.1" "Host: nytint-stg-elections.s3.amazonaws.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
        .threshold = 3;
        .window = 5;
        .timeout = 2s;
        .initial = 2;
        .expected_response = 200;
        .interval = 5s;
    }
}

backend newsdev_gcs_stg {
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
        .request = "HEAD /healthcheck.txt HTTP/1.1" "Host: nytint-stg-www.storage.googleapis.com" "Connection: close" "User-Agent: Varnish/fastly (healthcheck)";
        .threshold = 3;
        .window = 5;
        .timeout = 2s;
        .initial = 2;
        .expected_response = 200;
        .interval = 5s;
    }
}

backend games_svc_stg {
    .host = "nyt-games-dev.appspot.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "nyt-games-dev.appspot.com";
    .host_header = "nyt-games-dev.appspot.com";
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

backend programs_svc_stg {
    .host = "ftu-dot-nyt-betaprog-dev.appspot.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "ftu-dot-nyt-betaprog-dev.appspot.com";
    .ssl_sni_hostname = "ftu-dot-nyt-betaprog-dev.appspot.com";
    .ssl_check_cert = always;
    .ssl = true;
    .host_header = "ftu-dot-nyt-betaprog-dev.appspot.com";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/status.txt";
        .timeout = 10s;
        .interval = 5s;
        .window = 5;
        .threshold = 3;
    }
}

backend gae_oembed_content_api_stg {
    .host = "nyt-du-dev.appspot.com";
    .ssl_cert_hostname = "nyt-du-dev.appspot.com";
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

backend games_web_stg {
    .host = "puzzles.dev.nyt.net";
    .port = "443";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .ssl_cert_hostname = "puzzles.dev.nyt.net";
    .ssl_sni_hostname  = "puzzles.dev.nyt.net";
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

backend video_library_stg {
    .host = "times-video.stg.nyt.net";
    .port = "443";
    .ssl_cert_hostname = "times-video.stg.nyt.net";
    .ssl_sni_hostname = "times-video.stg.nyt.net";
    .ssl = true;
    .ssl_check_cert = always;
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

backend video_api_stg {
    .host = "cherry-api.stg.nyt.net";
    .port = "443";
    .ssl_cert_hostname = "cherry-api.stg.nyt.net";
    .ssl_sni_hostname = "cherry-api.stg.nyt.net";
    .ssl = true;
    .ssl_check_cert = always;
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

backend beta_guides_stg {
    .host = "guides.stg.nyt.net";
    .port = "443";
    .ssl_cert_hostname = "guides.stg.nyt.net";
    .ssl_sni_hostname = "guides.stg.nyt.net";
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

backend ask_well_stg {
    .host = "ask-well.stg.nyt.com";
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

backend beta_watching_stg {
    .host = "np-watching-stg-public-668029006.us-east-1.elb.amazonaws.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/api/health";
        .timeout = 3s;
        .interval = 10s;
        .window = 5;
        .threshold = 4;
    }
}

backend du_weddings_api_stg {
    .host = "du-cachepar-stg-iad2-38464-2-1123098187.us-east-1.elb.amazonaws.com";
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

backend subscription_stg {
    .host = "mwcm-pub-est-stg-iad1-121755-1402429080.us-east-1.elb.amazonaws.com";
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

backend content_api_stg {
    .host = "du-cachepar-stg-iad2-38464-2-1123098187.us-east-1.elb.amazonaws.com";
    .ssl_cert_hostname = "content.api.stg.nytimes.com";
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

backend projectvi_fe_stg {
    .host = "alpha-test.stg.nyt.net";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "alpha-test.stg.nyt.net";
    .ssl_sni_hostname = "alpha-test.stg.nyt.net";
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

backend collection_fe_stg {
    .host = "nyt5-app-collection.stg.oma1.nyt.net";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "nyt5-app-collection.stg.oma1.nyt.net";
    .ssl_sni_hostname = "nyt5-app-collection.stg.oma1.nyt.net";
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

backend article_fe_stg {
    .host = "nyt5-app-article.stg.oma1.nyt.net";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "nyt5-app-article.stg.oma1.nyt.net";
    .ssl_sni_hostname = "nyt5-app-article.stg.oma1.nyt.net";
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

backend glogin_healthcheck_stg {
    .host = "www.stg.gtm.nytimes.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "www.stg.nytimes.com";
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
