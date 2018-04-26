var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "FunctionalTestScenarioDefinitionForMessagingSvcPushMobile",
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      requestScheme: 'https://',
      requestUri: '/svc/pushmobile/v2/device/newsandroid/systemtest.json',
      responseHeaderMatches: {
        'x-nyt-backend': 'messaging',
        'x-nyt-route': 'messaging'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test messaging, /svc/pushmobile(.*)',
      testId: 1
    },
    {
      id: "FunctionalTestScenarioDefinitionForMessagingSvcMessage",
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      requestScheme: 'https://',
      requestUri: '/svc/message/v1/list/global.json',
      responseHeaderMatches: {
        'x-nyt-backend': 'messaging',
        'x-nyt-route': 'messaging'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test messaging, /svc/message/(.*)',
      testId: 2
    },
  ];

  return scenarios;
}
