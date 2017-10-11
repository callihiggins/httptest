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
      'id': 'FunctionalTestScenarioDefinitionForStaticS3Page',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/london2012',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-gcs',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/london2012/schedule',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-gcs',
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
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/london2012/navigation.json',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-gcs',
        'content-type': 'application/json',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test static json pages hosted on gs://nytint-' + suite.env + '-www',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForStaticS3PageRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/crime',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-gcs',
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
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'Host': suite.servername,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/crime/homicides/map',
      'responseHeaderMatches': {
        'cache-control': 'public, max-age=86400',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test gcs cache response',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForGCSPage404Cache',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/page-that-does-not-exist',
      'responseHeadersNotPresent': [
        'cache-control'
      ],
      'responseStatusCode': 404,
      'scenarioDescription': 'Test gcs 404 cache',
      'testId': 6,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForGCSPageConversationPiecesRouting',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/projects/cp/awards-season/emmys-2015/uzo-aduba-thanks-those-who-let-her-be-herself',
      'responseHeaderMatches': {
        'x-pagetype': 'newsdev-gcs',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test gcs conversation pieces routing',
      'testId': 7,
    },
  ];

  return scenarios;
}
