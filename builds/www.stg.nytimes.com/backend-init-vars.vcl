# this should execute before any other backend route vcl_error logic
# need to capture backend health state info for logging
# too many backend routes are defining their own vcl_error right now

sub vcl_error {

  # based on some fastly documentation it looks like 
  # the response always has the string "healthy" when
  # we entered vcl_error because the backend was unhealthy
  # lets set a header var we can capture and log / return
  if(std.tolower(obj.response) ~ "healthy"){
    set obj.http.x-nyt-backend-health = "0";
  } else {
    set obj.http.x-nyt-backend-health = "1";
  }
}
