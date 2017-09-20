sub vcl_recv {

    # Emergency Kill Switch for glogin service
    # uncomment set set req header line below to disable glogin
    # comment it out to re-enable glogin

    # set req.http.x-skip-glogin = "1";
}