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
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/2014/01/10/travel/2014-places-to-go.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; interactive; 2014; iPhone; does not redirect',
      'testId': 1,
    }
  ];

  return scenarios;
}
