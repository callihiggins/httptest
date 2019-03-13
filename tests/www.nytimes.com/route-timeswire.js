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
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-timeswire',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Timeswire Page; /timeswire',
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
      requestUri: '/timeswire/',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-timeswire',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [301],
      scenarioDescription: 'Vi Timeswire Page; /timeswire/',
      testId: 2
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestHeaders: {
        'User-agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36'
      },
      requestScheme: 'https://',
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-timeswire',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Timeswire Page; does not redirect to mobile',
      testId: 3
    }
  ];

  return scenarios;
}
