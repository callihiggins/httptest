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
    .host = "130.211.32.153"; // GCP Ingress IP address
    .port = "80";
    .probe = {
        .url = "/.healthcheck";
        .timeout = 5s;
        .interval = 20s;
        .window = 4;
        .threshold = 3;
    }
}
