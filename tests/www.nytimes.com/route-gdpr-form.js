var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "FunctionalTestScenarioDefinitionForHtmlPage",
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': true,
      },
      requestScheme: "https://",
      requestUri: "/data-subject-request",
      responseHeaderMatches: {
        "x-nyt-route": "gdpr-form",
        "x-nyt-backend": "projectvi_fe"
      },
      responseStatusCode: [200],
      scenarioDescription: "route: gdpr form",
      testId: 1
    },
  ];

  return scenarios;
}
