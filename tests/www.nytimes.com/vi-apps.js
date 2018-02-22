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
        dev: false,
        sbx: false
      },
      requestScheme: 'https://',
      requestUri: '/search',
      responseHeaderMatches: {
        'x-pagetype': 'vi-search'
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
        dev: false,
        sbx: false
      },
      requestScheme: 'https://',
      requestUri: '/search/apple/best',
      responseHeaderMatches: {
        'x-pagetype': 'vi-search'
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
        dev: false,
        sbx: false
      },
      requestScheme: 'https://',
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-pagetype': 'vi-timeswire'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Timeswire Page',
      testId: 3
    }
  ];

  return scenarios;
}
