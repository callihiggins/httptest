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
      },
      'requestScheme': 'https://',
      'requestUri': '/column/qqq',
      'responseHeaderPattern': {
        'x-nyt-route': /(vi-collection|collection)/,
        'x-nyt-backend': /(projectvi_fe|collection_fe)/,
        'x-gdpr': /0/,
        'fastly-restarts': /1/,
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
      },
      'requestScheme': 'https://',
      'requestUri': '/issue/qqq',
      'responseHeaderPattern': {
        'x-nyt-route': /(vi-collection|collection)/,
        'x-nyt-backend': /(projectvi_fe|collection_fe)/,
        'x-gdpr': /0/,
        'fastly-restarts': /1/,
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
      },
      'requestScheme': 'https://',
      'requestUri': '/news-event/qqq',
      'responseHeaderPattern': {
        'x-nyt-route': /(vi-collection|collection)/,
        'x-nyt-backend': /(projectvi_fe|collection_fe)/,
        'x-gdpr': /0/,
        'fastly-restarts': /1/,
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
      },
      'requestScheme': 'https://',
      'requestUri': '/section/qqq?gdpr=1',
      'responseHeaderPattern': {
        'x-nyt-route': /(vi-collection|collection)/,
        'x-nyt-backend': /(projectvi_fe|collection_fe)/,
        'x-gdpr': /1/,
        'fastly-restarts': /1/,
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
      },
      'requestScheme': 'https://',
      'requestUri': '/spotlight/qqq',
      'responseHeaderPattern': {
        'x-nyt-route': /(vi-collection|collection)/,
        'x-nyt-backend': /(projectvi_fe|collection_fe)/,
        'x-gdpr': /0/,
        'fastly-restarts': /1/,
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
      },
      'requestScheme': 'https://',
      'requestUri': '/section/upshot',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-collection',
        'x-nyt-backend': 'projectvi_fe',
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
        'stg': false,
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/column/modern-love?gdpr=1',
      'responseHeaderPattern': {
        'x-nyt-route': /(vi-collection|collection)/,
        'x-nyt-backend': /(projectvi_fe|collection_fe)/,
        'x-gdpr': /1/,
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test Fastly; Collection; secure; publish; 4kb cookie string ',
      'testId': '201',
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/column/modern-love?gdpr=1',
      'responseHeaderPattern': {
        'x-nyt-route': /(vi-collection|collection)/,
        'x-nyt-backend': /(projectvi_fe|collection_fe)/,
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404,500,503],
      'scenarioDescription': 'Test Fastly; Collection; secure; publish; Dev/Stg /column/modern-love',
      'testId': '202',
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': false,
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
      'responseStatusCode': [200,404,500,503],
      'scenarioDescription': 'Test Fastly; Collection; secure; publish; Dev/Stg /column/road-trip',
      'testId': 205,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/column/diagnosis',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-collection',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Production Test /column/diagnosis collection',
      'testId': 206,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/column/36-hours',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-collection',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Production Test /column/36-hours collection',
      'testId': 207,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/section/business',
      'responseHeaderPattern': {
        'x-nyt-route': /(vi-collection|collection)/,
        'x-nyt-backend': /(projectvi_fe|collection_fe)/,
        'x-gdpr': /0/,
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404,500,503],
      'scenarioDescription': 'Dev/Staging test /section/business collection fallback to NYT5',
      'testId': 208,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/section/business',
      'responseHeaderPattern': {
        'x-nyt-route': /(vi-collection|collection)/,
        'x-nyt-backend': /(projectvi_fe|collection_fe)/,
        'x-gdpr': /0/,
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Prod test /section/business collection fallback to NYT5',
      'testId': 209,
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        prd: true,
        stg: true,
        dev: true
      },
      'requestScheme': 'https://',
      'requestUri': '/section/business',
      'method': 'POST',
      'responseStatusCode': [405],
      'scenarioDescription': 'POST method requests are not allowed for collection route',
      'testId': 220
    },
    {
      id: 'FunctionalTestScenarioDefinitionForDiningReviewPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/reviews/dining',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-collection',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode':  [200, 404],
      'scenarioDescription': 'Test /reviews/dining collection',
      'testId': 221,
    },    
  ];

  return scenarios;
}
