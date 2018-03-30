var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForNewsdevCloudFunctions',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/svc/int/functions/contact-reporter',
      responseHeaderMatches: {
        'x-pagetype': 'newsdev-cloud-functions',
        'access-control-allow-origin': '*',
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test /svc/int/functions is served from newsdev cloud functions backend',
      testId: 1
    },
  ];

  return scenarios;
}
