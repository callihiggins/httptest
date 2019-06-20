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
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-us=1;/,
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test /newsletters/ is served from vi',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForNewsletters',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/newsletters/louder?ip-override=137.99.78.82',
      responseHeaderMatches: {
        'x-nyt-route': 'newsletter',
        'x-nyt-backend': 'projectvi_fe',
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-us=1;/,
      },
      scenarioDescription: 'Set cookie with value of 1 for US users.',
      testId: 2
    },
    {
      id: 'FunctionalTestScenarioDefinitionForNewsletters',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/newsletters/louder?ip-override=85.90.227.224',
      responseHeaderMatches: {
        'x-nyt-route': 'newsletter',
        'x-nyt-backend': 'projectvi_fe',
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-us=0;/,
      },
      scenarioDescription: 'Set cookie with value of 0 for non-US users.',
      testId: 3
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        prd: true,
        stg: true,
        dev: true
      },
      'requestScheme': 'https://',
      'requestUri': '/newsletters/louder',
      'method': 'POST',
      'responseStatusCode': [405],
      'scenarioDescription': 'POST method requests are not allowed for newsletters route',
      'testId': 4
    },
  ];

  return scenarios;
}
