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
        'NYT-S=' + suite.cookies.nyt_s,
        'NYT-BCET=' + suite.cookies.nyt_bcet,
      ],
      'requestScheme': 'https://',
      'requestUri': '/2016/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-frame-options': 'DENY',
      },
      'responseHeadersPresent': [
        'age',
        'cache-control',
        'x-age',
        'x-api-version',
        'x-cache',
        'x-origin-server',
        'x-pagetype',
        'x-served-by',
        'x-varnishcacheduration',
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
  ];

  return scenarios;
}