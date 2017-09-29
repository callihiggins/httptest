sub vcl_recv {
    # ua override
    if (req.url ~ "[^\w]ua=") {
        set req.http.User-Agent = regsub(req.url,"^.*[^\w]ua=([^&]*).*","\1");
    }

    // set device_type and Is-* flags that response-headers.vcl references
    // we're defaulting to desktop in the new Fastly config
    // if they ever get WURFL we'll go back to what we had
    set req.http.Is-Tablet = "0";
    set req.http.Is-Desktop = "1";
    set req.http.Is-Wireless-Device = "0";
    set req.http.device_type = "desktop";


    if (   req.http.User-Agent ~ "(?i)(ads|google|bing|msn|yandex|baidu|ro|career|)bot"
        || req.http.User-Agent ~ "(?i)(baidu|jike|symantec)spider"
        || req.http.User-Agent ~ "(?i)scanner"
        || req.http.User-Agent ~ "(?i)(web)crawler"
    ) {
        set req.http.device_type = "crawler";

    } else if (req.http.User-Agent ~ "(?i)ipad") {
        set req.http.device_type = "tablet";
        set req.http.Is-Tablet = "1";

    } else if (req.http.User-Agent ~ "(?i)ip(hone|od)") {
        set req.http.device_type = "smartphone";
    
    # how do we differ between an android phone and an android tablet?
    #   http://stackoverflow.com/questions/5341637/how-do-detect-android-tablets-in-general-useragent
    #   http://googlewebmastercentral.blogspot.com/2011/03/mo-better-to-also-detect-mobile-user.html
    } else if (req.http.User-Agent ~ "(?i)android.*(mobile|mini)") {
        set req.http.device_type = "smartphone";
    
    # android 3/honeycomb was just about tablet-only, and any phones will probably handle a bigger page layout
    } else if (req.http.User-Agent ~ "(?i)android") {
        set req.http.device_type = "tablet";
        set req.http.Is-Tablet = "1";

    # see http://my.opera.com/community/openweb/idopera/
    } else if (req.http.User-Agent ~ "Opera Mobi") {
        set req.http.device_type = "smartphone";

    } else if (req.http.User-Agent ~ "PlayBook; U; RIM Tablet") {
        set req.http.device_type = "tablet";
        set req.http.Is-Tablet = "1";

    } else if (req.http.User-Agent ~ "hp-tablet.*TouchPad") {
        set req.http.device_type = "tablet";
        set req.http.Is-Tablet = "1";

    } else if (req.http.User-Agent ~ "Kindle/3") {
        set req.http.device_type = "tablet";
        set req.http.Is-Tablet = "1";

    } else if (req.http.User-Agent ~ "Mobile.+Firefox") {
        set req.http.device_type = "smartphone";

    } else if (req.http.User-Agent ~ "^HTC") {
        set req.http.device_type = "smartphone";

    } else if (req.http.User-Agent ~ "Fennec") {
        set req.http.device_type = "smartphone";

    } else if (req.http.User-Agent ~ "IEMobile") {
        set req.http.device_type = "smartphone";

    } else if (req.http.User-Agent ~ "BlackBerry" || req.http.User-Agent ~ "BB10.*Mobile") {
        set req.http.device_type = "smartphone";

    } else if (req.http.User-Agent ~ "GT-.*Build/GINGERBREAD") {
        set req.http.device_type = "smartphone";

    } else if (req.http.User-Agent ~ "SymbianOS.*AppleWebKit") {
        set req.http.device_type = "smartphone";

    } else if (    req.http.User-Agent ~ "(?i)symbian"
                || req.http.User-Agent ~ "(?i)^sonyericsson"
                || req.http.User-Agent ~ "(?i)^nokia"
                || req.http.User-Agent ~ "(?i)^samsung"
                || req.http.User-Agent ~ "(?i)^lg"
                || req.http.User-Agent ~ "(?i)bada"
                || req.http.User-Agent ~ "(?i)blazer"
                || req.http.User-Agent ~ "(?i)cellphone"
                || req.http.User-Agent ~ "(?i)iemobile"
                || req.http.User-Agent ~ "(?i)midp-2.0"
                || req.http.User-Agent ~ "(?i)u990"
                || req.http.User-Agent ~ "(?i)netfront"
                || req.http.User-Agent ~ "(?i)opera mini"
                || req.http.User-Agent ~ "(?i)palm"
                || req.http.User-Agent ~ "(?i)nintendo wii"
                || req.http.User-Agent ~ "(?i)playstation portable"
                || req.http.User-Agent ~ "(?i)portalmmm"
                || req.http.User-Agent ~ "(?i)proxinet"
                || req.http.User-Agent ~ "(?i)sonyericsson"
                || req.http.User-Agent ~ "(?i)symbian"
                || req.http.User-Agent ~ "(?i)windows\ ?ce"
                || req.http.User-Agent ~ "(?i)winwap"
                || req.http.User-Agent ~ "(?i)eudoraweb"
                || req.http.User-Agent ~ "(?i)htc"
                || req.http.User-Agent ~ "(?i)240x320"
                || req.http.User-Agent ~ "(?i)avantgo"
    ) {
        set req.http.device_type = "phone";
        set req.http.Is-Wireless-Device = "1";
    }

    #/uadiag commands
    if (req.http.x-nyt-internal-access) {
        if (req.url ~ "^/svc/web-products/uadiag.js") {
            error 849 "uadiag.js";
        } else if (req.url ~ "^/svc/web-products/uadiag") {
            error 848 "uadiag";
        }
    }
}

sub vcl_error {
    # plain text ua diag
    if (obj.status == 848) {
        set obj.status = 200;
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

    # json ua diag with optional jsonp callback parameter
    else if (obj.status == 849) {
        set obj.status = 200;
        set req.http.device_cb = "";
        set req.http.device_cbe = "";
        if (req.url ~ "[^\w]callback=\w+") {
            set obj.http.Content-Type = "application/javascript; charset=utf-8";
            set req.http.device_cb = regsub(req.url,"^.*[^\w]callback=(\w+).*","\1(");
            set req.http.device_cbe = ");";
        } else {
            set obj.http.Content-Type = "application/json; charset=utf-8";
        }
        synthetic
            req.http.device_cb + {"{
                "user_agent":""} + req.http.User-Agent + {"",
                "device_type":""} + req.http.device_type + {"",
                "wireless":""} + req.http.Is-Wireless-Device + {"",
                "tablet":""} + req.http.Is-Tablet + {"",
                "desktop":""} + req.http.Is-Desktop + {"",
            }"} + req.http.device_cbe;
        return(deliver);
    }
}