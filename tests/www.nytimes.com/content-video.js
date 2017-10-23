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
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': '',
      'responseHeaderMatches': {
        'X-Pagetype': 'video-library',
      },
      'requestScheme': 'https://',
      'requestUri': '/video/sciencetake',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a video library page',
      'testId': 1,
    }
  ];
  return scenarios;
}
