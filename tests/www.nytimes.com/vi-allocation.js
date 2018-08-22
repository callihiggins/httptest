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
      'scenarioDescription': 'Request with nyt-a mapping to cookie allocation b, less than 6%',
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
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=b[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 270,
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
        'set-cookie': /\bvi_www_hp=b[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 280,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to cookie allocation l 25% to 50%',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 2017547206
        'nyt-a=S9PXHCS7XebazlXEoYpTbz', // this results in allocation `l`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=b[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 280,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to cookie allocation m 50% to 75%',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 3200211313
        'nyt-a=cxkoRJvFyyKZYM56PqDX6X', // this results in allocation `m`
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /\bvi_www_hp=b[012][0-9];/,
      },
      'responseStatusCode': 200,
      'testId': 280,
    },
  ];

  return scenarios;
}
