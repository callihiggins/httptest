var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestHeaderCookie: ['NYT-S=' + suite.cookies.nyt_s],
      requestScheme: 'https://',
      requestUri: '/crosswords/index.html',
      responseHeaderMatches: {
        'x-frame-options': 'DENY',
        'x-pagetype': 'games-web',
        'x-nyt-backend': 'games_web'
      },
      responseStatusCode: [301, 404],
      scenarioDescription:
        'Test legacy; www-apps cluster; crosswords; landing page',
      testId: '5p'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: 'https://',
      requestUri: '/crosswords/index.html',
      responseHeaderMatches: {
        'x-pagetype': 'games-web',
        'x-nyt-backend': 'games_web'
      },
      responseStatusCode: [301, 404],
      scenarioDescription:
        'Test legacy; www-apps cluster; crosswords; landing page',
      testId: '5d'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestHeaderCookie: ['NYT-S=' + suite.cookies.nyt_s],
      requestScheme: 'https://',
      requestUri: '/crosswords/archive/',
      responseHeaderMatches: {
        'x-pagetype': 'games-web',
        'x-nyt-backend': 'games_web'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www-apps cluster; crosswords; archive',
      testId: '6d'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/gift-guide/holiday-2010/categories.html',
      responseHeaderMatches: {
        'x-pagetype': 'legacy-gke',
        'x-nyt-backend': 'www_legacy_gke'
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test legacy; www-apps cluster; gift guide; 2010 holiday',
      testId: '11p'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/gift-guide/holiday-2010/categories.html',
      responseHeaderMatches: {
        'x-pagetype': 'legacy-gke',
        'x-nyt-backend': 'www_legacy_gke'
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test legacy; www-apps cluster; gift guide; 2010 holiday',
      testId: '11d'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/services/xml/rss/',
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/
      },
      responseStatusCode: [200, 404, 301],
      scenarioDescription: 'Test legacy; www-apps cluster; service; RSS XML',
      testId: '13d'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestHeaderCookie: ['NYT-S=' + suite.cookies.nyt_s],
      requestScheme: 'https://',
      requestUri: '/crosswords/archive/',
      responseHeaderMatches: {
        'x-frame-options': 'DENY',
        'x-pagetype': 'games-web',
        'x-nyt-backend': 'games_web'
      },
      responseStatusCode: [200, 404, 403],
      scenarioDescription: 'Test legacy; www-apps cluster; crosswords; archive',
      testId: '18e'
    }
  ];
  return scenarios;
}
