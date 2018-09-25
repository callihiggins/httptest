sub log_sumologic {    
    # suppress logs for certain low risk high traffic services
    # log 4xx status ALWAYS
    # log everything in dev and stg
    if (
           (req.url !~ "^/svc/(web-products|comscore)" && req.url !~ "^/adx/" && req.http.x-nyt-route != "vi-assets")
        || resp.status >= 400
        || req.http.var-nyt-env != "prd"
       ) {

      log {"syslog "} + req.service_id + {" "} + req.http.var-nyt-logger-name + {" :: "}
      req.http.Fastly-Client-IP
      {" "-" "-" "}
      {"["} strftime({"%d/%b/%Y:%H:%M:%S %z"}, time.start) {"]"}
      {" "} cstr_escape(req.http.host)
      {" ""} cstr_escape(req.request) " " cstr_escape(req.url) " " cstr_escape(req.proto) {"""}
      {" "} resp.status
      {" "} regsub(resp.body_bytes_written, "^0$", {""-""})
      {" ""} cstr_escape(req.http.referer) {"""}
      {"" ""} cstr_escape(req.http.user-agent) {"""}
      {" backend=["} if(req.http.x-nyt-backend,req.http.x-nyt-backend,"-") {"]"}
      {" pagetype=["} if(resp.http.x-PageType,resp.http.x-PageType,"-") {"]"}
      {" route=["} resp.http.x-nyt-route {"]"}
      {" apiversion=["} if(resp.http.X-API-Version,resp.http.X-API-Version,"-") {"]"}
      {" cachetype=["} if(fastly_info.state,fastly_info.state,"-") {"]"}
      {" reqtime=["} time.elapsed {"]"}
      {" reqsize=["} req.bytes_read {"]"}
      {" protocol=["} if(req.http.Fastly-SSL,"https","http") {"]"}
      {" behealth=["} if(req.http.x-nyt-backend-health,req.http.x-nyt-backend-health,"-") {"]"}
      if(resp.http.Fastly-Restarts, {" restarts=["} resp.http.Fastly-Restarts {"]"},"")
      if(req.http.x-nyt-restart-reason,{" restart_reason=["} req.http.x-nyt-restart-reason {"]"}, "")
      if(req.http.var-nyt-redirect-reason, {" "} + req.http.var-nyt-redirect-reason, "")
      {" is_shield=["} if(req.http.x-nyt-shield-auth,"1","0") {"]"};
    }
}
