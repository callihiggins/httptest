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
      },
      'requestScheme': 'https://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GP',
        'x-nyt-route': 'paidpost',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
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
      },
      'requestScheme': 'http://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'paidpost',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
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
      },
      'requestScheme': 'https://',
      'requestUri': '/google/plan-your-next-adventure.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GP',
        'x-nyt-route': 'paidpost',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/google/plan-your-next-adventure.html?gdpr=1',
      'responseHeaderMatches': {
        'x-api-version': 'F-GP',
        'x-nyt-route': 'paidpost',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GP',
        'x-nyt-route': 'paidpost',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 101,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'http://',
      'requestUri': '/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'paidpost',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
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
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/google/plan-your-next-adventure.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GP',
        'x-nyt-route': 'paidpost',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 103,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': 'nyt.dv.nyt5-on-gke=1',
      'requestScheme': 'https://',
      'requestUri': '/google/plan-your-next-adventure.html?gdpr=1',
      'responseHeaderMatches': {
        'x-api-version': 'F-GP',
        'x-nyt-route': 'paidpost',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 104,
    },
  ];

  return scenarios;
}
