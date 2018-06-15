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
        'stg': false,
        'dev': false
      },
      requestScheme: "https://",
      requestUri: "/ads/emailads/twitter.jpg",
      responseHeaderMatches: {
        "x-nyt-route": "ads-static-assets",
        "x-nyt-backend": "gcs_origin"
      },
      responseHeadersPresent: ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      responseStatusCode: [200,404],
      scenarioDescription: "route: /ads; 200 or 404 from GCS on correct backend/pagetype",
      testId: 1
    },
    {
      id: "FunctionalTestScenarioDefinitionForAdsGCSBucket",
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true
      },
      requestScheme: "https://",
      requestUri: "/ads/safeads/index.html",
      responseHeaderMatches: {
        "x-nyt-route": "ads-static-assets",
        "x-nyt-backend": "gcs_origin"
      },
      responseHeadersPresent: ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      responseStatusCode: [200,404],
      scenarioDescription: "route dev/stg bucket has different assets; 200 or 404 from GCS on correct backend/pagetype",
      testId: 2
    },
  ];

  return scenarios;
}
