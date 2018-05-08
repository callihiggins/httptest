sub recv_route_slideshow {
  // Route slideshow to NYT5 GKE if slideshow-compatibility is not set.
  // If slideshow-compatibility is set, fallback to Legacy GKE.
  if (req.url ~ "^/slideshow/" && !req.http.x-nyt-slideshow-compatibility) {
      set req.http.x-nyt-route = "slideshow";
      set req.http.x-nyt-backend = "slideshow_fe";
      set req.http.var-nyt-wf-auth = "true";

      # if we needed to switch back to NYT5, unset the vi flag
      unset req.http.x--fastly-project-vi;
  }

  // Route slideshow 2017 onwards to Project Vi.
  //
  // Except for realestate slideshows, because of $$$$$$$$$ (or, there's an
  // ad format that's being used by the realestate team and it's currently
  // not supported on Vi).
  //
  // TODO(fsouza): remove the realestate hack once backend is fixed.
  if (req.url ~ "^/slideshow/2(01[7-9]|(0[2-9][0-9])|([1-9][0-9][0-9]))/" && req.url !~ "/realestate/") {
      set req.http.x-nyt-route = "vi-slideshow";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.x-nyt-wf-auth = "true";
      set req.http.x--fastly-project-vi = "1";
  }

  // slideshow JSON files
  if (req.url ~ "\.slideshow\.json$") {
      set req.http.x-nyt-route = "legacy-gke";
      set req.http.x-nyt-backend = "www_legacy_gke";
  }
}

sub deliver_slideshow_fallback {

    # Route all slideshows to NYT5 GKE and if the slideshow returns 404,
    # fallback to Legacy GKE to redirect to archive slideshow.
    if (resp.http.x-nyt-route == "slideshow"
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

sub hash_route_slideshow {

  # incase of slideshow fallback to NYT4, update the hash key for restart
  if (req.http.x-nyt-slideshow-compatibility) {
    set req.hash += req.http.x-nyt-slideshow-compatibility;
  }

}
