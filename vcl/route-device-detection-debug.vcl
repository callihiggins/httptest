sub recv_route_device_detection_debug {
    if (req.http.x-nyt-nyhq-access == "1") {
        if (req.url ~ "^/svc/web-products/uadiag") {
            set req.http.x-nyt-route = "device-detection-debug";
            set req.http.x-nyt-backend = "synthetic";
            error 848;
        }
    }
}

sub error_848_device_detection_debug {
    # plain text ua diag
    if (obj.status == 848) {
        set obj.status = 200;
        set obj.response = "OK";
        set obj.http.Content-Type = "text/html; charset=utf-8";
        synthetic
        {"<html>
            <head>
                <title>UADIAG</title>
                <style>
                    table {
                        font-family: Arial;
                    }
                    tr > td {
                        padding: 4px;
                    }
                    td:first-child {
                        color: #fff;
                        background-color: #000;
                    }
                    td:last-child {
                        border-bottom: 1px dotted #000;
                    }
                </style>
            </head>
            <body>
                <h1>UADIAG</h1>
                <table>
                    <tr><td>User-Agent</td><td>"} + req.http.User-Agent + {"</td></tr>
                    <tr><td>Device type</td><td>"} + req.http.device_type + {"</td></tr>
                    <tr><td>Wireless</td><td>"} + req.http.Is-Wireless-Device + {"</td></tr>
                    <tr><td>Tablet</td><td>"} + req.http.Is-Tablet + {"</td></tr>
                    <tr><td>Desktop</td><td>"} + req.http.Is-Desktop + {"</td></tr>
                </table>
            </body>
        </html>"};

        return(deliver);
    }
}
