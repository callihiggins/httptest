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
      'requestUri': '/es/',
      'responseHeaderMatches': {
        'x-api-version': 'F-X',
        'x-frame-options': 'DENY',
        'x-pagetype': 'intl',
      },
      'responseHeadersPresent': [
        'age',
        'x-cache',
        'x-served-by',
      ],
      'responseHeadersNotPresent': [
        'nnCoection',
        'via',
        'x-age',
        'x-backend',
        'x-detectedruntimeconfigflag',
        'x-esi-status',
        'x-hash',
        'x-origin-server',
        'x-powered-by',
        'x-servername',
        'x-servername2',
        'x-varnish',
        'x-varnishcacheduration',
      ],
      'responseStatusCode': [200],
      'scenarioDescription': 'Test NYTimes en Espanol',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/es/al-dia?withcomments=true',
      'responseHeaderPattern': {
        'location': /\d{4}\/\d{2}\/\d{2}\/.+?withcomments=true/,
      },
      'scenarioDescription': 'Test WordPress query parameters in vanity URL redirects',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/es/al-dia?mccr=ES',
      'responseHeaderPattern': {
        'location': /\d{4}\/\d{2}\/\d{2}\/.+?mccr=ES/,
      },
      'scenarioDescription': 'Test analytics query parameters in vanity URL redirects',
      'testId': 3,
    }
  ];

  return scenarios;
}
