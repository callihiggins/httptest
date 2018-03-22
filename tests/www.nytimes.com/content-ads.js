var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "FunctionalTestScenarioDefinitionForAdsGCSBucket",
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      requestScheme: "http://",
      requestUri: "/ads/emailads/twitter.jpg",
      responseHeaderMatches: {
        "x-pagetype": "ads-static-assets",
        "x-nyt-backend": "gcs_origin"
      },
      responseHeadersPresent: ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      responseStatusCode: [200,404],
      scenarioDescription: "Ads GCS bucket responds with 200",
      testId: 1
    },
  ];

  return scenarios;
}
