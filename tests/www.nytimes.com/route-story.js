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
        dev: true
      },
      requestScheme: 'https://',
      requestUri:
        '/2016/11/04/homepage/new-york-times-open-access-election-2016.html',
      responseHeaderPattern: {
        'x-nyt-route': /(article|vi-story)/,
        'x-nyt-backend': /(article_fe|projectvi_fe)/,
      },
      responseStatusCode: [200, 404],
      scenarioDescription:
        'content-article: NYT5; ensure Fastly pass; /2016/11/04/homepage/new-york-times-open-access-election-2016.html',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri:
        '/2004/01/09/us/2004-campaign-fund-raising-financial-firms-are-bush-s-biggest-donors-study.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'content-article: NYT5; ensure Fastly pass; /2004/01/09/us/2004-campaign-fund-raising-financial-firms-are-bush-s-biggest-donors-study.html',
      testId: 2
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri:
        '/2005/03/01/business/worldbusiness/chinas-oil-diplomacy-in-latin-america.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /2005/03/01/business/worldbusiness/chinas-oil-diplomacy-in-latin-america.html',
      testId: 3
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri:
        '/1959/01/11/archives/sports-of-the-times-forecast-for-1959.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /1959/01/11/archives/sports-of-the-times-forecast-for-1959.html',
      testId: 4
    },
    {
      id: 'FunctionalTestScenarsioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri:
        '/1964/01/01/mexico-tightens-control-of-semipublic-concerns.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /1964/01/01/mexico-tightens-control-of-semipublic-concerns.html',
      testId: 5
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri:
        '/1979/01/01/archives/carolyn-spiro-married-to-gregory-j-cannata.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /1979/01/01/archives/carolyn-spiro-married-to-gregory-j-cannata.html',
      testId: 6
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/2001/01/20/technology/20ANNIVERSARY.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; redirect; /2001/01/20/technology/20ANNIVERSARY.html',
      testId: 7
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri:
        '/2004/01/09/us/2004-campaign-fund-raising-financial-firms-are-bush-s-biggest-donors-study.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /2004/01/09/us/2004-campaign-fund-raising-financial-firms-are-bush-s-biggest-donors-study.html',
      testId: 8
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/2006/01/29/fashion/sundaystyles/29LOVE.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /2006/01/29/fashion/sundaystyles/29LOVE.html',
      testId: 9
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/2006/02/26/fashion/sundaystyles/26LOVE.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /2006/02/26/fashion/sundaystyles/26LOVE.html',
      testId: 10
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/2006/11/12/fashion/12love.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /2006/11/12/fashion/12love.html',
      testId: 11
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/blog/2000/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; blogpost as article; /blog/2000/01/01/us/slug.html',
      testId: 12
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/1850/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /1850/01/01/us/slug.html',
      testId: 13
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/1979/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /1979/01/01/us/slug.html',
      testId: 14
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/1981/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /1981/01/01/us/slug.html',
      testId: 15
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/1995/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-backend': "article_fe",
        'x-nyt-route': "article",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /1995/01/01/us/slug.html',
      testId: 16
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri:
        '/2013/11/04/theater/reviews/taymors-midsummer-nights-dream-opens-brooklyn-theater.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story'
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; VI; ensure Fastly pass; /2013/11/04/theater/reviews/taymors-midsummer-nights-dream-opens-brooklyn-theater.html',
      testId: 17
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/2013/06/16/travel/travel-guide-new-york-for-kids.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story'
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; VI; ensure Fastly pass; /2013/06/16/travel/travel-guide-new-york-for-kids.html',
      testId: 168
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/1981/01/03/nyregion/uso-in-times-square.html',
      responseHeaderMatches: {
        'x-nyt-backend': "article_fe",
        'x-nyt-route': 'article',
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /1981/01/03/nyregion/uso-in-times-square.html',
      testId: 19
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri:
        '/1996/01/22/business/the-new-york-times-introduces-a-web-site.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article'
      },
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test routing; article; NYT5 GKE; ensure Fastly pass; /1996/01/22/business/the-new-york-times-introduces-a-web-site.html',
      testId: 20
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/2006/11/12/fashion/12love.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article'
      },
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test routing; article; NYT5 GKe; ensure Fastly pass; /2006/11/12/fashion/12love.html',
      testId: 21
    },

    // staging vi alloc

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseHeaderPattern': {
        'set-cookie': /^((?!vistory).)*$/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'No vistory cookie',
      'testId': 50,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestHeaderCookie': [
        'vistory=',
      ],
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story'
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Empty vistory cookie',
      'testId': 51,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html',
      'responseStatusCode': [200],
      'scenarioDescription': 'abra set story VI cookie using query param',
      'testId': 52,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html',
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with no fancy header stuff.',
      'testId': 54,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/02/23/learning/oak-style-guide.html',
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'OAK article served by VI.',
      'testId': 56,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/06/10/world/asia/japan-summons-chinese-envoy-after-naval-ship-nears-disputed-islands.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-story',
        'x-nyt-backend': 'projectvi_fe',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with compatibility issues.',
      'testId': 58,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2013/10/24/arts/music/christian-mcbride-trio-at-dizzys-club-coca-cola.html',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story'
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Vi article; Non-OAK outside correct date range with no fancy header.',
      'testId': 60,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/02/16/opinion/paul-krugman-with-column-assignment.html',
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test routing; opinion article; Always served by VI.',
      'testId': 62,
    },

    // Production

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/07/14/science/sun-cycles-solar-maximum-minimum-corona.html',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story'
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'No vistory cookie',
      'testId': 100,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestHeaderCookie': [
        'vistory=',
      ],
      'requestScheme': 'https://',
      'requestUri': '/2017/07/14/science/sun-cycles-solar-maximum-minimum-corona.html',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story'
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Empty vistory cookie',
      'testId': 200,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/07/14/science/sun-cycles-solar-maximum-minimum-corona.html',
      'responseStatusCode': [200],
      'scenarioDescription': 'abra set story VI cookie using query param',
      'testId': 300,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/15/nyregion/harvey-weinstein-new-york-sex-assault-investigation.html',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with no fancy header stuff.',
      'testId': 500,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/08/26/arts/things-to-do-in-new-york-metropolitan-museum-flume.html',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'OAK article served by VI.',
      'testId': 700,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2018/01/30/us/politics/trump-state-of-the-union.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-story',
        'x-nyt-backend': 'projectvi_fe',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with no compatibility issues.',
      'testId': 900,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2013/06/25/sports/tennis/tough-first-day-at-wimbledon-for-us-women-despite-stephens-win.html',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story'
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with no fancy header.',
      'testId': 1100,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2018/03/02/opinion/dicks-guns-walmart.html',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test routing; opinion article; Always served by VI.',
      'testId': 1300,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/02/16/opinion/paul-krugman-with-column-assignment.html?ip-override=137.99.78.82',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-us=1;/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Set cookie with value of 1 for US users for US-only views on dev & stg.',
      'testId': 1500,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/02/16/opinion/paul-krugman-with-column-assignment.html?ip-override=85.90.227.224',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-us=0;/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Set cookie with value of 0 for non-US users on dev & stg.',
      'testId': 1600,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/2018/05/21/opinion/supreme-court-arbitration-forced.html?ip-override=137.99.78.82',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-us=1;/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Set cookie with value of 1 for US users for US-only views on prd.',
      'testId': 1500,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/2018/05/21/opinion/supreme-court-arbitration-forced.html?ip-override=85.90.227.224',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-us=0;/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Set cookie with value of 0 for non-US users on prd.',
      'testId': 1600,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/2018/05/21/opinion/supreme-court-arbitration-forced.html?ip-override=158.97.227.224',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-geo=MX;/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Set cookie with value of MX for Mexico users on prd.',
      'testId': 1600,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/2018/05/21/opinion/supreme-court-arbitration-forced.html?ip-override=185.112.249.184',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-geo=GB;/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Set cookie with value of UK for United Kingdom users on prd.',
      'testId': 1600,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/2018/05/21/opinion/supreme-court-arbitration-forced.html?ip-override=39.109.210.210',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-geo=SG;/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Set cookie with value of SG for Singapore users on prd.',
      'testId': 1600,
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        prd: true,
        stg: true,
        dev: true
      },
      'requestScheme': 'https://',
      'requestUri': '/2013/06/16/travel/travel-guide-new-york-for-kids.html',
      'method': 'POST',
      'responseStatusCode': [405],
      'scenarioDescription': 'POST method requests are not allowed for story route',
      'testId': 1700
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/es/2018/09/20/espanol/america-latina/a-tu-resumen-de-noticias-del-jueves.html',
      method: 'GET',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-story',
        'x-nyt-backend': "projectvi_fe",
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi Internationalized URL /es',
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/es/2018/09/20/espanol/america-latina/a-tu-resumen-de-noticias-del-jueves.html?test=value',
      method: 'GET',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-story',
        'x-nyt-backend': "projectvi_fe",
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi internationalized URL /es with query params',
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/es/interactive/2018/09/20/universal/test-spanish-interactive.html',
      method: 'GET',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-story',
        'x-nyt-backend': "projectvi_fe",
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi internationalized interactive URL /es',
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/zh-hans/2018/08/15/universal/03china-coffins-hans.html',
      method: 'GET',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-story',
        'x-nyt-backend': "projectvi_fe",
      },
      responseStatusCode: [200],
      scenarioDescription: 'Vi internationalized URL /zh-hans',
    },
  ];

  return scenarios;
}
