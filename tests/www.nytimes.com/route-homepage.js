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
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        prd: true,
        stg: true,
        dev: true
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'method': 'POST',
      'responseStatusCode': [405],
      'scenarioDescription': 'POST method requests are not allowed for homepage route',
      'testId': 220
    },

    // generate a bunch of nyt-a's like this (in bash):

    /*

    for i in {1..1000};
    do a="$(base64 /dev/random | head -c22 | tr /+ -_)";
    s="$a HOME_midterms"; # Put your ABRA test name here
    st=$(printf %s "$s" | openssl dgst -sha256 | cut -c1-8);
    printf '%s %010d\n' "$s" $((0x$st));
    done

    */

    {
      'scenarioDescription': 'Request with nyt-a mapping to HOME_midterms allocation 0_control, 0-1%',
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
         // var.d = 0040802302
        'nyt-a=FeOnjbwPOimh3xjAiCQAeM',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'x-nyt-debug-req-http-x-vi-abtest-www-hp': '0_control',
      },
      'responseStatusCode': 200,
      'testId': 270,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to HOME_midterms allocation 1_variant, 1-2%',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 0069006615

        'nyt-a=KsuJNqCoLJzX4f_dHoxSXY',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'x-nyt-debug-req-http-x-vi-abtest-www-hp': '1_variant',
      },
      'responseStatusCode': 200,
      'testId': 280,
    },

    {
      'scenarioDescription': 'Request with nyt-a mapping to HOME_midterms allocation 2_variant, 2-3%',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 0119201577
        'nyt-a=1Vw3GnbqfcV0Qp9NPY1r9Z',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'x-nyt-debug-req-http-x-vi-abtest-www-hp': '2_variant',
      },
      'responseStatusCode': 200,
      'testId': 290,
    },
    {
      'scenarioDescription': 'Request with nyt-a mapping to HOME_midterms allocation 3_variant, 3-4%',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 0166063497
        'nyt-a=Wq86wIwFCr0t-dwbj7FEsd',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'x-nyt-debug-req-http-x-vi-abtest-www-hp': '3_variant',
      },
      'responseStatusCode': 200,
      'testId': 290,
    },
    {
      'scenarioDescription': 'Request with nyt-a mapping to HOME_midterms allocation 4_unallocated, 4-100%',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 3209428244
        'nyt-a=VCTwq3rrtjmInU0IbZnytN',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'x-nyt-debug-req-http-x-vi-abtest-www-hp': '4_unallocated',
      },
      'responseStatusCode': 200,
      'testId': 290,
    },
  ];

  return scenarios;
}
