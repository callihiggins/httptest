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
    s="$a HOME_video_headline"; # Put your ABRA test name here
    st=$(printf %s "$s" | openssl dgst -sha256 | cut -c1-8);
    printf '%s %010d\n' "$s" $((0x$st));
    done

    */

    {
      'scenarioDescription': 'Request with nyt-a mapping to HOME_video_headline allocation 0_control, 0-25%',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 1064756818
        'nyt-a=eO1Pe8yAxRG-eTrs7qLYDj',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'x-nyt-debug-req-http-x-vi-abtest-www-hp': '0_control',
      },
      'responseStatusCode': 200,
      'testId': 290,
    },
    {
      'scenarioDescription': 'Request with nyt-a mapping to HOME_video_headline allocation 1_variant, 25-50%',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'x-nyt-debug': '1',
      },
      'requestHeaderCookie': [
        // var.d = 2139393394
        'nyt-a=WYESoCibgH3CnaSjX84d-s',
      ],
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'x-nyt-debug-req-http-x-vi-abtest-www-hp': '1_variant',
      },
      'responseStatusCode': 200,
      'testId': 290,
    },
  ];

  return scenarios;
}
