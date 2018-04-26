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
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/vi-assets/up.txt',
      'responseHeadersPresent': [
        'x-goog-storage-class',
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-assets',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test fetching a vi asset',
      'testId': 1,
    },
  ];

  return scenarios;
}
