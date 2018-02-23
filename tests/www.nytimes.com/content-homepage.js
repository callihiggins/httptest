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
      'requestHeaderCookie': 'vi_www_hp_opt=0',
      'requestScheme': 'https://',
      'requestUri': '/?abra=WP_ProjectVi_www_hp=0',
      'responseHeaderPattern': {
        'x-api-version': /F-(GH|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'homepage',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test homepage vi_www_hp_opt is set to 0',
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
      'requestHeaderCookie': [
        'nyt.dv.nyt5-on-gke=1',
        'vi_www_hp_opt=0'
      ],
      'requestScheme': 'https://',
      'requestUri': '/?abra=WP_ProjectVi_www_hp=0',
      'responseHeaderPattern': {
        'x-api-version': /F-(GH|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'homepage',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test homepage vi_www_hp_opt is set to 0, nyt5-on-gke is set to  1',
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
      'requestHeaderCookie': 'vi_www_hp_opt=0',
      'requestScheme': 'https://',
      'requestUri': '/?abra=WP_ProjectVi_www_hp=0',
      'responseHeaderPattern': {
        'x-api-version': /F-(GH|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'homepage',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test homepage vi_www_hp_opt is set to 0, set to DEV environment',
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
      'requestHeaderCookie': [
        'nyt.dv.nyt5-on-gke=1',
        'vi_www_hp_opt=0'
      ],
      'requestScheme': 'https://',
      'requestUri': '/?abra=WP_ProjectVi_www_hp=0',
      'responseHeaderPattern': {
        'x-api-version': /F-(GH|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'homepage',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test homepage vi_www_hp_opt is set to 0, nyt5-on-gke is set to 1, set to DEV environment',
      'testId': 201,
    },
  ];

  return scenarios;
}
