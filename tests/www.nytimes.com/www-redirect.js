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
        dev: true,
        sbx: false
      },
      requestHeaderCookie: 'vi_www_hp_opt=',
      requestScheme: 'https://',
      requestUri: '/homescreen',
      responseStatusCode: [302],
      scenarioDescription: '302 redirect to homepage, sets the cookie to 0',
      responseHeaderPattern: {
        location: /https:\/\/www.nytimes.com/,
        'set-cookie': /vi_www_hp_opt=0/
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
        location: /https:\/\/www.nytimes.com/,
        'set-cookie': /vi_www_hp_opt=0/
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
        location: /https:\/\/www.nytimes.com/,
        'set-cookie': /vi_www_hp_opt=1/
      },
      testId: 3
    },
    {
      id: 'RedirectHomescreenToggle',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/2017/09/24/theater/slug.amp.html',
      responseStatusCode: [301],
      scenarioDescription: '301 redirect WWW AMP to WWW Canonical',
      responseHeaderMatches: {
        location: 'https://' + suite.hosts.www + '/2017/09/24/theater/slug.html'
      },
      testId: 4
    }
  ];

  return scenarios;
}
