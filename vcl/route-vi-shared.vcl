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

# Preserves the querystring in the response when vi gives us a 301 redirect
# only preserved `unlocked_article_code` querystring
sub deliver_route_vi_preserve_unlocked_article_code_querystring {
  if (req.http.x-nyt-backend == "projectvi_fe" && resp.status == 301 && req.http.Fastly-SSL && !req.http.x-nyt-shield-auth) {
    if (req.http.x-nyt-orig-querystring ~ "unlocked_article_code=") {
      declare local var.cleaned_querystring STRING;
      set var.cleaned_querystring = querystring.filter_except(req.http.x-nyt-orig-querystring, "unlocked_article_code");
      set resp.http.Location = resp.http.Location + var.cleaned_querystring;
    }
  }
}
