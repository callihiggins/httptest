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

backend newsdev_k8s_elb_stg {
    .host = "fastly-k8s-stg-pub-elb-1179075004.us-east-1.elb.amazonaws.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .request =
            "GET /interactive/projects/.healthcheck HTTP/1.1"
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
    .ssl = true;
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

backend newsdev_instance_stg_use1_1 {
    .host = "23.21.133.252";
    .port = "80";
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/healthchecke";
        .timeout = 1s;
        .interval = 4s;
        .window = 5;
        .threshold = 4;
    }
}

backend newsdev_instance_stg_usw1_1 {
    .host = "54.215.2.74";
    .port = "80";
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/healthchecke";
        .timeout = 1s;
        .interval = 4s;
        .window = 5;
        .threshold = 4;
    }
}

director newsdev_elections_stg round-robin {
    { .backend = newsdev_instance_stg_use1_1; }
    { .backend = newsdev_instance_stg_usw1_1; }
}

backend games_svc_stg {
    .host = "nyt-games-dev.appspot.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "nyt-games-dev.appspot.com";
    .host_header = "nyt-games-dev.appspot.com";
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

backend beta_guides_stg {
    .host = "guides.stg.nyt.com";
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
    .host = "35.186.240.2";
    .port = "80";
    .probe = {
        .url = "/.healthcheck";
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
