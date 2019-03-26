# These subroutines maintain the Agent ID (nyt-a cookie).
# Agent ID is a kind of per-client unique id (not in strict UUID format).
# See: <https://confluence.nyt.net/pages/viewpage.action?pageId=57053741>

sub recv_create_agent_id_var {
    # handle the nyt-a cookie in a restart safe manner
    if (!req.http.var-cookie-nyt-a && req.http.Cookie:nyt-a) {
      set req.http.var-cookie-nyt-a = req.http.Cookie:nyt-a;
    }

    if (req.http.var-cookie-nyt-a !~ ".") { # if nyt-a doesn't match any character, it's either empty string or NULL
      # we didn't get an nyt-a cookie, generate and set one
      set req.http.var-cookie-nyt-a = digest.hmac_sha256_base64(
          # key doesn't really matter for our purposes, but here's 256 bits entropy anyway:
          "1pCPYoPsNtx1aDpv8EUZ9azYZ3szwSeKFXnmHAojc3s",
          now.sec +
          randomstr(64) +
          req.http.host +
          req.http.user-agent +
          req.http.cookie +
          req.url +
          client.ip +
          req.http.Fastly-Client-IP +
          time.start.usec +
          time.elapsed.usec +
          client.port +
          server.identity
      );

      // we only need 22 base64 chars to reach 128 bits entropy (22 * 6 = 132):
      set req.http.var-cookie-nyt-a = regsub(req.http.var-cookie-nyt-a, "^(.{22}).*$", "\1");
      // replace '+' and '/' with cookie-safe '-' and '_':
      set req.http.var-cookie-nyt-a = regsuball(req.http.var-cookie-nyt-a, "\+", "-");
      set req.http.var-cookie-nyt-a = regsuball(req.http.var-cookie-nyt-a, "\/", "_");
    }
}

sub deliver_set_agent_id_cookie {
    # set the header
    # this will either set a new cookie
    # or extend the existing one to a year
    # we will only do this for content pages
    # do not send this cookie if we are on a shield pop
    if (!req.http.x-nyt-shield-auth) {
        if (resp.http.Content-Type ~ "^text/html(;|$)" && req.http.var-cookie-nyt-a ~ ".") {
            add resp.http.Set-Cookie =
                "nyt-a=" + req.http.var-cookie-nyt-a + "; "+
                "Expires=" + time.add(now, 365d) + "; "+
                "Path=/; "+
                "Domain=.nytimes.com";
        }
    }
}
