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
      'requestScheme': 'http://',
      'requestUri': '/save75',
      'responseHeaderMatches': {
        'x-pagetype': 'legacy',
        'x-nyt-backend': 'www',
      },
      'responseStatusCode': [301, 404],
      'scenarioDescription': 'Test legacy; vanity redirect; </save75>',
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
      'requestUri': '/save75today',
      'responseHeaderMatches': {
        'x-pagetype': 'legacy',
        'x-nyt-backend': 'www',
      },
      'responseStatusCode': [301, 404],
      'scenarioDescription': 'Test legacy; vanity redirect; </save75today>',
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
      'requestScheme': 'http://',
      'requestUri': '/save75percent',
      'responseHeaderMatches': {
        'x-pagetype': 'legacy',
        'x-nyt-backend': 'www',
      },
      'responseStatusCode': [301, 404],
      'scenarioDescription': 'Test legacy; vanity redirect; </save75percent>',
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
      'requestScheme': 'http://',
      'requestUri': '/saveonsunday',
      'responseHeaderMatches': {
        'x-pagetype': 'legacy',
        'x-nyt-backend': 'www',
      },
      'responseStatusCode': [301, 404],
      'scenarioDescription': 'Test legacy; vanity redirect; </saveonsunday>',
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
      'requestScheme': 'http://',
      'requestUri': '/savetoday',
      'responseHeaderMatches': {
        'x-pagetype': 'legacy',
        'x-nyt-backend': 'www',
      },
      'responseStatusCode': [301, 404],
      'scenarioDescription': 'Test legacy; vanity redirect; </savetoday>',
      'testId': 5,
    },
  ];

  return scenarios;
}
