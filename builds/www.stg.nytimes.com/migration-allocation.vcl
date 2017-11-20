sub vcl_recv {
  # based on existance of internal cookie to pivot the traffic
  if ( req.http.Cookie:nyt.dv.nyt5-on-gke == "1" ) {
      set req.http.X-Migration-Backend = "on-GKE";
    }
}

sub vcl_hash {
  if(req.http.X-Migration-Backend == "on-GKE"){
    set req.hash += req.http.X-Migration-Backend;
  }
}