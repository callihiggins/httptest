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
      'requestHeaders': {
        'Host': 'paidpost.nytimes.com',
      },
      'requestScheme': 'https://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'paidpost',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
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
      'requestHeaders': {
        'Host': 'paidpost.nytimes.com',
      },
      'requestScheme': 'http://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'location': 'https://paidpost.nytimes.com/mexico-tourism/my-journey-to-mexico.html',
        'x-pagetype': 'paidpost',
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'Test HTTPS; paidpost; non-secure',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'Host': 'paidpost.nytimes.com',
      },
      'requestScheme': 'https://',
      'requestUri': '/google/plan-your-next-adventure.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'paidpost',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'Host': 'paidpost.stg.nytimes.com',
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=0',
      'requestScheme': 'https://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'paidpost',
      },
      'responseStatusCode': [200,404,500],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 101,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'Host': 'paidpost.nytimes.com',
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'http://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'location': 'https://paidpost.nytimes.com/mexico-tourism/my-journey-to-mexico.html',
        'x-pagetype': 'paidpost',
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'Test HTTPS; paidpost; non-secure',
      'testId': 102,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=0',
      'requestHeaders': {
        'Host': 'paidpost.nytimes.com',
      },
      'requestScheme': 'https://',
      'requestUri': '/google/plan-your-next-adventure.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'paidpost',
      },
      'responseStatusCode': [200,404,500],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 3,
    },
  ];

  return scenarios;
}
