backend alpha_fe_dev {
    .host = "35.186.219.140";
    .port = "80";
    .probe = {
        .url = "/.healthcheck";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
    }
}

backend alpha_fe_test {
    .host = "35.186.210.71";
    .port = "80";
    .probe = {
        .url = "/";
        .timeout = 10s;
        .interval = 60s;
        .window = 4;
        .threshold = 3;
    }
}

backend alpha_home_branch {
    .host = "130.211.47.210";
    .port = "80";
    .probe = {
        .url = "/";
        .timeout = 10s;
        .interval = 60s;
        .window = 4;
        .threshold = 3;
    }
}

backend alpha_fe_preview {
    .host = "35.186.218.67";
    .port = "80";
    .probe = {
        .url = "/.healthcheck";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
    }
}

backend alpha_fe_prd {
    .host = "130.211.7.66";
    .port = "80";
    .probe = {
        .url = "/.healthcheck";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
    }
}

backend deadend {
    .host = "localhost";
    .port = "8080";
    .dynamic = true;
    .probe = {
        .url = "/.status";
        .initial = 0;
        .interval = 1d;
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