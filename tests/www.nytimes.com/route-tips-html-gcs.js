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
        'referrer-policy': 'no-referrer',
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
        'referrer-policy': 'no-referrer',
      },
      responseStatusCode: [200],
      scenarioDescription: "Tips index.html responds with 200",
      testId: 2
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
        'referrer-policy': 'no-referrer',
      },
      responseStatusCode: [200],
      scenarioDescription: "Tips email public GPG key responds with 200",
      testId: 3
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/tips',
      responseHeaderMatches: {
        'x-nyt-route': 'tips-html-gcs',
        'x-nyt-backend': 'gcs_origin',
        'referrer-policy': 'no-referrer',
        location:
          'https://' +
          suite.servername +
          '/tips'
      },
      responseStatusCode: 301,
      scenarioDescription: 'Test HTTPS Everywhere; tips; non-secure',
      testId: 4
    },
  ];

  // add tests for no https
  // add tests for client ip is 0.0.0.0
  // add tests for referrer policy not set

  return scenarios;
}
