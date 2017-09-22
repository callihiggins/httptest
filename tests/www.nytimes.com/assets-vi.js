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
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'NYT-BCET=' + suite.cookies.nyt_bcet,
        'NYT-S=' + suite.cookies.nyt_s,
      ],
      'requestScheme': 'https://',
      'requestUri': '/vi-assets/up.txt',
      'responseHeaderMatches': {
        'x-pagetype': 'vi-asset',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test fetching a vi asset',
      'testId': 1,
    },
  ];

  return scenarios;
}
