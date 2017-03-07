backend mobileweb_fe_dev {
    .host = "mobileweb.stg.gtm.nytimes.com";
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

backend projectvi_fe_dev {
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
