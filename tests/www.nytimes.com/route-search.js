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
    }
  ];

  return scenarios;
}
