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
      requestUri: '/style/weddings/announcements',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-weddings',
        'x-nyt-backend': 'projectvi_fe'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Weddings Announcement Page',
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
      'requestUri': '/style/weddings/announcements',
      'method': 'POST',
      'responseStatusCode': [405],
      'scenarioDescription': 'POST method requests are not allowed for weddings route',
      'testId': 2
    },
  ];

  return scenarios;
}
