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
        'dev': true,
        'sbx': false,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/elections/results',
      'responseHeaderMatches': {
        'x-api-version': 'F-I'
      },
      'responseHeaderPattern': {
        'location': /https:\/\/www(\.dev|\.stg)?\.nytimes\.com\/elections\/results\/.+/
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
        'dev': true,
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
      'id': 'FunctionalTestScenarioDefinitionForBackendFailover',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
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
    {
      'id': 'FunctionalTestScenarioDefinitionForFrameBustingInScoop',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/elections/2017/widget/mobile/2017-12-12',
      'requestHeaders': {
        'Referer': 'https://scoop.nyt.net/',
      },
      'responseHeadersNotPresent': [
        'x-frame-options'
      ],
      'responseStatusCode': 200,
      'scenarioDescription': 'Do not framebust requests from Scoop',
      'testId': 5,
    },
  ];

  return scenarios;
}
