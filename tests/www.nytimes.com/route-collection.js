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
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/by/qqq',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test /by collection',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/column/qqq',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test /column collection',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/issue/qqq',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test /issue collection',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/news-event/qqq',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test /news-event collection',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/reviews',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test /reviews collection',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/reviews/?gdpr=1',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200, 301, 404],
      'scenarioDescription': 'Test /reviews/ redirect',
      'testId': 6,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/reviews/dining/map/',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'misc_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test reviews diningmap',
      'testId': 7,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/saved',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test /saved collection',
      'testId': 8,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/saved/',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'Test /saved/ redirect',
      'testId': 9,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/section/qqq?gdpr=1',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test /section collection',
      'testId': 10,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/spotlight/qqq',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test /spotlight collection',
      'testId': 11,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/topic/company/alphabet-inc',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test /topic/company collection',
      'testId': 12,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/topic/destination/france',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test /topic/destination collection',
      'testId': 13,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/topic/organization/new-york-yankees',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test /topic/organization collection',
      'testId': 14,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/topic/person/qqq',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test /topic/person collection',
      'testId': 15,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/topic/subject/whistleblowers',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test /topic/subject collection',
      'testId': 16,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/section/upshot',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test /section/upshot collection',
      'testId': 17,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/upshot/',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'Test /upshot/ redirect',
      'testId': 18,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': suite.cookies.is_4k,
      'requestScheme': 'https://',
      'requestUri': '/column/modern-love?gdpr=1',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test Fastly; Collection; secure; publish; 4kb cookie string ',
      'testId': '201',
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': suite.cookies.is_8k,
      'requestScheme': 'https://',
      'requestUri': '/column/modern-love',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test Fastly; Collection; secure; publish; 8kb cookie string ',
      'testId': '202',
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': suite.cookies.is_12k,
      'requestScheme': 'https://',
      'requestUri': '/column/modern-love',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test Fastly; Collection; secure; publish; 12kb cookie string ',
      'testId': '203',
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': suite.cookies.is_16k,
      'requestScheme': 'https://',
      'requestUri': '/column/modern-love',
      'responseHeaderMatches': {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test Fastly; Collection; secure; publish; 16kb cookie string ',
      'testId': '204',
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/column/road-trip',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-collection',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test /column/road-trip collection',
      'testId': 205,
    },
  ];

  return scenarios;
}
