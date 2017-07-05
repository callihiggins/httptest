sub vcl_recv {
  if (req.http.X-PageType == "newsdev-attribute-cloud-function") { # POST request
    return (pass);
  }
}
