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
      'id': 'FunctionalTestScenarioDefinitionForAttributeGETHealthzSucess',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/int/attribute/projects/healthz/submissions.json',
      'responseHeaderMatches': {
        'x-nyt-route': 'newsdev-attribute',
        'x-nyt-backend': 'newsdev_cloud_functions_us_central1',
        'content-type': 'application/json; charset=utf-8',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'content-newsdev-attribute: Test GET success on healthz path',
      'testId': 1,
    }
  ];

  return scenarios;
}