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
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/elections/results/president',
      'responseHeaderMatches': {
        'x-api-version': 'F-I',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test elections; overall results page',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/elections',
      'responseHeaderMatches': {
        'x-api-version': 'F-I',
        'location': 'https://' + suite.servername + '/elections/results/president'
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test elections; obey redirects configured by x-amz-meta-website-redirect-location header',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCache',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/elections/results/president',
      'responseHeaderMatches': {
        'cache-control': 'public, max-age=86400',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test elections 200 cache',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionFor404Cache',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/elections/page-that-does-not-exist',
      'responseHeadersNotPresent': [
        'cache-control'
      ],
      'responseStatusCode': 404,
      'scenarioDescription': 'Test elections 404 cache',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForBackendFailover',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/elections/results/president',
      'responseHeadersPresent': [
        'x-goog-hash'
      ],
      'responseStatusCode': 200,
      'scenarioDescription': 'Test elections served by GCS, not S3',
      'testId': 5,
    },
  ];

  return scenarios;
}