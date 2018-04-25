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
      'requestHeaderCookie': 'vi_www_hp_opt=0',
      'requestScheme': 'https://',
      'requestUri': '/?abra=WP_ProjectVi_www_hp=0',
      'responseHeaderMatches': {
        'x-pagetype': 'homepage',
        'x-nyt-backend': 'homepage_fe',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test homepage vi_www_hp_opt is set to 0',
      'testId': 1,
    },
  ];

  return scenarios;
}