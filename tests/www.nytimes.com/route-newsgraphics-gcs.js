var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/newsgraphics/2014/01/05/poverty-map/index.html',
      responseHeaderMatches: {
        'x-nyt-route': 'newsgraphics-gcs',
        'x-nyt-backend': 'gcs_origin',

      },
      responseHeadersPresent: ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      responseStatusCode: [200],
      scenarioDescription: "Newsgraphics GCS bucket responds with 200 over http",
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForProjectsHealthcheck',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/projects/healthcheck.txt',
      responseHeaderMatches: {
        'x-nyt-route': 'newsgraphics-gcs',
        'x-nyt-backend': 'gcs_origin',

      },
      responseHeadersPresent: ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      responseStatusCode: [200],
      scenarioDescription: "Projects path in newsgraphics GCS bucket responds with 200",
      testId: 2
    },
    {
      id: 'FunctionalTestScenarioDefinitionForRedirect',
      isDeployedInEnv: {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      requestScheme: 'http://',
      requestUri: '/newsgraphics/2012/1220-snow-fall-preview/',
      responseHeaderMatches: {
        'x-nyt-route': 'newsgraphics-gcs',
        'x-nyt-backend': 'gcs_origin',
      },
      responseHeaderPattern: {
        'location': /https?:\/\/www(\.dev|\.stg)?\.nytimes\.com\/newsgraphics\/2012\/1220-snow-fall-preview\/index\.html/
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test newsgraphics; obey redirects configured by x-amz-meta-website-redirect-location header',
      testId: 3
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHTTPS200',
      isDeployedInEnv: {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      requestScheme: 'https://',
      requestUri: '/newsgraphics/2018/healthcheck.txt',
      responseHeaderMatches: {
        'x-nyt-route': 'newsgraphics-gcs',
        'x-nyt-backend': 'gcs_origin',
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test newsgraphics; 2018 should work on https',
      testId: 4
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHTTPS200',
      isDeployedInEnv: {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      requestScheme: 'https://',
      requestUri: '/newsgraphics/2017/healthcheck.txt',
      responseHeaderMatches: {
        'x-nyt-route': 'newsgraphics-gcs',
        'x-nyt-backend': 'gcs_origin',
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test newsgraphics; 2017 should work on https',
      testId: 5
    },
  ];

  return scenarios;
}
