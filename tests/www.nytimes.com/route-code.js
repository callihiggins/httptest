
var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/code',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-code',
        'x-nyt-backend': 'projectvi_fe'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Code Redemption Landing Page',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/code?gift_code=abc1235679876xyz',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-code',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
        'x-nyt-final-url': '/code?gift_code=abc1235679876xyz',
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Code Redemption code - abc1235679876xyz',
      testId: 2
    },
  ];

  return scenarios;
}
