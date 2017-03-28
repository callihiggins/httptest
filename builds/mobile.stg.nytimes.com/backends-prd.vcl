backend mobileweb_fe_prd {
    .host = "mwr.gtm.nytimes.com";
    .port = "80";
    .dynamic = true;
    .probe = {
        .url = "/.status";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
    }    
}

backend projectvi_fe_prd {
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