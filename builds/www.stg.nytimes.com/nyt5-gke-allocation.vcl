sub vcl_recv {
    if ( req.http.Cookie:nyt.dv.nyt5-on-gke.collection ) {
        set req.http.X-Collection-Backend = "on-GKE";
    } else {
        set req.http.X-Collection-Backend = "on-ESX";
    } 
}

sub vcl_fetch {
  # Vary on X-Collection-Backend header for collection source GKE vs ESX, so we can purge both versions at the same time
  if (beresp.http.Vary) {
    set beresp.http.Vary = beresp.http.Vary ", X-Collection-Backend";
  } else {
    set beresp.http.Vary = "X-Collection-Backend";
  }    
}
