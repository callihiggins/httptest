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
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/elections/results',
      'responseHeaderMatches': {
        'x-nyt-route': 'elections',
        'x-nyt-backend': 'newsdev_elections',
      },
      'responseHeaderPattern': {
        'location': /https:\/\/www(\.dev|\.stg)?\.nytimes\.com\/elections\/results\/.+/
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'content-elections: Test elections; obey redirects configured by x-amz-meta-website-redirect-location header',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCache',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/elections/results/president',
      'responseHeaderMatches': {
        'cache-control': 'public, max-age=86400',
        'x-nyt-route': 'elections',
        'x-nyt-backend': 'newsdev_elections',
      },
      'responseHeadersPresent': [
        'x-goog-hash'
      ],
      'responseStatusCode': 200,
      'scenarioDescription': 'content-elections: Test elections 200 cache',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForFrameBustingInScoop',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/elections/2017/widget/mobile/2017-12-12',
      'requestHeaders': {
        'Referer': 'https://scoop.nyt.net/',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'elections',
        'x-nyt-backend': 'newsdev_elections',
      },
      'responseHeadersNotPresent': [
        'x-frame-options'
      ],
      'responseStatusCode': 200,
      'scenarioDescription': 'content-elections: Do not framebust requests from Scoop',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForS3Failover',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestUri': '/elections/results/president',
      'responseHeaderMatches': {
        'x-nyt-route': 'elections',
        'x-nyt-backend': 'newsdev_elections_s3',
      },
      'responseHeadersNotPresent': [
        'x-goog-hash'
      ],
      'responseStatusCode': 200,
      'scenarioDescription': 'content-elections: Serve from S3 when newsdev_elections.use_s3 = true',
      'testId': 6,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForViFailover',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/2018/11/06/us/elections/results-kansas-elections.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'elections',
        'x-nyt-backend': 'newsdev_elections',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'content-elections: Serve select interactives from GCS when newsdev_elections.serve_vi = true',
      'testId': 7,
    },
  ];

  return scenarios;
}
