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
    s="$a HOME_comments_count"; # Put your ABRA test name here
    st=$(printf %s "$s" | openssl dgst -sha256 | cut -c1-8);
    printf '%s %010d\n' "$s" $((0x$st));
    done
    */

    {
      'scenarioDescription': 'Request with nyt-a mapping to HOME_comments_count allocation 0_control, 0-33%',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 0617867856
        'nyt-a=I0d9m-PDuak4gBZaZhWQCq',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderContains': {
        'x-nyt-debug-req-http-x-nyt-vi-abtest': 'HOME_comments_count=0_control',
      },
      'responseStatusCode': 200,
      'testId': 290,
    },
  ];

  return scenarios;
}
