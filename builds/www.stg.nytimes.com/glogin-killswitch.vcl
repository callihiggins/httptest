sub vcl_recv {
	
	# EMERGENCY KILLSWITCH UNCOMMENT THE BELOW LINE TO DISABLE glogin
    
    # set req.http.x-skip-glogin = "1";
}