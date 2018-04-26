var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "FunctionalTestScenarioDefinitionForSitemap",
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      requestScheme: 'https://',
      requestUri: '/recommendations',
      responseHeaderMatches: {
        'x-nyt-backend': 'recommendations',
        'x-nyt-route': 'recommendations'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test recommendations, migrated from netscaler',
      testId: 1
    },
  ];

  return scenarios;
}
