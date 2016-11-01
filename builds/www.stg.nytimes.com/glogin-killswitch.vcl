sub vcl_recv {
	
	# Emergency Kill Switch for glogin service
	# uncomment THE BELOW LINE TO DISABLE glogin
    # comment it out to re-enable glogin
    
    set req.http.x-skip-glogin = "1";
}