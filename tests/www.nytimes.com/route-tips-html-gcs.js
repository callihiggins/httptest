var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "FunctionalTestScenarioDefinitionForTipsHTMLGCSBucket",
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      requestScheme: "https://",
      requestUri: "/tips/healthcheck.txt",
      responseHeaderMatches: {
        'x-nyt-route': 'tips-html-gcs',
        'x-nyt-backend': 'gcs_origin',
      },
      responseStatusCode: [200],
      scenarioDescription: "Tips path responds with 200",
      testId: 1
    },
    {
      id: "FunctionalTestScenarioDefinitionForTipsHTMLGCSBucket",
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      requestScheme: "https://",
      requestUri: "/tips",
      responseHeaderMatches: {
        'x-nyt-route': 'tips-html-gcs',
        'x-nyt-backend': 'gcs_origin',
      },
      responseStatusCode: [200],
      scenarioDescription: "Tips index.html responds with 200",
      testId: 1
    },
    {
      id: "FunctionalTestScenarioDefinitionForTipsHTMLGCSBucket",
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      requestScheme: "https://",
      requestUri: "/tips/public/tips_pubkey.asc",
      responseHeaderMatches: {
        'x-nyt-route': 'tips-html-gcs',
        'x-nyt-backend': 'gcs_origin',
      },
      responseStatusCode: [200],
      scenarioDescription: "Tips email public GPG key responds with 200",
      testId: 1
    },
  ];

  // add tests for no https
  // add tests for client ip is 0.0.0.0
  // add tests for referrer policy not set

  return scenarios;
}
