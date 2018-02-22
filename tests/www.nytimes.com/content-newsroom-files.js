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
        'prd': false,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      requestScheme: "https://",
      requestUri: "/files/healthcheck.txt",
      responseHeaderMatches: {
        "x-pagetype": "newsroom-files-gcs"
      },
      responseHeadersPresent: ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      responseStatusCode: [200],
      scenarioDescription: "Packages GCS bucket responds with 200",
      testId: 1
    },
  ];

  return scenarios;
}