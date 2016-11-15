
backend blogs_fe_stg {
    .host = "www.stg.gtm.nytimes.com";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/status.txt";
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
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}


#ELECTIONS BACKENDS
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

backend games_stg {
    .host = "nyt-games-dev.appspot.com";
    .port = "443";
    .dynamic = true;
    .ssl_cert_hostname = "nyt-games-dev.appspot.com";
    .host_header = "nyt-games-dev.appspot.com";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 10s;
    .probe = {
        .url = "/svc/crosswords/v2/puzzle/1.json";
        .timeout = 10s;
        .interval = 30s;
        .window = 10;
        .threshold = 8;
    }
}

# commenting out well backends until they are fixed
/*
backend beta_instance_stg_use1_1 {
    .host = "well-proxy-0.stg.np.newsdev.net";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/api/health";
        .timeout = 1s;
        .interval = 4s;
        .window = 10;
        .threshold = 9;
    }
}

director beta_well_stg round-robin {
    { .backend = beta_instance_stg_use1_1; }
}
*/


# commenting these until watching is fixed
/*
backend beta_watching_stg_instance_1 {
    .host = "beta-proxy-0.stg.np.newsdev.net";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/watching/api/health";
        .timeout = 1s;
        .interval = 30s;
        .window = 5;
        .threshold = 5;
    }
}

backend beta_watching_stg_instance_2 {
    .host = "beta-proxy-1.stg.np.newsdev.net";
    .port = "80";
    .dynamic = true;
    .connect_timeout = 5s;
    .first_byte_timeout = 5s;
    .between_bytes_timeout = 5s;
    .probe = {
        .url = "/watching/api/health";
        .timeout = 1s;
        .interval = 30s;
        .window = 5;
        .threshold = 5;
    }
}

director beta_watching_stg round-robin {
    { .backend = beta_watching_stg_instance_1; }
    { .backend = beta_watching_stg_instance_2; }
}
*/