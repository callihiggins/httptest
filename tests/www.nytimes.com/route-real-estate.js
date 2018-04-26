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
      },
      requestScheme: 'https://',
      requestUri: '/real-estate/find-a-home',
      responseHeaderMatches: {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
      },
      responseStatusCode: 200,
      scenarioDescription:
        'Test real estate: "/real-estate/find-a-home" ',
      testId: 1
    },
  ];

  return scenarios;
}
