sub recv_route_slideshow {
  # Route slideshow to NYT5 GKE if slideshow-compatibility is not set.
  # If slideshow-compatibility is set, fallback to Legacy GKE.
  if (req.url ~ "^/slideshow/" && !req.http.x-nyt-slideshow-compatibility) {
      set req.http.x-nyt-route = "slideshow";
      set req.http.x-nyt-backend = "slideshow_fe";
      set req.http.var-nyt-wf-auth = "true";
      set req.http.var-nyt-send-gdpr = "true";

      call recv_route_slideshow_filter_querystring;

      # if we needed to switch back to NYT5, unset the vi flag
      unset req.http.x--fastly-project-vi;
  }

  # Route non-realestate slideshows to Project Vi.
  #
  # realestate slideshows still go to NYT5 because of $$$$$$$$$ (or, there's
  # an ad format that's being used by the realestate team and it's currently
  # not supported on Vi).
  #
  # TODO(fsouza): remove the realestate hack once backend is fixed.
  if (req.url ~ "^/slideshow/" && req.url !~ "/realestate/" && !req.http.x-nyt-slideshow-compatibility) {
      set req.http.x-nyt-route = "vi-slideshow";
      set req.http.x-nyt-backend = "projectvi_fe";
      set req.http.x-nyt-wf-auth = "true";
      set req.http.x--fastly-project-vi = "1";
      set req.url = querystring.remove(req.url);
  }

  # slideshow JSON files
  if (req.url ~ "\.slideshow\.json$") {
      set req.http.x-nyt-route = "legacy-gke";
      set req.http.x-nyt-backend = "www_legacy_gke";
  }
}

sub deliver_slideshow_fallback {

    # Route all slideshows to Vi/NYT5 GKE and if the slideshow returns 404 or 400,
    # fallback to Legacy GKE to redirect to archive slideshow.
    if (resp.http.x-nyt-route ~ "^(slideshow|vi-slideshow)$"
        && resp.http.x-nyt-backend ~ "^(slideshow_fe|projectvi_fe)$"
        && (resp.status == 404 || resp.status == 400)) {
        set req.http.x-nyt-slideshow-compatibility = "NYT4";
        set req.url = req.http.x-nyt-original-url;
        set req.http.x-nyt-restart-reason = if(req.http.x-nyt-restart-reason, req.http.x-nyt-restart-reason + " NYT4 slideshow", "NYT4 slideshow");
        return (restart);
    }

    # expose the slideshow compatibility header on internal network
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

sub miss_pass_route_slideshow {
  if (req.http.x-nyt-route == "slideshow") {
    unset bereq.http.cookie;
  }
}

sub recv_route_slideshow_filter_querystring {
  set req.url = querystring.filter_except(req.url,
      "action" + querystring.filtersep() +
      "contentCollection" + querystring.filtersep() +
      "contentPlacement" + querystring.filtersep() +
      "currentSlide" + querystring.filtersep() +
      "entrySlide" + querystring.filtersep() +
      "module" + querystring.filtersep() +
      "pgtype" + querystring.filtersep() +
      "region" + querystring.filtersep() +
      "slideshowTitle" + querystring.filtersep() +
      "url" + querystring.filtersep() +
      "version");
}