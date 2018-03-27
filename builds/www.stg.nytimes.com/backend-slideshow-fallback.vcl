sub vcl_deliver {

    # Route all slideshows to NYT5 GKE and if the slideshow returns 404,
    # fallback to Legacy GKE to redirect to archive slideshow.
    if (resp.http.X-PageType == "slideshow"
        && resp.http.x-nyt-backend == "slideshow_fe"
        && resp.status == 404) {
        set req.http.x-nyt-slideshow-compatibility = "NYT4";
        set req.url = req.http.X-OriginalUri;
        set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " NYT4 slideshow", "NYT4 slideshow");
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
