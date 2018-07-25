var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForAskRoute',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/ask',
      responseHeaderMatches: {
        'x-nyt-route': 'ask',
        'x-nyt-backend': 'projectvi_fe',
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test /ask is served from vi',
      testId: 1
    },
  ];

  return scenarios;
}
