sub vcl_recv {
    // collapse repeated slashes in URL
    set req.url = regsuball(req.url, "[\/]+", "\/");
}
