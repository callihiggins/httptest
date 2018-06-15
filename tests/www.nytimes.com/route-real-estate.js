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
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/find-a-home?price=5&bad1=4&region=2&bad2=5&neighborhood=hello',
      'responseHeaderMatches': {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'x-nyt-final-url': '/real-estate/find-a-home?neighborhood=hello&price=5&region=2',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test realestate querystring filter',
      'testId': 2,
    },
  ];

  return scenarios;
}
