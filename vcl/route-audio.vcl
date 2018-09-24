sub recv_route_audio {
  // audio asset page
  if (req.url ~ "^/audio/") {
    set req.http.x-nyt-route = "audio";
    set req.http.x-nyt-backend = "projectvi_fe";
    set req.http.var-nyt-error-retry = "false";
    set req.http.var-nyt-wf-auth = "true";
    set req.http.var-nyt-send-gdpr = "true";
    unset req.http.Authorization;

    call recv_post_method_restricted;
  }
}
