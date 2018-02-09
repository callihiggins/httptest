var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "FunctionalTestScenarioDefinitionForPackagesGCSBucket",
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      requestScheme: "https://",
      requestUri: "/packages/files/healthcheck.txt",
      responseHeaderMatches: {
        "x-pagetype": "packages-gcs"
      },
      responseHeadersPresent: ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      responseStatusCode: [200],
      scenarioDescription: "Packages GCS bucket responds with 200",
      testId: 1
    },
  ];

  return scenarios;
}
