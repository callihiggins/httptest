var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForNewsletters',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/newsletters/louder',
      responseHeaderMatches: {
        'x-nyt-route': 'newsletter',
        'x-nyt-backend': 'projectvi_fe',
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test /newsletters/ is served from vi',
      testId: 1
    },
  ];

  return scenarios;
}
