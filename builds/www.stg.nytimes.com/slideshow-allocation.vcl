sub vcl_recv {
  # based on existance of internal cookie to pivot the traffic
  if ( req.http.Cookie:nyt.dv.nyt5-on-gke.slideshow == "1" ) {
      set req.http.X-Slideshow-Backend = "slideshow-GKE";
    }
}

sub vcl_hash {
  if(req.http.X-Slideshow-Backend == "slideshow-GKE"){
    set req.hash += req.http.X-Slideshow-Backend;
  }
}