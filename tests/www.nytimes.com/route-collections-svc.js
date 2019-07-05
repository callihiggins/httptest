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
      'requestScheme': 'https://',
      'requestUri': '/svc/collections/v1/publish/scoop/www.nytimes.com/section/politics?limit=0&what=1&hi=2',
      'responseHeaderMatches': {
        'x-nyt-backend': 'collections_svc',
        'x-api-version': 'F-X',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'collections-svc',
        'x-nyt-final-url': '/svc/collections/v1/publish/scoop/www.nytimes.com/section/politics?limit=0',
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
      'scenarioDescription': 'Test hitting collections-svc endpoints with querystring filter check dev/stg/prd',
      'testId': 1,
    },
    {
      'isDeployedInEnv': {
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/collections/v1/publish/scoop/www.nytimes.com/by/paul-krugman?limit=0',
      'responseHeaderMatches': {
        'x-nyt-backend': 'collections_svc',
        'x-api-version': 'F-X',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'collections-svc',
      },
      'scenarioDescription': 'Test hitting collections-svc endpoints stg/prd',
      'testId': 2,
    },
    {
      'isDeployedInEnv': {
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/collections/v1/publish/scoop/www.nytimes.com/column/modern-love?limit=0',
      'responseHeaderMatches': {
        'x-nyt-backend': 'collections_svc',
        'x-api-version': 'F-X',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'collections-svc',
      },
      'scenarioDescription': 'Test hitting collections-svc endpoints stg/prd',
      'testId': 3,
    },
    {
      'isDeployedInEnv': {
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/collections/v1/publish/scoop/www.nytimes.com/news-event/winter-olympics-2018?limit=0',
      'responseHeaderMatches': {
        'x-nyt-backend': 'collections_svc',
        'x-api-version': 'F-X',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'collections-svc',
      },
      'scenarioDescription': 'Test hitting collections-svc endpoints stg/prd',
      'testId': 4,
    },
    {
      'isDeployedInEnv': {
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/collections/v1/publish/scoop/www.nytimes.com/spotlight/healthcare-decoded?limit=0',
      'responseHeaderMatches': {
        'x-nyt-backend': 'collections_svc',
        'x-api-version': 'F-X',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'collections-svc',
      },
      'scenarioDescription': 'Test hitting collections-svc endpoints stg/prd',
      'testId': 5,
    },
    {
      'isDeployedInEnv': {
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/collections/v1/publish/scoop/www.nytimes.com/topic/company/alphabet-inc?limit=0',
      'responseHeaderMatches': {
        'x-nyt-backend': 'collections_svc',
        'x-api-version': 'F-X',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'collections-svc',
      },
      'scenarioDescription': 'Test hitting collections-svc endpoints stg/prd',
      'testId': 5,
    },
    {
      'isDeployedInEnv': {
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/collections/v1/publish/scoop/www.nytimes.com/series/australia-newsletter?limit=0',
      'responseHeaderMatches': {
        'x-nyt-backend': 'collections_svc',
        'x-api-version': 'F-X',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'collections-svc',
      },
      'scenarioDescription': 'Test hitting collections-svc endpoints stg/prd',
      'testId': 6,
    },
    {
      'isDeployedInEnv': {
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/collections/v1/publish/scoop/www.nytimes.com/issue/t-magazine/2017/12/21/t-magazine-collection?limit=0',
      'responseHeaderMatches': {
        'x-nyt-backend': 'collections_svc',
        'x-api-version': 'F-X',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'collections-svc',
      },
      'scenarioDescription': 'Test hitting collections-svc endpoints stg/prd',
      'testId': 7,
    },
  ]
  return scenarios;
}
