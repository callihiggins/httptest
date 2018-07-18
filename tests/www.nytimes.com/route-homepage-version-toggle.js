var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'RedirectHomescreenToggle',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestHeaderCookie: 'vi_www_hp_opt=',
      requestScheme: 'https://',
      requestUri: '/homescreen',
      responseStatusCode: [302],
      scenarioDescription: '302 redirect to homepage, sets the cookie to 0',
      responseHeaderPattern: {
        'set-cookie': /vi_www_hp_opt=0/,
        location: /\?r=([A-Za-z0-9_-]){7}/,
      },

      testId: 1
    },
    {
      id: 'RedirectHomescreenToggle',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestHeaderCookie: 'vi_www_hp_opt=1',
      requestScheme: 'https://',
      requestUri: '/homescreen',
      responseStatusCode: [302],
      scenarioDescription: '302 redirect to homepage, flips cookie from 1 to 0',
      responseHeaderPattern: {
        'set-cookie': /vi_www_hp_opt=0/,
        location: /\?r=([A-Za-z0-9_-]){7}/,
      },

      testId: 2
    },
    {
      id: 'RedirectHomescreenToggle',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestHeaderCookie: 'vi_www_hp_opt=0',
      requestScheme: 'https://',
      requestUri: '/homescreen',
      responseStatusCode: [302],
      scenarioDescription: '302 redirect to homepage, flips cookie from 0 to 1',
      responseHeaderPattern: {
        'set-cookie': /vi_www_hp_opt=1/,
        location: /\?r=([A-Za-z0-9_-]){7}/,
      },
      testId: 3
    },
  ];

  return scenarios;
}
