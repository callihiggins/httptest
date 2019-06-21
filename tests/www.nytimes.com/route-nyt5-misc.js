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
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/reviews/dining/map/?gdpr=1',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-nyt-route': 'collection',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test misc  on /reviews/dining/map/',
      'testId': 7,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/reviews/dining/map/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-nyt-route': 'collection',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test misc  on /reviews/dining/map/',
      'testId': 107,
    },

  ];

  return scenarios;
}
