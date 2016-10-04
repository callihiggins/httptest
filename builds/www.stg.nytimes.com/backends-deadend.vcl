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

backend beta_deadend {
    .host = "localhost";
    .port = "8080";
    .dynamic = true;
    .probe = {
        .url = "/.status";
        .initial = 0;
        .interval = 1d;
    }
}

# commenting these until watching is fixed 
/*
backend beta_watching_deadend {
    .host = "localhost";
    .port = "8080";
    .dynamic = true;
    .probe = {
        .url = "/.status";
        .initial = 0;
        .interval = 1d;
    }
}
*/