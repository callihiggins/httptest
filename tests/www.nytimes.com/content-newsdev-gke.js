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
      'id': 'FunctionalTestScenarioDefinitionForFashionRunway',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/fashion/runway/season/spring-2014-rtw',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-gke',
        'x-nyt-backend': 'newsdev_k8s_gke',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test fashion runway pages',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForDynamicPublicApp',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/int/dialects',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-gke',
        'x-nyt-backend': 'newsdev_k8s_gke',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test response from dynamic newsdev-gke app on /svc/int',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForDynamicPublicAppUncached',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s,
      ],
      'requestScheme': 'https://',
      'requestUri': '/svc/int/godzown/u/2017-01-26-opinion-sleep-assesment-adventure-production',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-gke',
        'x-cache': 'MISS',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Skip caching on certain dynamic public apps on /svc/int',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForGuantanamoRouting',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/guantanamo',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-gke',
        'x-nyt-backend': 'newsdev_k8s_gke',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Guantanamo routing',
      'testId': 6,
    },
  ];

  return scenarios;
}
