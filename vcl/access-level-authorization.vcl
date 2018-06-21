# set access level headers depending on IP ACL or Header auth
sub recv_set_access_level {
  # if client IP is "internal" authorized, let them in and set a header (unless already set):
  if (client.ip ~ internal || client.ip ~ vpc_nat_gateway || table.lookup(internal_access_tokens_2, req.http.x-fastly-stg) ~ "^[0-9]{8}$") {
    set req.http.x-allow-access-nyt-internal = "1";
    if (!req.http.x-nyt-internal-access) { # this is used everywhere in logic, so let authorized clients override
      set req.http.x-nyt-internal-access = "1";
    }
  } else { # unset access level for all unauthorized IPs
    unset req.http.x-allow-access-nyt-internal;
    unset req.http.x-nyt-internal-access;
  }

  # if client IP is "external" authorized, let them in and set a header (unless already set):
  if (client.ip ~  external_staging_access || table.lookup(staging_access_tokens_2, req.http.x-fastly-stg) ~ "^[0-9]{8}$") {
    set req.http.x-allow-access-nyt-external = "1";
    if (!req.http.x-nyt-external-access) { # this is used everywhere in logic, so let authorized clients override
      set req.http.x-nyt-external-access = "1";
    }
  } else { # unset access level for all unauthorized IPs
    unset req.http.x-allow-access-nyt-external;
    unset req.http.x-nyt-external-access;
  }
}

# block access to the service based on environment and access level
sub recv_restrict_access {

  # first, check to make sure this IP is not blacklisted from all envs
  if (client.ip ~ blacklist) {
    error 403 "Forbidden";
  }

  if (req.http.var-nyt-env == "dev" && !req.http.x-allow-access-nyt-internal) {
    error 403 "Forbidden";
  }

  # block everyone but internal acl, aws vpc acl, and whitelisted header to staging service
  if (req.http.var-nyt-env == "stg" && !req.http.x-allow-access-nyt-internal && !req.http.x-allow-access-nyt-external) {
    error 403 "Forbidden";
  }
}
