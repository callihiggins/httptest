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

backend newsdev_k8s_elb_prd {
    .host = "fastly-k8s-prd-pub-elb-636293017.us-east-1.elb.amazonaws.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .request =
            "GET /interactive/projects/.healthcheck HTTP/1.1"
            "Host: www.nytimes.com"
            "Connection: close"
            "Accept: */*";
        .timeout = 10s;
        .interval = 30s;
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

backend newsdev_instance_prd_use1_1 {
    .host = "54.221.244.128";
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

backend newsdev_instance_prd_use1_2 {
    .host = "54.163.228.138";
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

backend newsdev_instance_prd_usw1_1 {
    .host = "50.18.47.251";
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

backend newsdev_instance_prd_usw1_2 {
    .host = "54.215.5.96";
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

director newsdev_elections_prd round-robin {
    { .backend = newsdev_instance_prd_use1_1; }
    { .backend = newsdev_instance_prd_use1_2; }
    { .backend = newsdev_instance_prd_usw1_1; }
    { .backend = newsdev_instance_prd_usw1_2; }
}

backend beta_guides_prd {
    .host = "guides.nyt.com";
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

backend games_prd {
    .host = "nyt-games-prd.appspot.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "nyt-games-prd.appspot.com";
    .host_header = "nyt-games-prd.appspot.com";
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

backend subscription_prd {
    .host = "mwcm-app-est-public-prd-i-111546-340655147.us-east-1.elb.amazonaws.com";
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
