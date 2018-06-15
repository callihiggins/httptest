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
        'stg': false,
        'dev': false
      },
      'requestHeaders': {
        'Host': 'nytimes.com',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'x-api-version': 'F-0',
        'location': 'https://www.nytimes.com/',
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'redirect-zone-apex: Test zone apex redirects to www.nytimes.com',
      'testId': 1,
    },
  ];

  return scenarios;
}
