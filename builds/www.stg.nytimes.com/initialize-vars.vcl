sub vcl_recv {    
    /*
     * capture specific cookie values into custom headers
     */
    if (req.http.Cookie:NYT-S) {
      set req.http.x-nyt-s = urldecode(req.http.Cookie:NYT-S);
    }

    // detect if there are at least two NYT-S cookies
    if (req.http.x-nyt-s){
      set req.http.x-nyt-s2 = regsub(req.http.Cookie, ".*?NYT-S=.*NYT-S=([^;]*).*", "\1");
      if(req.http.x-nyt-s2 == req.http.Cookie) {
        // unset this req var if we didn't find one
        unset req.http.x-nyt-s2;
      } else {
        // apparently we did find one, skip glogin for this request to fail open
        set req.http.x-skip-glogin = "1";
      }
    }

    if (req.http.Cookie:NYT-Edition) {
      set req.http.x-nyt-edition = urldecode(req.http.Cookie:NYT-Edition);
    }

    if (req.http.Cookie:nyt-d) {
      set req.http.x-nyt-d = urldecode(req.http.Cookie:nyt-d);
    }

    if (req.http.Cookie:NYT-wpAB) {
      set req.http.x-nyt-wpab = urldecode(req.http.Cookie:NYT-wpAB);
    }

    if (req.http.Cookie:nyt-a) {
      set req.http.x-nyt-a = req.http.Cookie:nyt-a;
    }

    if (req.http.Cookie:nyt-bcet){
      set req.http.x-nyt-bcet = req.http.Cookie:nyt-bcet;
    }

    if(req.http.host ~ "\.dev\."){
      set req.http.x-environment = "dev";
    } else if (req.http.host ~ "\.stg\."){
      set req.http.x-environment = "stg";
    } else {
      set req.http.x-environment = "prd";
    }



    set req.http.x-bcet-secret-key = "75b798658d2f43bc1caadb0260d175524ad3c874ab76a15c9aeef3cec11096597f068faca3133285a004fa2106799246dc050ec66c3e75c134d26b8d163b6086";
}
