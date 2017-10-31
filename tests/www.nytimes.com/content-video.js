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
      'id':  'Functional Test For Video Library',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': '',
      'responseHeaderMatches': {
        'x-pagetype': 'video-library',
      },
      'requestScheme': 'https://',
      'requestUri': '/video/sciencetake',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a video library page',
      'testId': 1,
    },
    {
      'id':  'Functional Test For Video Library Homepage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': '',
      'responseHeaderMatches': {
        'x-pagetype': 'video-library',
      },
      'requestScheme': 'https://',
      'requestUri': '/video?param=1',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting the library homepage with a query string at the end',
      'testId': 2,
    }
  ];
  return scenarios;
}
