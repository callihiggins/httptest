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
        'stg': false,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/books/best-sellers/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'bestseller',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test bestsellers /books/best-sellers/',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/books/best-sellers/combined-print-and-e-book-fiction/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'bestseller',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test bestsellers  /books/best-sellers/combined-print-and-e-book-fiction/',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/books/best-sellers/2016/03/01/combined-print-and-e-book-fiction/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'bestseller',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test bestsellers on /books/best-sellers/2016/03/01/combined-print-and-e-book-fiction/',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/trending/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'trending',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test trending on /trending/',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/podcasts/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'podcasts',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test podcasts on /podcasts/',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/podcasts/modern-love',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'podcasts',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test podcasts on /podcasts/modern-love',
      'testId': 6,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/reviews/dining/map/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'collection',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test misc  on /reviews/dining/map/',
      'testId': 7,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/books/best-sellers/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'bestseller',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test bestsellers /books/best-sellers/',
      'testId': 101,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/books/best-sellers/combined-print-and-e-book-fiction/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'bestseller',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test bestsellers  /books/best-sellers/combined-print-and-e-book-fiction/',
      'testId': 102,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/books/best-sellers/2016/03/01/combined-print-and-e-book-fiction/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'bestseller',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test bestsellers on /books/best-sellers/2016/03/01/combined-print-and-e-book-fiction/',
      'testId': 103,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/trending/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'trending',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test trending on /trending/',
      'testId': 104,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/podcasts/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'podcasts',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test podcasts on /podcasts/',
      'testId': 105,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/podcasts/modern-love',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'podcasts',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test podcasts on /podcasts/modern-love',
      'testId': 106,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/reviews/dining/map/',
      'responseHeaderMatches': {
        'x-api-version': 'F-GM',
        'x-pagetype': 'collection',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test misc  on /reviews/dining/map/',
      'testId': 107,
    },


  ];

  return scenarios;
}
