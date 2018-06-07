var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
var scenariosWithBodyHandler = getScenariosWithBodyHandlerEvents();
suite.run(suite, scenarios);
suite.run(suite, scenariosWithBodyHandler, bodyHandler);

/**
 * @return void
 */
function bodyHandler(s, t, body, response)
{
  t.ok(body.indexOf('<Code>NoSuchKey</Code>') === -1, '404 page is not a GCS "NoSuchCode" error page');
  t.ok(body.indexOf('<html') > -1, '404 page has an html tag');
}

/**
 * @return array
 */
function getScenarioEvents()
{
  var scenarios = [
    {
      'id': 'FunctionalTestScenarioDefinitionForStaticEditorialStandardsPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/editorial-standards/ethical-journalism.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'newsdev-gcs',
        'x-nyt-backend': 'gcs_origin',
      },
      'responseHeadersPresent': ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      'responseStatusCode': [200],
      'scenarioDescription': 'Test static html pages hosted on gs://nytint-' + suite.env + '-www',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForStaticS3Page',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/london2012',
      'responseHeaderMatches': {
        'x-nyt-route': 'newsdev-gcs',
        'x-nyt-backend': 'gcs_origin',
        'content-type': 'text/html; charset=utf-8',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test static html pages hosted on gs://nytint-' + suite.env + '-www',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForStaticS3PageNested',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/london2012/schedule',
      'responseHeaderMatches': {
        'x-nyt-route': 'newsdev-gcs',
        'x-nyt-backend': 'gcs_origin',
        'content-type': 'text/html; charset=utf-8',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test nested static html pages hosted on gs://nytint-' + suite.env + '-www',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForStaticS3PageJson',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/london2012/navigation.json',
      'responseHeaderMatches': {
        'x-nyt-route': 'newsdev-gcs',
        'x-nyt-backend': 'gcs_origin',
        'content-type': 'application/json',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test static json pages hosted on gs://nytint-' + suite.env + '-www',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForStaticS3PageRedirect',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': false,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/crime',
      'responseHeaderMatches': {
        'x-nyt-route': 'newsdev-gcs',
        'x-nyt-backend': 'gcs_origin',
        'location': 'https://www.nytimes.com/interactive/projects/crime/homicides/map'
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'Test s3 redirect metadata',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForStaticGCSPageCache',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/crime/homicides/map',
      'responseHeaderMatches': {
        'cache-control': 'public, max-age=86400',
        'x-nyt-backend': 'gcs_origin',
        'x-nyt-route': 'newsdev-gcs',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test gcs cache response',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForGCSPageConversationPiecesRouting',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/cp/awards-season/emmys-2015/uzo-aduba-thanks-those-who-let-her-be-herself',
      'responseHeaderMatches': {
        'x-nyt-route': 'newsdev-gcs',
        'x-nyt-backend': 'gcs_origin',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test gcs conversation pieces routing',
      'testId': 7,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRoomForDebateIndex',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/roomfordebate',
      'responseHeaderMatches': {
        'x-nyt-route': 'newsdev-gcs',
        'x-nyt-backend': 'gcs_origin',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Room for debate homepage',
      'testId': 8,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRoomForDebateDetail',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/roomfordebate/2017/01/17/can-western-states-afford-a-federal-land-transfer/state-management-of-federal-lands-would-advance-corporate-profits-over-public-benefit',
      'responseHeaderMatches': {
        'x-nyt-route': 'newsdev-gcs',
        'x-nyt-backend': 'gcs_origin',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Room for debate detail',
      'testId': 9,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/modern-love/36-questions/',
      'responseHeaderMatches': {
        'x-frame-options': 'DENY',
        'x-nyt-route': 'newsdev-gcs',
        'x-nyt-backend': 'gcs_origin',
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
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test NYTimes Interactive Modern Love',
      'testId': 10,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForGCS404PageDirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/404.html',
      'responseHeadersPresent': [
        'cache-control'
      ],
      'responseHeaderMatches': {
        'x-nyt-backend': 'gcs_origin',
        'x-nyt-route': 'newsdev-gcs',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test gcs "404" page directly',
      'testId': 11,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForStaticGCSPageRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/notable-deaths/2017',
      'responseHeaderMatches': {
        'x-nyt-route': 'newsdev-gcs',
        'x-nyt-backend': 'gcs_origin',
        'location': 'https://www.nytimes.com/interactive/2017/obituaries/notable-deaths'
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'Test notable-deaths GCS redirect metadata',
      'testId': 12,
    },
  ];

  return scenarios;
}

/**
 * @return array
 */
function getScenariosWithBodyHandlerEvents()
{
  var scenarios = [
    {
      'id': 'FunctionalTestScenarioDefinitionForGCSPage404Cache',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/page-that-does-not-exist',
      'responseHeadersPresent': [
        'cache-control'
      ],
      'responseHeaderMatches': {
        'x-nyt-backend': 'gcs_origin',
        'x-nyt-route': 'newsdev-gcs',
        'fastly-restarts': '1'
      },
      'responseStatusCode': 404,
      'scenarioDescription': 'Test gcs 404 cache',
      'testId': 6,
    }
  ];

  return scenarios;
}
