sub vcl_recv {
  # based on existance of internal cookie to pivot the traffic
  if ( req.http.Cookie:nyt.dv.nyt5-on-gke.article == "1" ) {
      set req.http.X-Article-Backend = "article-GKE";
    }
}

sub vcl_hash {
  if(req.http.X-Article-Backend == "article-GKE"){
    set req.hash += req.http.X-Article-Backend;
  }
}