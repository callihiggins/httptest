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
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GP',
        'x-pagetype': 'paidpost',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'http://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
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
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/google/plan-your-next-adventure.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GP',
        'x-pagetype': 'paidpost',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GP',
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
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'http://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
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
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/google/plan-your-next-adventure.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GP',
        'x-pagetype': 'paidpost',
      },
      'responseStatusCode': [200,404,500],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 103,
    },
  ];

  return scenarios;
}
