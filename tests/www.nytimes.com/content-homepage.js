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
      'responseHeaderPattern': {
        'x-api-version': /F-(GH|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'homepage',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test homepage',
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
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/?abra=WP_ProjectVi_www_hp=0',
      'responseHeaderPattern': {
        'x-api-version': /F-(GH|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'homepage',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test homepage',
      'testId': 101,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/?abra=WP_ProjectVi_www_hp=0',
      'responseHeaderPattern': {
        'x-api-version': /F-(GH|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'homepage',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test homepage',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/?abra=WP_ProjectVi_www_hp=0',
      'responseHeaderPattern': {
        'x-api-version': /F-(GH|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'homepage',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test homepage',
      'testId': 201,
    },
  ];

  return scenarios;
}
