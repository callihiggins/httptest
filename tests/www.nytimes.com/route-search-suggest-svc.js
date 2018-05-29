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
      'id': 'FunctionalTestScenarioDefinitionForService Search Suggest',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/suggest/v1/timestags?query=foo&hello=1&bad1=2',
      'responseHeaderMatches': {
        'x-cache': 'MISS',
        'x-nyt-route': "search-suggest",
        'x-nyt-backend': "search_suggest",
        'x-nyt-final-url': '/svc/suggest/v1/timestags?query=foo'
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'route-search-suggest-svc: filter querystring',
      'testId': 1,
    },
  ];
  return scenarios;
}
