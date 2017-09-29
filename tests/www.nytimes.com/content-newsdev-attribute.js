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
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/int/attribute/healthz',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-attribute-cloud-function',
        'content-type': 'application/json; charset=utf-8',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test GET success on healthz path',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForAttributeGETDenied',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/int/attribute',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-attribute-cloud-function',
        'content-type': 'application/json; charset=utf-8',
      },
      'responseStatusCode': [400],
      'scenarioDescription': 'Test GET Denied on base path',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForAttributeRefererNotWWW',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'referer': 'example.com',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/int/attribute',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-attribute-cloud-function',
        'content-type': 'application/json; charset=utf-8',
      },
      'responseStatusCode': [400],
      'scenarioDescription': 'Test referer not www',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForAttributeOriginNotWWW',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'origin': 'example.com',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/int/attribute',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-attribute-cloud-function',
        'content-type': 'application/json; charset=utf-8',
      },
      'responseStatusCode': [400],
      'scenarioDescription': 'Test origin not www',
      'testId': 4,
    },
  ];

  return scenarios;
}
