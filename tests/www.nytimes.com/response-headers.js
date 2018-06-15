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
      'requestUri': '/2016/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-frame-options': 'DENY',
      },
      'responseHeadersPresent': [
        'age',
        'cache-control',
        'x-api-version',
        'x-cache',
        'x-nyt-route',
        'x-served-by',
        'x-gdpr',
      ],
      'responseHeadersNotPresent': [
        'nnCoection',
        'via',
        'x-backend',
        'x-detectedruntimeconfigflag',
        'x-esi-status',
        'x-hash',
        'x-powered-by',
        'x-servername',
        'x-servername2',
        'x-varnish',
      ],
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test response headers',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/01/01/us/slug.html',
      'responseHeadersPresent': [
        'debug-var-nyt-env',
        'debug-var-nyt-force-pass'
      ],
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test Debug response headers',
      'testId': 2,
    },
  ];

  return scenarios;
}
