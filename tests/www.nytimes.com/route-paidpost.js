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
      'requestUri': '/paidpost/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-paidpost',
        'x-nyt-backend': 'projectvi_fe',
        'x-frame-options': 'DENY',
        'x-gdpr': '0',
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
      'requestHeaders': {
        'Referer': 'https://media.insightexpress.com/foo/bar',
      },
      'requestScheme': 'https://',
      'requestUri': '/paidpost/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-paidpost',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
      },
      'responseHeadersNotPresent': [
          'x-frame-options'
      ],
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test missing x-frame-options with whitelisted referer',
      'testId': 2,
    },
  ];

  return scenarios;
}
