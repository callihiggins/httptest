var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "FunctionalTestScenarioDefinitionForCMSGCSBucket",
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': true,
        'sbx': false,
      },
      requestScheme: "https://",
      requestUri: "/images/2017/12/20/arts/testtestmerlindec19/testtestmerlindec19-videoSmall.jpg",
      responseHeaderMatches: {
        "x-pagetype": "cms-static-assets"
      },
      responseHeadersPresent: ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      responseStatusCode: [200],
      scenarioDescription: "route-cms-static-assets: 200 response from GCS",
      testId: 1
    },
    {
      id: "FunctionalTestScenarioDefinitionForCMSGCSBucket",
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      requestScheme: "https://",
      requestUri: "/images/2018/01/10/watching/getOUT/getOUT-videoSmall.jpg",
      responseHeaderMatches: {
        "x-pagetype": "cms-static-assets",
      },
      responseHeadersPresent: ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      responseStatusCode: [200],
      scenarioDescription: "route-cms-static-assets: 200 response from GCS",
      testId: 2
    },
  ];

  return scenarios;
}
