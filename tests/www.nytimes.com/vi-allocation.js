var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);


/**
 * @return array
 */
function getScenarioEvents()
{
  var scenarios = [
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=[abcdefghijklmyz][012][0-9];/,
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'No vi_www_hp cookie',
      'testId': 10,
    },

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': [
        'vi_www_hp=',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=[abcdefghijklmyz][012][0-9];/,
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Empty vi_www_hp cookie',
      'testId': 20,
    },

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': [
        'vi_www_hp=xyz',
      ],
      'requestScheme': 'https://',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=[abcdefghijklmyz][012][0-9];/,
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Outdated vi_www_hp cookie',
      'testId': 30,
    },

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestHeaderCookie': [
        'ab7=WP_ProjectVi_www_hp=0*',
      ],
      'requestScheme': 'https://',
      'requestUri': '/section/nyregion',
      'responseHeaderContains': {
        'set-cookie': 'vi_www_hp=z2',
        'x-nyt-backend': 'collection',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'ab7 => mw/mw/mw reported; homepage',
      'testId': 50,
    },

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'X-From-Onion': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'set-cookie': 'vi_www_hp=b2',
        'x-nyt-backend': 'projectvi_fe',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Custom onion header sets backend to vi',
      'testId': 60,
    },

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestHeaderCookie': [
        'ab7=WP_ProjectVi_www_hp=hp-st*',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'set-cookie': 'vi_www_hp=a2',
        'x-nyt-backend': 'projectvi_fe',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'ab7 => vi/vi/mw; homepage',
      'testId': 70,
    },

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestHeaderCookie': [
        'ab7=WP_ProjectVi_www_hp=hp-st*',
      ],
      'requestScheme': 'https://',
      'requestUri': '/section/nyregion',
      'responseHeaderContains': {
        'set-cookie': 'vi_www_hp=a2',
        'x-nyt-backend': 'collection',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'ab7 => vi/vi/mw; other page',
      'testId': 90,
    },

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestHeaderCookie': [
        'ab7=WP_ProjectVi_www_hp=hp*',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'set-cookie': 'vi_www_hp=b2',
        'x-nyt-backend': 'projectvi_fe',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'ab7 => vi/mw/mw; homepage',
      'testId': 100,
    },

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestHeaderCookie': [
        'ab7=WP_ProjectVi_www_hp=hp*',
      ],
      'requestScheme': 'https://',
      'requestUri': '/section/nyregion',
      'responseHeaderContains': {
        'set-cookie': 'vi_www_hp=b2',
        'x-nyt-backend': 'collection',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'ab7 => vi/mw/mw; other page',
      'testId': 120,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestHeaderCookie': [
        'vi_www_hp_opt=0',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-backend': 'homepage_fe',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'vi_www_hp_opt = 0',
      'testId': 130,
    },

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestHeaderCookie': [
        'vi_www_hp_opt=1',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'vi_www_hp_opt = 1',
      'testId': 140,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage', // ?
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'requestHeaders': {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Safari/537.36',
      },
      'requestHeaderCookie': [
        'ab7=WP_ProjectVi_www_hp=hp-st',
      ],
      'responseHeaderContains': {
        'device_type': 'desktop',
        'x-nyt-backend': 'projectvi_fe',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test Static Asset Backend for project vi',
      'testId': 210,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage', // ?
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'requestHeaders': {
        'User-Agent': 'Mozilla/5.0 (iPad; CPU OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1',
      },
      'requestHeaderCookie': [
        'ab7=WP_ProjectVi_www_hp=hp-st',
      ],
      'responseHeaderContains': {
        'device_type': 'tablet',
        'x-nyt-backend': 'projectvi_fe',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test Static Asset Backend for project vi',
      'testId': 220,
    },
    // generate a bunch of nyt-a's like this (in bash):

    /*

    for i in {1..1000};
    do a="$(base64 /dev/random | head -c22 | tr /+ -_)";
    s="$a WP_ProjectVi_www_hp";
    st=$(printf %s "$s" | openssl dgst -sha256 | cut -c1-8);
    printf '%s %010d\n' "$s" $((0x$st));
    done

    */

    {
      'scenarioDescription': 'Request with nyt-a mapping to control, unreported (in prd)',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 4012942817
        'nyt-a=k_Be11VLD4kriWarZ2JQDv', // , this results in variation `control, unreported`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-debug-req-http-x-vi-ssr-www-hp': '',
      },
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=z[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 260,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to hp-serv (in prd)',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestHeaderCookie': [
        // var.d = 0189515186
        'nyt-a=1oDScuo7U4F_w_kBbp5N9a', // , this results in variation `hp-serv`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-debug-req-http-x-vi-ssr-www-hp': 'hp-serv',
      },
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=e[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 260,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to hp-orig (in prd)',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestHeaderCookie': [
         // var.d = 0202462000
        'nyt-a=PiTgPaKR1pVRjUEWYoEdbU', // , this results in variation `hp-orig`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-debug-req-http-x-vi-ssr-www-hp': 'hp-orig',
      },
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=f[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 270,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to hp-rm_gpt_media_dfp (in prd)',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 0220022125
        'nyt-a=DxEvJXhoIawOEMiR2sMVGH', // this results in variation `hp-rm_gpt_media_dfp`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-debug-req-http-x-vi-ssr-www-hp': 'hp-rm_gpt_media_dfp',
      },
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=g[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 280,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to hp-rm_media_dfp (in prd)',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 0240724968
        'nyt-a=3rIUlcgaGMIoUOq5FIseV8', // this results in variation `hp-rm_media_dfp`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-debug-req-http-x-vi-ssr-www-hp': 'hp-rm_media_dfp',
      },
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=h[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 280,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to hp-orig_dfp (in prd)',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 0250132554
        'nyt-a=41KNozgVJJZe1qhKPVUk9a', // this results in variation `hp-orig_dfp`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-debug-req-http-x-vi-ssr-www-hp': 'hp-orig_dfp',
      },
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=i[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 280,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to cookie allocation j 6% to 8%',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 0317441237
        'nyt-a=K6GhOupxPJzvil8_FVyTQv', // this results in allocation `j`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=j[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 280,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to cookie allocation k 8% to 25%',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 1043612978
        'nyt-a=HshIdLXoxDZyi3r5TTTpBG', // this results in allocation `k`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=k[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 280,
    },

    // {
    //   'scenarioDescription': 'Request with nyt-a mapping to cookie allocation l 25% to 50%',
    //   'isDeployedInEnv': {
    //     'prd': true,
    //     'stg': true,
    //     'dev': true
    //   },
    //   'requestHeaders': {
    //     'x-nyt-debug': '1',
    //   },
    //   'requestHeaderCookie': [
    //     // var.d = 2017547206
    //     'nyt-a=S9PXHCS7XebazlXEoYpTbz', // this results in allocation `l`
    //   ],
    //   'requestScheme': 'https://',
    //   'requestUri': '/',
    //   'responseHeaderPattern': {
    //     'set-cookie': /\bvi_www_hp=l[012][0-9];/,
    //   },
    //   'responseStatusCode': 200,
    //   'testId': 280,
    // },
    //
    // {
    //   'scenarioDescription': 'Request with nyt-a mapping to cookie allocation m 50% to 75%',
    //   'isDeployedInEnv': {
    //     'prd': true,
    //     'stg': true,
    //     'dev': true
    //   },
    //   'requestHeaders': {
    //     'x-nyt-debug': '1',
    //   },
    //   'requestHeaderCookie': [
    //     // var.d = 3200211313
    //     'nyt-a=cxkoRJvFyyKZYM56PqDX6X', // this results in allocation `m`
    //   ],
    //   'requestScheme': 'https://',
    //   'requestUri': '/',
    //   'responseHeaderPattern': {
    //     'set-cookie': /\bvi_www_hp=m[012][0-9];/,
    //   },
    //   'responseStatusCode': 200,
    //   'testId': 280,
    // },

  ];

  return scenarios;
}
