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
        'x-api-version': 'F-GW',
        'x-frame-options': 'DENY',
        'x-pagetype': 'games-web'
      },
      responseStatusCode: [301, 404],
      scenarioDescription:
        'Test legacy; www-apps cluster; crosswords; landing page',
      testId: '5p'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true,
        sbx: false
      },
      requestScheme: 'https://',
      requestUri: '/crosswords/index.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GW'
      },
      responseStatusCode: [301, 404],
      scenarioDescription:
        'Test legacy; www-apps cluster; crosswords; landing page',
      testId: '5d'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true,
        sbx: false
      },
      requestHeaderCookie: ['NYT-S=' + suite.cookies.nyt_s],
      requestScheme: 'https://',
      requestUri: '/crosswords/archive/',
      responseHeaderMatches: {
        'x-api-version': 'F-GW'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www-apps cluster; crosswords; archive',
      testId: '6d'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/premium/xword/Dec1002.puz',
      responseStatusCode: [303],
      scenarioDescription:
        'Test legacy; www-apps cluster; crosswords; puzzle file',
      testId: 7
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/events',
      responseHeaderMatches: {
        'x-api-version': 'F-4a',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [301],
      scenarioDescription:
        'Test legacy; www-apps cluster; events; landing page',
      testId: '8p'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/events/theater/broadway/fiddler-on-the-roof-28978.html',
      responseHeaderMatches: {
        'x-api-version': 'F-4a',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test legacy; www-apps cluster; events; event',
      testId: '9p'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/events/venues/joyce-theater-221.html',
      responseHeaderMatches: {
        'x-api-version': 'F-4a',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test legacy; www-apps cluster; events; venue',
      testId: '10p'
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL|4a)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test legacy; www-apps cluster; gift guide; 2010 holiday',
      testId: '11p'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/gift-guide/holiday-2010/categories.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|4a)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test legacy; www-apps cluster; gift guide; 2010 holiday',
      testId: '11d'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/services/xml/rss/',
      responseHeaderPattern: {
         'x-api-version': /F-(GL|4a)/,
      },
      responseStatusCode: [200, 404],
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
      requestScheme: 'http://',
      requestUri: '/websvc/user/data.json',
      responseHeaderMatches: {
        'x-api-version': 'F-4a',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www-apps cluster; service; user data',
      testId: '14p'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/websvc/user/data.json',
      responseHeaderMatches: {
        'x-api-version': 'F-4a'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www-apps cluster; service; user data',
      testId: '14d'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/technology/personaltech/desktops/overview.html',
      responseHeaderMatches: {
        'x-api-version': 'F-4a',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www-apps cluster; technology',
      testId: '15p'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/technology/personaltech/desktops/overview.html',
      responseHeaderMatches: {
        'x-api-version': 'F-4a'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www-apps cluster; technology',
      testId: '15d'
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
        prd: false,
        stg: false,
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
      requestScheme: 'http://',
      requestUri: '/mem/email-this.html',
      responseHeaderMatches: {
        'x-api-version': 'F-4a',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www-apps cluster; email this form',
      testId: '18p'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true,
        sbx: false
      },
      requestHeaderCookie: ['NYT-S=' + suite.cookies.nyt_s],
      requestScheme: 'http://',
      requestUri: '/mem/email-this.html',
      responseHeaderMatches: {
        'x-api-version': 'F-4a'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www-apps cluster; email this form',
      testId: '18d'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true,
        sbx: false
      },
      requestHeaderCookie: ['NYT-S=' + suite.cookies.nyt_s],
      requestScheme: 'https://',
      requestUri: '/crosswords/archive/',
      responseHeaderMatches: {
        'x-api-version': 'F-GW',
        'x-frame-options': 'DENY',
        'x-pagetype': 'games-web'
      },
      responseStatusCode: [200, 404, 403],
      scenarioDescription: 'Test legacy; www-apps cluster; crosswords; archive',
      testId: '18e'
    }
  ];
  return scenarios;
}
