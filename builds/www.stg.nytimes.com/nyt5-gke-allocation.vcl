sub vcl_recv {
    if ( ! req.http.Cookie: nyt.dv.nyt5-on-gke ) {
        if (randombool(0,100)) {   ## this says 0 out 100 (or zero% on GKE)
            set req.http.X-Collection-Backend = "on-GKE";
        } else {
            set req.http.X-Collection-Backend = "on-ESX";
        } 
    } else {
        set req.http.X-Collection-Backend = req.http.Cookie:nyt.dv.nyt5-on-gke;
    }
}

sub vcl_deliver {
  if (!req.http.Cookie:nyt.dv.nyt5-on-gke){
    add resp.http.Set-Cookie = 
        "nyt.dv.nyt5-on-gke=" + req.http.X-Collection-Backend + ”; "+ 
        "Expires=" + time.sub(now,365d);  
  }   
  return(deliver);
}

sub vcl_fetch {
  # Vary on X-Collection-Backend header for collection source GKE vs ESX, so we can purge both versions at the same time
  if (beresp.http.Vary) {
    set beresp.http.Vary = beresp.http.Vary ", X-Collection-Backend";
  } else {
    set beresp.http.Vary = "X-Collection-Backend";
  }    
}
