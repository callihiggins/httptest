
sub vcl_recv {
    set req.http.X-url = regsub(req.url, "(\?.*)$", "");

    if (req.http.X-url ~ "^/(interactive|live|video|spotlight|news-event|reviews)/") {
        set req.http.redirect-url = "http://www.nytimes.com" + req.url;
        error 770 req.http.redirect-url;
    }

    if (req.http.X-url ~ "^/(trending)(/)?$") {
        if (req.url !~ "/$") {
            set req.http.redirect-url = "http://www.nytimes.com" + req.url + "/";
            error 770 req.http.redirect-url;
        }
        set req.http.redirect-url = "http://www.nytimes.com" + req.url;
        error 770 req.http.redirect-url;
    }

    if (req.http.X-url ~ "^/politics/first-draft(/)?") {
        set req.http.redirect-url = "http://www.nytimes.com" + req.url;
        error 770 req.http.redirect-url;
    }

    if (req.http.X-url ~ "^(/blogs)?/t(-)?magazine(/)?$") {
        error 770 "http://www.nytimes.com/section/t-magazine";
    }

    if (req.http.X-url ~ "^/(video(/)?|vdetail(/.*)?)$") {
        error 770 "http://www.nytimes.com/video/";
    }

    if (req.http.X-url ~ "^/blogs/thecaucus(/)?$" ||
        req.http.X-url ~ "^/bb/thecaucus(/.*)?") {
        error 770 "http://www.nytimes.com/politics/first-draft/";
    }

    if (req.http.X-url ~ "/books/bestsellers") {
        set req.http.X-url-books = regsub(req.http.X-url, "^/books/bestsellers", "");
        set req.http.redirect-url = "http://www.nytimes.com/books/best-sellers" + req.http.X-url-books;
        error 770 req.http.redirect-url;
    }

    if (req.http.X-url ~ "^/2013/10/27/newsgraphics/a-game-of-shark-and-minnow.html") {
        error 770 "http://www.nytimes.com/newsgraphics/2013/10/27/south-china-sea/";
    }

    if (req.http.X-url ~ "^/(newsgraphics|magazine)/2013/10/27/south-china-sea/") {
        error 770 "http://www.nytimes.com/newsgraphics/2013/10/27/south-china-sea/";
    }

    if (req.http.X-url ~ "^/slideshow/100000003265920/2014/12/04/fashion/the-uncut-gotham-awards.html") {
        error 770 "http://www.nytimes.com/projects/awards-season/2014/red-carpet/gotham-awards/";
    }

    if (req.http.X-url ~ "^/nytapps") {
        if (req.http.user-agent ~ "iPhone") {
            error 770 "https://82650.measurementapi.com/serve?action=click&publisher_id=82650&site_id=50290&my_campaign=Applenews_Sep15";
        } else {
            error 770 "https://82650.measurementapi.com/serve?action=click&publisher_id=82650&site_id=50288&my_campaign=Applenews_Sep15";
        }
    }
}

sub vcl_error {
    if (obj.status == 770) {
        set obj.http.Location = obj.response;
        set obj.status = 301;
        return(deliver);
    }
}
