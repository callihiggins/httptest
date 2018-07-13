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
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestHeaderCookie': 'vi_www_hp_opt=0',
      'requestScheme': 'https://',
      'requestUri': '/?abra=WP_ProjectVi_www_hp=0',
      'responseHeaderMatches': {
        'x-nyt-route': 'homepage',
        'x-nyt-backend': 'homepage_fe',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test desktop homepage vi_www_hp_opt is set to 0',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestHeaderCookie': 'vi_www_hp_opt=0',
      'requestScheme': 'https://',
      'requestUri': '/?abra=WP_ProjectVi_www_hp=0',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-homepage',
        'x-nyt-backend': 'projectvi_fe',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test mobile homepage; goes to vi always',
      'testId': 2,
    },
  ];

  return scenarios;
}
