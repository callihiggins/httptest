backend default {
    .host = "mobile.stg.nytimes.com";
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