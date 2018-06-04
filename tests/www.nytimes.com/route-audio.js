var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForAudioRouteStg',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/audio/2017/06/28/arts/artsspecial/28-June-21909.html',
      responseHeaderMatches: {
        'x-nyt-route': 'audio',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test /audio/ is served from vi',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForAudioRoutePrd',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestScheme: 'https://',
      requestUri: '/audio/2018/04/09/podcasts/09DAILY-audio.html',
      responseHeaderMatches: {
        'x-nyt-route': 'audio',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test /audio/ is served from vi',
      testId: 1
    },
  ];

  return scenarios;
}
