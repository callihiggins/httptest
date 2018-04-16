var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "FunctionalTestScenarioDefinitionForNewsroomGCSBucket",
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      requestScheme: "https://",
      requestUri: "/files/healthcheck.txt",
      responseHeaderMatches: {
        'x-pagetype': 'newsroom-files-gcs',
        'x-nyt-backend': 'gcs_origin',
      },
      responseHeadersPresent: ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      responseStatusCode: [200],
      scenarioDescription: "newsroom files route GCS bucket responds with 200",
      testId: 1
    },
  ];

  return scenarios;
}
