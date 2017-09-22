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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'http://',
      'requestUri': '/.well-known/assetlinks.json',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-4',
        'x-pagetype': 'legacy',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test well-known/assetlinks.json; non-secure',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/.well-known/assetlinks.json',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-4',
        'x-pagetype': 'legacy',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test well-known/assetlinks.json; secure',
      'testId': 2,
    },
  ];

  return scenarios;
}
