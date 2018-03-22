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
        'x-nyt-backend': 'games_web',
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
        'x-nyt-backend': 'games_web',
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
        'x-nyt-backend': 'games_web',
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
        'x-pagetype': 'legacy',
        'x-nyt-backend': 'www_legacy_gke',
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
        'x-pagetype': 'legacy',
        'x-nyt-backend': 'www_legacy_gke',
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
         'x-api-version': /F-(GL|4a)/,
      },
      responseStatusCode: [200, 404, 301],
      scenarioDescription: 'Test legacy; www-apps cluster; service; RSS XML',
      testId: '13d'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: false,
        sbx: false
      },
      requestScheme: 'https://',
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-api-version': 'F-4a',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www-apps cluster; timeswire',
      testId: '16p'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: false,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-api-version': 'F-4a'
      },
      responseStatusCode: [200, 404, 503],
      scenarioDescription: 'Test legacy; www-apps cluster; timeswire',
      testId: '16d'
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
      requestScheme: 'http://',
      requestUri: '/style/weddings/announcements',
      responseHeaderMatches: {
        'x-api-version': 'F-4a',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test legacy; www-apps cluster; weddings; announcement',
      testId: '17p'
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
      requestScheme: 'http://',
      requestUri: '/style/weddings/announcements',
      responseHeaderMatches: {
        'x-api-version': 'F-4a'
      },
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test legacy; www-apps cluster; weddings; announcement',
      testId: '17d'
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
        'x-nyt-backend': 'games_web',
      },
      responseStatusCode: [200, 404, 403],
      scenarioDescription: 'Test legacy; www-apps cluster; crosswords; archive',
      testId: '18e'
    }
  ];
  return scenarios;
}
