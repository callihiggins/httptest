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
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': '',
      'responseHeaderMatches': {
        'X-Pagetype': 'video-api',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/video/api/v3/video/100000005022783',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /svc/video endpoint',
      'testId': 1,
    }
  ];
  return scenarios;
}
