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
      'id': 'Watching Homepage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestUri': '/watching',
      'responseHeaderMatches': {
        'x-nyt-backend': 'beta_watching',
        'x-api-version': 'F-W2',
        'x-nyt-route': 'watching',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test Watching; canonical landing page',
      'testId': 1,
    },
    {
      'id': 'Watching Homepage redirect to https',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestScheme': 'http://',
      'requestUri': '/watching',
      'responseHeaderMatches': {
        'x-nyt-backend': 'beta_watching',
        'x-api-version': 'F-W2',
        'x-nyt-route': 'watching',
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test Watching; redirect from https to http',
      'testId': 2,
    },
    {
      'id': 'Watching page with article URL pattern',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/11/11/watching/moonlight-netflix-medicine-for-melancholy.html',
      'responseHeaderMatches': {
        'backend': 'gae',
        'x-api-version': 'F-W2',
        'x-nyt-route': 'watching',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test Watching; article URL',
      'testId': 4,
    },
    {
      'id': 'Watching recommendations URL',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestUri': '/watching/recommendations/watching-film-broadcast-news',
      'responseHeaderMatches': {
        'backend': 'gae',
        'x-api-version': 'F-W2',
        'x-nyt-route': 'watching',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test Watching; recommendations URL',
      'testId': 5,
    },
    {
      'id': 'Watching multi-recommendations URL with query param',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestUri': '/watching/api/recommendations?ids[]=100000004539144&test=hello&bad1=1',
      'responseHeaderMatches': {
        'backend': 'gae',
        'x-api-version': 'F-W2',
        'x-nyt-route': 'watching',
        'x-nyt-final-url': '/watching/api/recommendations?ids[]=100000004539144',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test Watching; multi-recommendations URL with query param',
      'testId': 6,
    },
    {
      'id': 'Watching recommendations URL without query param',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestUri': '/watching/api/recommendations',
      'responseHeaderMatches': {
        'backend': 'gae',
        'x-api-version': 'F-W2',
        'x-nyt-route': 'watching',
      },
      'responseStatusCode': 400,
      'scenarioDescription': 'Test Watching; multi-recommendations URL without query param',
      'testId': 7,
    },
  ];

  return scenarios;
}
