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
      },
      requestScheme: 'http://',
      requestUri: '/',
      responseHeaderMatches: {
        location: 'https://' + suite.servername + '/'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; homepage (phase 1); non-secure',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/',
      responseStatusCode: 200,
      scenarioDescription: 'Test HTTPS Everywhere; homepage (phase 1); secure',
      testId: 2
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/2014/01/01/world/test-suite.html',
      responseHeaderMatches: {
        location:
          'https://' + suite.servername + '/2014/01/01/world/test-suite.html'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; 2014 article (phase 1); non-secure',
      testId: 3
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/2014/01/01/world/test-suite.html',
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test HTTPS Everywhere; 2014 article (phase 1); secure',
      testId: 4
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/2013/01/01/world/test-suite.html',
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test HTTPS Everywhere; 2013 article; non-secure',
      testId: 5
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/2013/01/01/world/test-suite.html',
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test HTTPS Everywhere; 2013 article; secure',
      testId: 6
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/section/sports',
      responseHeaderMatches: {
        location: 'https://' + suite.servername + '/section/sports'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; collection (phase 1); non-secure',
      testId: 7
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/section/sports',
      responseStatusCode: 200,
      scenarioDescription:
        'Test HTTPS Everywhere; collection (phase 1); secure',
      testId: 8
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/video',
      responseHeaderMatches: {
        location: 'https://' + suite.servername + '/video'
      },
      responseStatusCode: 301,
      scenarioDescription: 'Test HTTPS Everywhere; video (phase 1); non-secure',
      testId: 9
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/video',
      responseStatusCode: 200,
      scenarioDescription: 'Test HTTPS Everywhere; video (phase 1); secure',
      testId: 10
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestHeaders: {
        Host: 'cityroom.blogs.nytimes.com'
      },
      requestScheme: 'http://',
      requestUri: '/',
      responseHeaderMatches: {
        location: 'https://cityroom.blogs.nytimes.com/'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; blog - inactive (phase 1); non-secure',
      testId: 11
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestHeaders: {
        Host: 'cityroom.blogs.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/',
      responseStatusCode: 200,
      scenarioDescription:
        'Test HTTPS Everywhere; blog - inactive (phase 1); secure',
      testId: 12
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/watching',
      responseHeaderMatches: {
        location: 'https://' + suite.servername + '/watching'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; watching (phase 3); non-secure; opt-out cookie not set',
      testId: 13
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/watching',
      responseStatusCode: 200,
      scenarioDescription:
        'Test HTTPS Everywhere; watching (phase 3); secure; opt-out cookie not set',
      testId: 15
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/real-estate/find-a-home',
      responseHeaderMatches: {
        location: 'https://' + suite.servername + '/real-estate/find-a-home'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; real estate (phase 2); non-secure; opt-out cookie not set',
      testId: 17
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestHeaderCookie: 'nyt.np.internal-https-opt-out=1',
      requestScheme: 'https://',
      requestUri: '/real-estate/find-a-home',
      responseStatusCode: 200,
      scenarioDescription:
        'Test HTTPS Everywhere; real estate (phase 2); non-secure; opt-out cookie set',
      testId: 18
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/real-estate/find-a-home',
      responseStatusCode: 200,
      scenarioDescription:
        'Test HTTPS Everywhere; real estate (phase 2); secure; opt-out cookie not set',
      testId: 19
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestHeaderCookie: 'nyt.np.internal-https-opt-out=1',
      requestScheme: 'http://',
      requestUri: '/real-estate/find-a-home',
      responseHeaderMatches: {
        location: 'https://' + suite.servername + '/real-estate/find-a-home'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; real estate (phase 2); secure; opt-out cookie set',
      testId: 20
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/aponline/2014/01/01/world/test-suite.html',
      responseHeaderMatches: {
        location:
          'https://' +
          suite.servername +
          '/aponline/2014/01/01/world/test-suite.html'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; wire article (phase 3); non-secure; opt-out cookie not set',
      testId: 21
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/reuters/2014/01/01/world/test-suite.html',
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test HTTPS Everywhere; wire article (phase 3); secure; opt-out cookie not set',
      testId: 23
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false,
      },
      requestHeaders: {
        Host: 'lens.blogs.nytimes.com'
      },
      requestScheme: 'http://',
      requestUri: '/',
      responseHeaderMatches: {
        location: 'https://lens.blogs.nytimes.com/'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; blog - active (phase 2); non-secure; opt-out cookie not set',
      testId: 25
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false,
      },
      requestHeaders: {
        Host: 'krugman.blogs.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/',
      responseStatusCode: 200,
      scenarioDescription:
        'Test HTTPS Everywhere; blog - active (phase 2); secure; opt-out cookie not set',
      testId: 27
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/guides/well/how-to-start-running',
      responseHeaderMatches: {
        location:
          'https://' + suite.servername + '/guides/well/how-to-start-running'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; well guide (phase 3); non-secure; opt-out cookie not set',
      testId: 29
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/es/',
      responseHeaderMatches: {
        location: 'https://' + suite.servername + '/es/'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; espanol (phase 3); non-secure; opt-out cookie not set',
      testId: 33
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/es/',
      responseStatusCode: 200,
      scenarioDescription:
        'Test HTTPS Everywhere; espanol (phase 3); secure; opt-out cookie not set',
      testId: 35
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestHeaderCookie: ['NYT-S=' + suite.cookies.nyt_s],
      requestScheme: 'http://',
      requestUri: '/crosswords/index.html',
      responseHeaderMatches: {
        location: 'https://' + suite.servername + '/crosswords/index.html'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; crosswords; non-secure; opt-out cookie not set',
      testId: 36
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestHeaderCookie: [
        'NYT-S=' + suite.cookies.nyt_s,
        'nyt.np.internal-https-opt-out=1'
      ],
      requestScheme: 'https://',
      requestUri: '/crosswords/index.html',
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; crosswords; non-secure; opt-out cookie set',
      testId: 37
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestHeaderCookie: ['NYT-S=' + suite.cookies.nyt_s],
      requestScheme: 'https://',
      requestUri: '/crosswords/index.html',
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; crosswords; secure; opt-out cookie not set',
      testId: 38
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestHeaderCookie: 'nyt.np.internal-https-opt-out=1',
      requestHeaderCookie: [
        'NYT-S=' + suite.cookies.nyt_s,
        'nyt.np.internal-https-opt-out=1'
      ],
      requestScheme: 'http://',
      requestUri: '/crosswords/index.html',
      responseHeaderMatches: {
        location: 'https://' + suite.servername + '/crosswords/index.html'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; crosswords; secure; opt-out cookie set',
      testId: 39
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/tips?test=true',
      responseHeaderMatches: {
        'referrer-policy': 'no-referrer',
        location: 'https://' + suite.servername + '/tips?test=true'
      },
      responseStatusCode: 301,
      scenarioDescription: 'Test HTTPS Everywhere; tips; non-secure',
      testId: 40
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/tips?test=true',
      responseHeaderMatches: {
        'referrer-policy': 'no-referrer'
      },
      responseStatusCode: [301, 404],
      scenarioDescription: 'Test HTTPS Everywhere; tips; secure',
      testId: 41
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/newsgraphics/2016/news-tips/',
      responseHeaderMatches: {
        'referrer-policy': 'no-referrer',
        location:
          'https://' + suite.servername + '/newsgraphics/2016/news-tips/'
      },
      responseStatusCode: 301,
      scenarioDescription: 'Test HTTPS Everywhere; news-tips; non-secure',
      testId: 42
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/newsgraphics/2016/news-tips/',
      responseHeaderMatches: {
        'referrer-policy': 'no-referrer'
      },
      responseStatusCode: 200,
      scenarioDescription: 'Test HTTPS Everywhere; news-tips; secure',
      testId: 43
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri:
        '/newsgraphics/2017/01/11/the-briefing-signup-promo/1283bece6d72cb76497fe837cab6ff80cc930571/build.js',
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test HTTPS Everywhere; newsgraphics/2017 stg; secure',
      testId: 44
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri:
        '/newsgraphics/2017/01/11/the-briefing-signup-promo/1283bece6d72cb76497fe837cab6ff80cc930571/build.js',
      responseHeaderMatches: {
        location:
          'https://' +
          suite.servername +
          '/newsgraphics/2017/01/11/the-briefing-signup-promo/1283bece6d72cb76497fe837cab6ff80cc930571/build.js'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; newsgraphics/2017 stg; non-secure',
      testId: 45
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false,
      },
      requestScheme: 'https://',
      requestUri:
        '/newsgraphics/2017/01/11/the-briefing-signup-promo/05ba99bc85e33d92920aa1c4f0be68e59238ef8c/build.js',
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test HTTPS Everywhere; newsgraphics/2017 prd; secure',
      testId: 46
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false,
      },
      requestScheme: 'http://',
      requestUri:
        '/newsgraphics/2017/01/11/the-briefing-signup-promo/05ba99bc85e33d92920aa1c4f0be68e59238ef8c/build.js',
      responseHeaderMatches: {
        location:
          'https://' +
          suite.servername +
          '/newsgraphics/2017/01/11/the-briefing-signup-promo/05ba99bc85e33d92920aa1c4f0be68e59238ef8c/build.js'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; newsgraphics/2017 prd; non-secure',
      testId: 47
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/elections/results/president',
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test HTTPS Everywhere; elections; secure',
      testId: 48
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/elections/results/president',
      responseHeaderMatches: {
        location: 'https://' + suite.servername + '/elections/results/president'
      },
      responseStatusCode: 301,
      scenarioDescription: 'Test HTTPS Everywhere; elections; non-secure',
      testId: 49
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/newsletters/realestate',
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test HTTPS Everywhere; newsletters; secure',
      testId: 50
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/newsletters/realestate',
      responseHeaderMatches: {
        location: 'https://' + suite.servername + '/newsletters/realestate'
      },
      responseStatusCode: 301,
      scenarioDescription: 'Test HTTPS Everywhere; newsletters; non-secure',
      testId: 51
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri:
        '/packages/images/email/special_offers/ss/Sophisticated_Shopper.html',
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test HTTPS Everywhere; newsletters packages; secure',
      testId: 52
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri:
        '/packages/images/email/special_offers/ss/Sophisticated_Shopper.html',
      responseHeaderMatches: {
        location:
          'https://' +
          suite.servername +
          '/packages/images/email/special_offers/ss/Sophisticated_Shopper.html'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; newsletters packages; non-secure',
      testId: 53
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/pages/cooking/cooking-email/index.html',
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test HTTPS Everywhere; newsletters cooking; secure',
      testId: 54
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/pages/cooking/cooking-email/index.html',
      responseHeaderMatches: {
        location:
          'https://' +
          suite.servername +
          '/pages/cooking/cooking-email/index.html'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; newsletters cooking; non-secure',
      testId: 55
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/pages/todaysheadlines/index.html',
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test HTTPS Everywhere; todays headlines; secure',
      testId: 56
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/pages/todaysheadlines/index.html',
      responseHeaderMatches: {
        location:
          'https://' + suite.servername + '/pages/todaysheadlines/index.html'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; todays headlines cooking; non-secure',
      testId: 57
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/interactive/us/faces-of-the-dead.html',
      responseStatusCode: 200,
      scenarioDescription: 'Test HTTPS Everywhere; 9/11 interactive; secure',
      testId: 58
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'http://',
      requestUri: '/interactive/us/faces-of-the-dead.html',
      responseHeaderMatches: {
        location:
          'https://' +
          suite.servername +
          '/interactive/us/faces-of-the-dead.html'
      },
      responseStatusCode: 301,
      scenarioDescription:
        'Test HTTPS Everywhere; 9/11 interactive; non-secure',
      testId: 59
    },
    {
      id: 'FunctionalTestScenarioRealEstateAPIRedirect',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri:
        '/real-estate/api/personalization/saved-items-status?itemIds=123',
      responseHeaderMatches: {
        location:
          'https://' +
          suite.servername +
          '/real-estate/api/personalization/saved-items-status?itemIds=123'
      },
      responseStatusCode: 301,
      scenarioDescription: 'Test HTTPS redirect is working for real-estate api',
      testId: 60
    },
    {
      id: 'FunctionalTestScenarioRealEstateAPIAuth',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestHeaders: {
        cookie: 'nyt.dv.nyt5-on-gke=1;'
      },
      requestScheme: 'https://',
      requestUri:
        '/real-estate/api/personalization/saved-items-status?itemIds=123',
      responseHeaderMatches: {
        'x-cache': 'MISS'
      },
      responseStatusCode: 401,
      scenarioDescription: 'Test HTTPS Auth is working for real-estate',
      testId: 61
    }
  ];
  return scenarios;
}
