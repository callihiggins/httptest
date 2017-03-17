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
