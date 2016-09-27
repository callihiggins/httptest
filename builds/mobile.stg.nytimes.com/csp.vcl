sub vcl_deliver {

	if (resp.http.Content-Type ~ "^text/html" && req.http.x-is-https) {
	    # set resp.http.Strict-Transport-Security = "max-age=60";
		set resp.http.Content-Security-Policy = "default-src data: 'unsafe-inline' 'unsafe-eval' https:; script-src data: 'unsafe-inline' 'unsafe-eval' https: blob:; style-src data: 'unsafe-inline' https:; img-src data: https:; font-src data: https:; connect-src https: wss:; media-src https:; object-src https:; child-src https: data: blob:; form-action https:; block-all-mixed-content; report-uri https://nytimes.report-uri.io/r/default/csp/enforce;";
	}

}