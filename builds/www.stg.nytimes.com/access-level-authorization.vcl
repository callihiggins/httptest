# set access level headers depending on IP ACL or Header auth
sub recv_set_access_level {

  # Reset access levels before setting them
  unset req.http.x-nyt-internal-access;
  unset req.http.x-nyt-external-access;

  if (client.ip ~ internal || client.ip ~ vpc_nat_gateway || client.ip ~ fastly || table.lookup(internal_access_tokens_2, req.http.x-fastly-stg) ~ "^[0-9]{8}$") {
    set req.http.x-nyt-internal-access = "1";
  }

  if (client.ip ~  external_staging_access || table.lookup(staging_access_tokens_2, req.http.x-fastly-stg) ~ "^[0-9]{8}$") {
    set req.http.x-nyt-external-access = "1";
  }

}

# block access to the service based on environment and access level
sub recv_restrict_access {

  # first, check to make sure this IP is not blacklisted from all envs
  if (client.ip ~ blacklist) {
    error 403 "Forbidden";
  }

  if (req.http.var-nyt-env == "dev" && !req.http.x-nyt-internal-access) { 
    error 403 "Forbidden";
  }

  # block everyone but internal acl, aws vpc acl, and whitelisted header to staging service
  if (req.http.var-nyt-env == "stg" && !req.http.x-nyt-internal-access && !req.http.x-nyt-external-access) {
    error 403 "Forbidden";
  }
}
