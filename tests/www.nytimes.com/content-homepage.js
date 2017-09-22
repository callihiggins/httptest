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
      'requestScheme': 'https://',
      'requestUri': '/?abra=WP_ProjectVi_www_hp=0',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'homepage',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test homepage',
      'testId': 1,
    },
  ];

  return scenarios;
}
