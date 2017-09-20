sub vcl_recv {
    // collapse repeated slashes in URL
    // this was breaking query params with schemes in them, don't normalize those
    if (req.url !~ "https?.{1,3}\/\/"){
    	set req.url = regsuball(req.url, "[\/]+", "\/");
    }
}