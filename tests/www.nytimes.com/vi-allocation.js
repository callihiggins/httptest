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
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=[abcz][012][0-9];/,
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
        'sbx': false,
      },
      'requestHeaderCookie': [
        'vi_www_hp=',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=[abcz][012][0-9];/,
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
        'sbx': false,
      },
      'requestHeaderCookie': [
        'vi_www_hp=xyz',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=[abcz][012][0-9];/,
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
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestHeaderCookie': [
        'ab7=WP_ProjectVi_www_hp=0*',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'set-cookie': 'vi_www_hp=z2',
        'x-nyt-backend': 'www_',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'ab7 => mw/mw/mw reported; homepage',
      'testId': 40,
    },

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestHeaderCookie': [
        'ab7=WP_ProjectVi_www_hp=0*',
      ],
      'requestScheme': 'https://',
      'requestUri': '/section/nyregion',
      'responseHeaderContains': {
        'set-cookie': 'vi_www_hp=z2',
        'x-nyt-backend': 'collection_',
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
        'sbx': false,
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
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
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
        'sbx': false,
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
        'x-nyt-backend': 'collection_',
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
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
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
        'sbx': false,
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
        'x-nyt-backend': 'collection_',
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
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestHeaderCookie': [
        'vi_www_hp_opt=0',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-backend': 'www_',
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
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
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
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/vi-assets/up.txt',
      'responseHeadersPresent': [
        'x-goog-storage-class',
      ],
      'responseStatusCode': 200,
      'scenarioDescription': 'Test Static Asset Backend for project vi',
      'testId': 200,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage', // ?
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
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
        'dev': true,
        'sbx': false,
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
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage', // ?
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'requestHeaders': {
        'User-Agent': 'Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Mobile Safari/537.36',
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test Static Asset Backend for project vi',
      'testId': 230,
    },



    // generate a bunch of nyt-a's like this (in bash):
    // for i in {1..1000}; do a="$(base64 /dev/random | head -c22 | tr /+ -_)"; s="$a WP_ProjectVi_www_hp"; printf '%s %010d\n' "$s" $((0x"$(printf %s "$s" | openssl dgst -sha256 | cut -c1-8)")); done

    {
      'scenarioDescription': 'Request with nyt-a mapping to vi-hp-server-render (in non-prd)',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        'nyt-a=sJ50prL_8s36390EzUdhZ6', // in NON-PRODUCTION envs, this results in variation `vi-hp-server-render`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-debug-req-http-x-vi-ssr-www-hp': 'vi-hp-server-render',
      },
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=e[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 240,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to vi-hp-client-render (in non-prd)',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        'nyt-a=VY-be0W--laBW4oZMjs2cA', // in NON-PRODUCTION envs, this results in variation `vi-hp-client-render`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-debug-req-http-x-vi-ssr-www-hp': 'vi-hp-client-render',
      },
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=f[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 250,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to vi-hp-server-render (in prd)',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        'nyt-a=hhgKlZP8DGMN9hoVgbYClP', // in PRODUCTION env, this results in variation `vi-hp-server-render`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-debug-req-http-x-vi-ssr-www-hp': 'vi-hp-server-render',
      },
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=e[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 260,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to vi-hp-client-render (in prd)',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        'nyt-a=U5CAXSqCivvSAByuDZur2k', // in PRODUCTION env, this results in variation `vi-hp-client-render`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-debug-req-http-x-vi-ssr-www-hp': 'vi-hp-client-render',
      },
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=f[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 270,
    },


  ];

  return scenarios;
}
