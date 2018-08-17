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
        'dev': true
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
    {
      'id': 'FunctionalTestScenarioDefinitionForStaticFonts',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/vi-assets/static-assets/story-woff2.fonts-8cda51537d027e0df92bea96a094bfe3.css',
      'responseHeaderMatches': {
        'access-control-allow-origin': '*',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Fonts .css files served with CORS headers',
      'testId': 2,
    },
  ];

  return scenarios;
}
