# this should execute before any other vcl_fetch logic
# need to capture backend state info for logging
# TODO: put in a custom sub during upcoming refactor
# too many backend routes are defining their own vcl_fetch right now

sub vcl_fetch {
  set beresp.http.X-NYT-Backend = beresp.backend.name;

  # using a string here due to conditionals not differentiating false and null
  # need three states for this value
  if (req.backend.healthy) {
    set beresp.http.x-nyt-backend-health = "1";
  } else {
    set beresp.http.x-nyt-backend-health = "0";
  }
}