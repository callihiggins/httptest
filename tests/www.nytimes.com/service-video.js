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
      'id':  'Functional Test For Video API',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': '',
      'responseHeaderMatches': {
        'x-pagetype': 'video-api',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/video/api/v3/video/100000002883899',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /svc/video endpoint',
      'testId': 1,
    }
  ];
  return scenarios;
}
