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
}
