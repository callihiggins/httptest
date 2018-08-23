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
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/ask/fitness',
      responseHeaderMatches: {
        'x-nyt-route': 'ask',
        'x-nyt-backend': 'projectvi_fe',
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test /ask is served from vi',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        prd: true,
        stg: true,
        dev: true
      },
      'requestScheme': 'https://',
      'requestUri': '/ask/fitness',
      'method': 'POST',
      'responseStatusCode': [405],
      'scenarioDescription': 'POST method requests are not allowed for ask route',
      'testId': 10
    },
  ];

  return scenarios;
}
