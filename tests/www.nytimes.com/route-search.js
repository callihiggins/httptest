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
        dev: false
      },
      requestScheme: 'https://',
      requestUri: '/search?gdpr=1',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-search',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      scenarioDescription: 'Vi Search Homepage',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestScheme: 'https://',
      requestUri: '/search?query=apple&sort=best&_gae=hello&_=1234123',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-search',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
        'x-nyt-final-url': '/search?query=apple&sort=best',
      },
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
      requestUri: '/search?query=kevin%20durant',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-search',
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-final-url': '/search?query=kevin%20durant',
      },
      scenarioDescription: 'Vi Search term - kevin durant',
      testId: 3
    }
  ];

  return scenarios;
}
