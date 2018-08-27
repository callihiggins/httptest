sub recv_route_slideshow {
  # Route slideshow to Vi if slideshow-compatibility is not set.
  # If slideshow-compatibility is set, fallback to Legacy GKE.
  if (req.url ~ "^/slideshow/" && !req.http.x-nyt-slideshow-compatibility) {
      set req.http.x-nyt-route = "vi-slideshow";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.var-nyt-error-retry = "false";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";
      set req.http.x--fastly-project-vi = "1";
      set req.url = querystring.remove(req.url);
      unset req.http.Authorization;

      call recv_post_method_restricted;
  }

  # slideshow JSON files
  if (req.url ~ "\.slideshow\.json$") {
      set req.http.x-nyt-route = "legacy-gke";
      set req.http.x-nyt-backend = "www_legacy_gke";
  }
}

sub deliver_slideshow_fallback {

    # Route all slideshows to Vi and if the slideshow returns 404 or 400,
    # fallback to Legacy GKE to redirect to archive slideshow.
    if (resp.http.x-nyt-route == "vi-slideshow"
        && resp.http.x-nyt-backend == "projectvi_fe"
        && (resp.status == 404 || resp.status == 400)) {
        set req.http.x-nyt-slideshow-compatibility = "NYT4";
        set req.url = req.http.x-nyt-original-url;
        set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " NYT4 slideshow", "NYT4 slideshow");
        return (restart);
    }

    # expose the slideshow compatibility header on internal network
    if (req.http.x-nyt-nyhq-access) {
      set resp.http.x-nyt-slideshow-compatibility = req.http.x-nyt-slideshow-compatibility;
    }

}

sub hash_route_slideshow {

  # incase of slideshow fallback to NYT4, update the hash key for restart
  if (req.http.x-nyt-slideshow-compatibility) {
    set req.hash += req.http.x-nyt-slideshow-compatibility;
  }

}
