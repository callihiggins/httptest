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
      'requestUri': '/search',
      'responseHeaderMatches': {
        'x-pagetype': 'vi-search',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'VI Search Homepage',
      'testId': 1,
    },
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
      'requestUri': '/search/apple/best',
      'responseHeaderMatches': {
        'x-pagetype': 'vi-search',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'VI Search term - apple',
      'testId': 2,
    },
  ];

  return scenarios;
}
