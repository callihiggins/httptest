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
      'requestScheme': 'http://',
      'requestUri': '/svc/profile/v2/email/verified-product-subscriptions-address',
      'responseHeaderMatches': {
        'x-api-version': 'F-X',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy',
      },
      'responseHeadersPresent': [
        'x-cache',
        'x-served-by',
      ],
      'responseHeadersNotPresent': [
        'age',
        'cache-control',
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
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test service; email, verified product subscriptions address',
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
      'requestScheme': 'http://',
      'requestUri': '/svc/collections/v1/publish/',
      'responseHeaderMatches': {
        'x-api-version': 'F-X',
        'x-frame-options': 'DENY',
        'x-pagetype': 'collections-svc',
      },
      'responseHeadersPresent': [
        'x-cache',
        'x-served-by',
      ],
      'responseHeadersNotPresent': [
        'cache-control',
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
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test service; collections',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'http://',
      'requestUri': '/svc/weddings',
      'responseHeaderMatches': {
        'age': '0',
        'x-api-version': 'F-DUW',
        'x-cache': 'MISS, MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'weddings-api',
      },
      'responseHeadersPresent': [
        'x-served-by',
      ],
      'responseHeadersNotPresent': [
        'cache-control',
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
      'responseStatusCode': [400],
      'scenarioDescription': 'Test service; weddings',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForSvcBitly',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/bitly/shorten.json?url=https://www.nytimes.com/',
      'responseHeaderMatches': {
        'x-api-version': 'F-CA',
        'x-frame-options': 'DENY',
        'x-pagetype': 'content-api',
      },
      'responseHeadersPresent': [
        'x-served-by',
      ],
      'responseHeadersNotPresent': [
        'cache-control',
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
      'scenarioDescription': 'Test service; bitly',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForSvcDining',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/dining/v2/version.json',
      'responseHeaderMatches': {
        'x-api-version': 'F-CA',
        'x-frame-options': 'DENY',
        'x-pagetype': 'content-api',
      },
      'responseHeadersPresent': [
        'x-served-by',
      ],
      'responseHeadersNotPresent': [
        'cache-control',
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
      'scenarioDescription': 'Test service; dining',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForSvcLocation',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/location/v1/current.json',
      'responseHeaderMatches': {
        'x-api-version': 'F-CA',
        'x-frame-options': 'DENY',
        'x-pagetype': 'content-api',
      },
      'responseHeadersPresent': [
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
      'scenarioDescription': 'Test service; location',
      'testId': 6,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForSvcMostPopular',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/mostpopular/v3/viewed/1.json',
      'responseHeaderMatches': {
        'x-api-version': 'F-CA',
        'x-frame-options': 'DENY',
        'x-pagetype': 'content-api',
      },
      'responseHeadersPresent': [
        'x-served-by',
      ],
      'responseHeadersNotPresent': [
        'cache-control',
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
      'scenarioDescription': 'Test service; most popular',
      'testId': 7,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForSvcNews',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/news/v3/all/recent.json',
      'responseHeaderMatches': {
        'x-api-version': 'F-CA',
        'x-frame-options': 'DENY',
        'x-pagetype': 'content-api',
      },
      'responseHeadersPresent': [
        'x-served-by',
      ],
      'responseHeadersNotPresent': [
        'cache-control',
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
      'scenarioDescription': 'Test service; news',
      'testId': 8,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForWeather',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/weather/v2/current-and-seven-day-forecast.json',
      'responseHeaderMatches': {
        'x-api-version': 'F-CA',
        'x-frame-options': 'DENY',
        'x-pagetype': 'content-api',
      },
      'responseHeadersPresent': [
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
      'scenarioDescription': 'Test service; weather',
      'testId': 9,
    },
  ];

  return scenarios;
}
