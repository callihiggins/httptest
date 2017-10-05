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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/by/qqq',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/column/qqq',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/issue/qqq',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/news-event/qqq',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/reviews',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/reviews/',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/reviews/dining/map/',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test reviews diningmap',
      'testId': 7,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForCollectionPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/saved',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/saved/',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/section/qqq',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/spotlight/qqq',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/topic/company/alphabet-inc',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/topic/destination/france',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/topic/organization/new-york-yankees',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/topic/person/qqq',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/topic/subject/whistleblowers',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/section/upshot',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
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
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/upshot/',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'collection',
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'Test /upshot/ redirect',
      'testId': 18,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke.collection=0',
      'requestScheme': 'https://',
      'requestUri': '/by/a-o-scott',
      'responseHeaderNotContains': {
        'Vary': 'X-Collection-Backend',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test Fastly; Collection; Vary header;',
      'testId': '19',
    }, 
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke.collection=1',
      'requestScheme': 'https://',
      'requestUri': '/by/a-o-scott',
      'responseHeaderNotContains': {
        'Vary': 'X-Collection-Backend',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test Fastly; Collection; Vary header;',
      'testId': '20',
    },    
  ];

  return scenarios;
}
