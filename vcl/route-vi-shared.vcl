sub recv_route_vi_shared_force_pass_override_check {

  # if we detect:
  #   - the vi-force-pass cookie is present and == "1"
  #   - the backend is `projectvi_fe`
  #   - the user is authenticated as NYHQ role user
  # mark this request for a force pass so the client can see the vi origin output and avoid cache
  # we are also going to force the backend to the origin, the cookie will not be passed to the shield
  if (req.http.Cookie:projectvi-force-pass == "1" &&
      req.http.x-nyt-nyhq-access == "1" &&
      req.http.x-nyt-backend == "projectvi_fe") {
    set req.http.var-nyt-force-pass = "true";
    set req.backend = F_projectvi_fe;
  }
}
