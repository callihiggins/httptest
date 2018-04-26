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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri:
        '/2016/11/04/homepage/new-york-times-open-access-election-2016.html',
      responseHeaderPattern: {
        'x-nyt-route': /(article|vi-story)/,
        'x-nyt-backend': /(article_fe|projectvi_fe)/
      },
      responseHeaderMatches: {
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri:
        '/2004/01/09/us/2004-campaign-fund-raising-financial-firms-are-bush-s-biggest-donors-study.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri:
        '/2005/03/01/business/worldbusiness/chinas-oil-diplomacy-in-latin-america.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri:
        '/1959/01/11/archives/sports-of-the-times-forecast-for-1959.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /1959/01/11/archives/sports-of-the-times-forecast-for-1959.html',
      testId: 4
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri:
        '/1964/01/01/mexico-tightens-control-of-semipublic-concerns.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri:
        '/1979/01/01/archives/carolyn-spiro-married-to-gregory-j-cannata.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri: '/2001/01/20/technology/20ANNIVERSARY.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri:
        '/2001/01/20/technology/the-new-york-times-five-years-on-the-web.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
        'x-nyt-backend': "article_fe",
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /2001/01/20/technology/the-new-york-times-five-years-on-the-web.html',
      testId: 8
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri: '/2006/01/29/fashion/sundaystyles/29LOVE.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri: '/2006/02/26/fashion/sundaystyles/26LOVE.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri: '/2006/11/12/fashion/12love.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'http://',
      requestUri: '/blog/2000/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri: '/1850/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri: '/1979/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri: '/1981/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-route': 'article',
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri: '/1995/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri:
        '/2013/11/04/theater/reviews/taymors-midsummer-nights-dream-opens-brooklyn-theater.html',
      responseHeaderMatches: {
        'x-cache': 'MISS',
        'x-nyt-backend': "article_fe",
        'x-nyt-route': 'article',
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /2013/11/04/theater/reviews/taymors-midsummer-nights-dream-opens-brooklyn-theater.html',
      testId: 17
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri: '/2013/06/16/travel/travel-guide-new-york-for-kids.html',
      responseHeaderMatches: {
        'x-cache': 'MISS',
        'x-nyt-backend': "article_fe",
        'x-nyt-route': 'article',
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test routing; article; NYT5; ensure Fastly pass; /2013/06/16/travel/travel-guide-new-york-for-kids.html',
      testId: 168
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
      },
      requestScheme: 'https://',
      requestUri: '/1981/01/03/nyregion/uso-in-times-square.html',
      responseHeaderMatches: {
        'x-cache': 'MISS',
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
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
      requestHeaderCookie: ['vi_www_hp=z0', 'vi_www_hp_opt=0'],
      requestHeaders: {
        authorization: 'Basic ThisShouldCauseAFastlyPass'
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
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
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
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestHeaderCookie': [
        'vistory=',
      ],
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
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
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[a][012][0-9];/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'abra set story VI cookie using query param',
      'testId': 52,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[z][012][0-9];/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'abra unset story VI cookie using query param',
      'testId': 53,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with no fancy header stuff. Allocated',
      'testId': 54,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with no fancy header stuff. Not Allocated',
      'testId': 55,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/02/23/learning/oak-style-guide.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'OAK article served by VI. Allocated',
      'testId': 56,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/02/23/learning/oak-style-guide.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
        'fastly-restarts': '1',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'OAK article still served by VI. Not Allocated',
      'testId': 57,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/test.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'fastly-restarts': /1/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with compatibility issues. Allocated',
      'testId': 58,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/test.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with compatibility issues. Not Allocated',
      'testId': 59,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2013/10/24/arts/music/christian-mcbride-trio-at-dizzys-club-coca-cola.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with no fancy header. Allocated',
      'testId': 60,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2013/10/24/arts/music/christian-mcbride-trio-at-dizzys-club-coca-cola.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with no fancy header. Not Allocated',
      'testId': 61,
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
      'requestUri': '/2017/02/16/opinion/paul-krugman-with-column-assignment.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test routing; opinion article; Always served by VI. Allocated',
      'testId': 62,
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
      'requestUri': '/2017/02/16/opinion/paul-krugman-with-column-assignment.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test routing; opinion article; Always served by VI. Not Allocated',
      'testId': 63,
    },

    // Production

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/07/14/science/sun-cycles-solar-maximum-minimum-corona.html',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
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
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestHeaderCookie': [
        'vistory=',
      ],
      'requestScheme': 'https://',
      'requestUri': '/2017/07/14/science/sun-cycles-solar-maximum-minimum-corona.html',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
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
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/07/14/science/sun-cycles-solar-maximum-minimum-corona.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[a][012][0-9];/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'abra set story VI cookie using query param',
      'testId': 300,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/07/14/science/sun-cycles-solar-maximum-minimum-corona.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[z][012][0-9];/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'abra unset story VI cookie using query param',
      'testId': 400,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/15/nyregion/harvey-weinstein-new-york-sex-assault-investigation.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with no fancy header stuff. Allocated',
      'testId': 500,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/15/nyregion/harvey-weinstein-new-york-sex-assault-investigation.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with no fancy header stuff. Not Allocated',
      'testId': 600,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/08/26/arts/things-to-do-in-new-york-metropolitan-museum-flume.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'OAK article served by VI. Allocated',
      'testId': 700,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/08/26/arts/things-to-do-in-new-york-metropolitan-museum-flume.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
        'fastly-restarts': '1',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'OAK article still served by VI. Not Allocated',
      'testId': 800,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2018/01/30/us/politics/trump-state-of-the-union.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'fastly-restarts': /1/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with compatibility issues. Allocated',
      'testId': 900,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/11/theater/denise-gough-st-anns-warehouse-angels-in-america.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with compatibility issues. Not Allocated',
      'testId': 1000,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2013/06/25/sports/tennis/tough-first-day-at-wimbledon-for-us-women-despite-stephens-win.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with no fancy header. Allocated',
      'testId': 1100,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2013/06/25/sports/tennis/tough-first-day-at-wimbledon-for-us-women-despite-stephens-win.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with no fancy header. Not Allocated',
      'testId': 1200,
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
      'requestUri': '/2018/03/02/opinion/dicks-guns-walmart.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test routing; opinion article; Always served by VI. Allocated',
      'testId': 1300,
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
      'requestUri': '/2018/03/02/opinion/dicks-guns-walmart.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderContains': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test routing; opinion article; Always served by VI. Not Allocated',
      'testId': 1400,
    },
  ];

  return scenarios;
}
