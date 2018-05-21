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
      requestUri: '/real-estate/find-a-home?gdpr=1',
      responseHeaderMatches: {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: 200,
      scenarioDescription:
        'Test real estate: "/real-estate/find-a-home" ',
      testId: 1
    },
  ];

  return scenarios;
}
