
backend blogs_fe_prd {
    .host = "www.gtm.nytimes.com";
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

#ELECTIONS BACKENDS
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

# commenting out well backends until they are done
/*
backend beta_instance_prd_use1_1 {
    .host = "well-proxy-0.prd.np.newsdev.net";
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

backend beta_instance_prd_use1_2 {
    .host = "well-proxy-1.prd.np.newsdev.net";
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

director beta_well_prd round-robin {
    { .backend = beta_instance_prd_use1_1; }
    { .backend = beta_instance_prd_use1_2; }
}
*/


# commenting these until watching is fixed
/*
backend beta_watching_prd_instance_1 {
    .host = "beta-proxy-0.prd.np.newsdev.net";
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

backend beta_watching_prd_instance_2 {
    .host = "beta-proxy-1.prd.np.newsdev.net";
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

director beta_watching_prd round-robin {
    { .backend = beta_watching_prd_instance_1; }
    { .backend = beta_watching_prd_instance_2; }
}
*/