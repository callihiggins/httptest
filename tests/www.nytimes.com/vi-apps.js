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
        dev: true,
        sbx: false
      },
      requestScheme: 'https://',
      requestUri: '/search',
      responseHeaderMatches: {
        'x-pagetype': 'vi-search',
        'x-nyt-backend': 'projectvi_fe'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Search Homepage',
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
      requestUri: '/search/apple/best',
      responseHeaderMatches: {
        'x-pagetype': 'vi-search',
        'x-nyt-backend': 'projectvi_fe'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Search term - apple',
      testId: 2
    },
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
        'x-pagetype': 'vi-timeswire',
        'x-nyt-backend': 'projectvi_fe'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Timeswire Page; /timeswire',
      testId: 3
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
        'x-pagetype': 'vi-timeswire',
        'x-nyt-backend': 'projectvi_fe'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Timeswire Page; /timeswire/',
      testId: 4
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
        'x-pagetype': 'vi-timeswire',
        'x-nyt-backend': 'projectvi_fe'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Timeswire Page; does not redirect to mobile',
      testId: 5
    },
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
        'x-pagetype': 'vi-weddings'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Weddings Announcement Page',
      testId: 6
    }
  ];

  return scenarios;
}
