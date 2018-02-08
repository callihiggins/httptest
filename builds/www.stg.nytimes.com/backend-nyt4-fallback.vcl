sub vcl_deliver {

    # Route all slideshows to NYT5 GKE and if the slideshow returns 404,
    # fallback to WWW ESX to serve the NYT4 version of the slideshow.
    # This is a short term solution until slideshows missing data in PAPI are fixed or archived.
    if (resp.http.X-PageType == "slideshow"
        && resp.http.x-nyt-backend == "slideshow_fe"
        && resp.status == 404) {
        set req.http.x-nyt-slideshow-compatibility = "NYT4";

        return (restart);
    }

    // expose the slideshow compatibility header on internal network
    if (req.http.x-nyt-internal-access) {
      set resp.http.x-nyt-slideshow-compatibility = req.http.x-nyt-slideshow-compatibility;
    }

}

sub vcl_hash {

  # incase of slideshow fallback to NYT4, update the hash key for restart
  if (req.http.x-nyt-slideshow-compatibility) {
    set req.hash += req.http.x-nyt-slideshow-compatibility;
  }

}
