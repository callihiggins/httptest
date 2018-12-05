sub recv_sumologic_purge_log_line {
  log {"syslog "} req.service_id {" "} req.http.var-nyt-logger-name {" :: "}
  {"ip=["} req.http.Fastly-Client-IP {"]"}
  {" protocol=["} if(req.http.Fastly-SSL,"https","http") {"]"}
  {" host=["} cstr_escape(req.http.host) {"]"}
  {" request=["} cstr_escape(req.request) {"]"}
  {" url=["} cstr_escape(req.url) {"]"}
  {" ua=["} cstr_escape(req.http.user-agent) {"]"}
  {" route=["} req.http.x-nyt-route {"]"}
  {" key=["} regsub(req.http.Fastly-Key, "([a-zA-Z0-9]{4}).*", "\1") {"]"}
  {" soft=["} req.http.Fastly-Soft-Purge {"]"};

  log {"syslog "} req.service_id {" "} req.http.var-nyt-sumo-purge-log-name {" :: "}
  {"  {  "client_ip":""} req.http.Fastly-Client-IP {"", "protocol":""} if(req.http.Fastly-SSL,"https","http") {"", "host":""} cstr_escape(req.http.host) {"", "request":""} req.request {"",  "soft":""} cstr_escape(req.http.fastly-soft-purge) {"",  "key":""} cstr_escape(regsub(req.http.Fastly-Key, "([a-zA-Z0-9]{4}).*", "\1")) {"",  "url":""} cstr_escape(req.url) {"",  "request_user_agent":""} cstr_escape(req.http.user-agent) {"", "route":""} if(req.http.x-nyt-route,req.http.x-nyt-route,"") {""  }   "};

}
