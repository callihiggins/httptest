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
      'requestUri': '/?ip-override=170.149.100.75&abra=WP_ProjectVi_www_hp=0',
      'responseHeaderMatches': {
        'x-frame-options': 'DENY',
        'x-nyt-continent': 'NA',
        'x-nyt-country': 'US',
        'x-nyt-region': 'NY',
      },
      'responseHeadersPresent': [
        'age',
        'x-api-version',
        'x-cache',
        'x-pagetype',
        'x-served-by',
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
      'responseStatusCode': [200],
      'scenarioDescription': 'Test geoip integration',
      'testId': 1,
    },
  ];

  return scenarios;
}
