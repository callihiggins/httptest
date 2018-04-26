var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents()
{
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
      requestUri: '/guides/culture/guide-to-the-metropolitan-museum-of-art',
      responseHeaderMatches: {
        'x-nyt-route': 'guides',
      },
      responseStatusCode: 200,
      scenarioDescription:
        'Test well guide',
      testId: 1
    },
  ];

  return scenarios;
}
