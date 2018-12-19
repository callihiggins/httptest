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
      'id': 'Functional Test For Games',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-service',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/games/set/v1/puzzles.json',
      'responseHeadersPresent': [
        'x-gdpr',
      ],
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /svc/games endpoint',
      'testId': 1,
    },
    {
      'id': 'Functional Test For Crosswords',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-service',
      },
      'responseHeadersPresent': [
        'x-gdpr',
      ],
      'requestScheme': 'https://',
      'requestUri': '/svc/crosswords/v2/puzzle/1.json',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /svc/crosswords endpoint',
      'testId': 2,
    },
    {
      'id': 'Functional Test For Crosswords',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'responseHeadersPresent': [
        'x-gdpr',
      ],
      'requestScheme': 'https://',
      'requestUri': '/crosswords/game/daily',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /crosswords/game/daily web app with games-web backend',
      'testId': 3,
    },
    {
      'id': 'Functional Test For Crosswords',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/game/mini',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /crosswords/game/mini web app with games-web backend',
      'testId': 4,
    },
    {
      'id': 'Functional Test For Crosswords',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'requestScheme': 'http://',
      'requestUri': '/crosswords/game/mini',
      'responseStatusCode': 301,
      'scenarioDescription': 'Test redirect to https for /crosswords/game/mini web app',
      'testId': 5,
    },
    {
      'id': 'Functional Test For Crosswords',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/game/variety',
      'responseStatusCode': 404,
      'scenarioDescription': 'Test hitting a /crosswords/game/variety web app with games-web backend',
      'testId': 6,
    },
    {
      'id': 'Functional Test For Crosswords',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'games-assets',
        'x-nyt-backend': 'gcs_origin'
      },
      'requestScheme': 'https://',
      'requestUri': '/games-assets/favicon.ico',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /games-assets/favicon.ico with gcs backend',
      'testId': 7,
    },
    {
      'id': 'Functional Test For Games Prototype Staging',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-service',
      },
      'requestScheme': 'https://',
      'requestUri': '/games/prototype/kenken',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /games/prototype endpoint',
      'testId': 8,
    },
    {
      'id': 'Functional Test For Games Prototype Production',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-service',
      },
      'requestScheme': 'https://',
      'requestUri': '/games/prototype/kenken',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /games/prototype endpoint',
      'testId': 9,
    },
    {
      'id': 'Functional Test For Games Hub Routing',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /crosswords endpoint',
      'testId': 10,
    },
    {
      'id': 'Functional Test For Games Submission page',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/submissions',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /crosswords/submissions endpoint',
      'testId': 11,
    },
    {
      'id': 'Functional Test For Sudoku',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/game/sudoku/easy',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting Sudoku Easy page',
      'testId': 13,
    },
    {
      'id': 'Functional Test For KenKen',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/game/kenken',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting KenKen page',
      'testId': 14,
    },
    {
      'id': 'Functional Test For Set',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/game/set',
      'responseStatusCode': 301,
      'scenarioDescription': 'Test redirect to Set page',
      'testId': 15,
    },
    {
      'id': 'Functional Test For Archive Daily',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/archive/daily',
      'responseStatusCode': [403,200],
      'scenarioDescription': 'Test hitting Archive Daily page',
      'testId': 16,
    },
    {
      'id': 'Functional Test For Tips and Tricks',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/tips-and-tricks',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting Tips and Tricks page',
      'testId': 17,
    },
    {
      'id': 'Functional Test For Acrostic',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/game/acrostic/2017/09/03',
      'responseStatusCode': 301,
      'scenarioDescription': 'Test redirect to Acrostic page',
      'testId': 18,
    },
    {
      'id': 'Functional Test Stats Page',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/stats',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting Stats page',
      'testId': 19,
    },
    {
      'id': 'Functional Test For Archive Daily',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/archive/daily',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting Archive Daily page',
      'testId': 20,
    },
    {
      'id': 'Functional Test For Archive Daily',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/archive/daily',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting Archive Daily page',
      'testId': 20,
    },
    {
      'id': 'Functional Test For Primer',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/primer',
      'responseStatusCode': 301,
      'scenarioDescription': 'Test hitting Primer page',
      'testId': 21,
    },
    {
      'id': 'Functional Test For Spelling Bee',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-phoenix',
      },
      'requestScheme': 'https://',
      'requestUri': '/puzzles/spelling-bee',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting Spelling Bee page',
      'testId': 22,
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestHeaderCookie: ['NYT-S=' + suite.cookies.nyt_s],
      requestScheme: 'https://',
      requestUri: '/crosswords/index.html',
      responseHeaderMatches: {
        'x-frame-options': 'DENY',
        'x-nyt-route': 'games-web',
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
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/crosswords/index.html',
      responseHeaderMatches: {
        'x-nyt-route': 'games-web',
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
        dev: true
      },
      requestHeaderCookie: ['NYT-S=' + suite.cookies.nyt_s],
      requestScheme: 'https://',
      requestUri: '/crosswords/archive/',
      responseHeaderMatches: {
        'x-nyt-route': 'games-web',
        'x-nyt-backend': 'games_web'
      },
      responseStatusCode: [200, 403, 404],
      scenarioDescription: 'Test legacy; www-apps cluster; crosswords; archive',
      testId: '6d'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/gift-guide/holiday-2010/categories.html',
      responseHeaderMatches: {
        'x-nyt-route': 'legacy-gke',
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
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/gift-guide/holiday-2010/categories.html',
      responseHeaderMatches: {
        'x-nyt-route': 'legacy-gke',
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
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/services/xml/rss/',
      responseHeaderMatches: {
        'x-nyt-route': 'legacy-gke',
        'x-nyt-backend': 'www_legacy_gke'
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
        dev: true
      },
      requestHeaderCookie: ['NYT-S=' + suite.cookies.nyt_s],
      requestScheme: 'https://',
      requestUri: '/crosswords/archive/',
      responseHeaderMatches: {
        'x-frame-options': 'DENY',
        'x-nyt-route': 'games-web',
        'x-nyt-backend': 'games_web'
      },
      responseStatusCode: [200, 404, 403],
      scenarioDescription: 'Test legacy; www-apps cluster; crosswords; archive',
      testId: '18e'
    },
    {
      'id': 'Functional Test For Set',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s_games,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-phoenix',
      },
      'requestScheme': 'https://',
      'requestUri': '/puzzles/set',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting Set page',
      'testId': 19,
    },
    {
      'id': 'Functional Test For Acrostic',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s,
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'games-phoenix',
      },
      'requestScheme': 'https://',
      'requestUri': '/puzzles/acrostic/2017/09/03',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting Acrostic page',
      'testId': 20,
    }
  ];

  return scenarios;
}
