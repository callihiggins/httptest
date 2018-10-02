var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForHealthService',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/backendhealth.html',
      responseHeaderMatches: {
        'x-nyt-route': 'backend-health-report',
        'x-nyt-backend': 'fastly-synth',
      },
      responseStatusCode: [200],
      scenarioDescription: 'Backend health report HTML payload returns 200',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHealthService',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/backendhealth.json',
      responseHeaderMatches: {
        'x-nyt-route': 'backend-health-report',
        'x-nyt-backend': 'fastly-synth',
      },
      responseStatusCode: [200],
      scenarioDescription: 'Backend health report JSON payload returns 200',
      testId: 1
    },
  ];

  return scenarios;
}
