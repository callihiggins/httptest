# routes that's using projectvi_fe backends
include "route-ask";
include "route-audio";
include "route-bestsellers";
include "route-code";
include "route-collection";
include "route-gdpr-form";
include "route-get-started";
include "route-homepage";
include "route-interactive";
include "route-newsletters";
include "route-paidpost";
include "route-refer";
include "route-search";
include "route-slideshow";
include "route-story";
include "route-timeswire";
include "route-trending";
include "route-watching";
include "route-weekender";

# routes that's using projectvi_static_backup_gcs backends
include "route-vi-static-backup-gcs";

# load test header switch
include "route-vi-load-test";

# shared subs for vi backend routes
include "route-vi-shared";
