sub vcl_recv {
  # based on existance of internal cookie to pivot the traffic
  if ( req.http.Cookie:nyt.dv.nyt5-on-gke.article == "1" ) {
      set req.http.X-Article-Backend = "on-GKE";
    } else {
      set req.http.X-Article-Backend = "on-ESX";
  } 
}

sub vcl_fetch {
  # Vary on X-Article-Backend header for Article source GKE vs ESX, so we can purge both versions at the same time
  if (beresp.http.Vary) {
    set beresp.http.Vary = beresp.http.Vary ", X-Article-Backend";
  } else {
    set beresp.http.Vary = "X-Article-Backend";
  }    
}