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
        prd: false,
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
      scenarioDescription: "Newsgraphics GCS bucket responds with 200",
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForProjectsHealthcheck',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: false,
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
  ];

  return scenarios;
}
