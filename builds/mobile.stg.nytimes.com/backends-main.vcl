include "backends-dev";
include "backends-stg";
include "backends-prd";

# set a www_fe backend based on host
sub set_mobileweb_fe_backend {
    if(req.http.host ~ "\.dev\.") {
        set req.backend = mobileweb_fe_dev;
    } else if (req.http.host ~ "\.stg\.") {
        set req.backend = mobileweb_fe_stg;
    } else {
        set req.backend = mobileweb_fe_prd;
    }
    unset req.http.x--fastly-project-vi;
}

sub set_projectvi_fe_backend {
    if(req.http.host ~ "\.(dev|stg)\.") {
        set req.backend = projectvi_fe_dev;
    } else {
        set req.backend = projectvi_fe_prd;
    }
    # must set this for hashing and saint mode in default.vcl:
    set req.http.x--fastly-project-vi = "1";
}

# the backend doesn't need the private vars we've stashed on the request,
# so zap them from the backend request using vcl_miss and vcl_pass:
sub vcl_miss {
    unset bereq.http.x--fastly-project-vi;
}
sub vcl_pass {
    unset bereq.http.x--fastly-project-vi;
}
