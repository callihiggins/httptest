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
        "x-pagetype": "newsgraphics-gcs"
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
        "x-pagetype": "newsgraphics-gcs"
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
      requestUri: '/newsgraphics/2018/02/06/sticky.js',
      responseHeaderMatches: {
        "x-pagetype": "newsgraphics-gcs"
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
      requestUri: '/newsgraphics/2017/11/06/star-wars-article/02e8a03df52f881971fd9b79eb6ef2a9fce6604f/sticky.js',
      responseHeaderMatches: {
        "x-pagetype": "newsgraphics-gcs"
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test newsgraphics; 2017 should work on https',
      testId: 5
    },
  ];

  return scenarios;
}
