sub vcl_recv {
  # based on existance of internal cookie to pivot the traffic
  if ( req.http.Cookie:nyt.dv.nyt5-on-gke.collection == "1" ) {
      set req.http.X-Collection-Backend = "on-GKE";
    } else {
      set req.http.X-Collection-Backend = "on-ESX";
  } 
}

sub vcl_fetch {
  # Vary on X-Collection-Backend header for collection source GKE vs ESX, so we can purge both versions at the same time
  if ( req.http.X-PageType == "collection" ) {
    if (beresp.http.Vary) {
      set beresp.http.Vary = beresp.http.Vary ", X-Collection-Backend";
    } else {
      set beresp.http.Vary = "X-Collection-Backend";
    }
  }    
}

sub vcl_deliver {
  # Hide the existence of the header from downstream
  if (resp.http.Vary) {
    set resp.http.Vary = regsub(resp.http.Vary, "X-Collection-Backend,?", "");
  }
} 