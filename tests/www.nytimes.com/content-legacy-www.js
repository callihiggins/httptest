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
      requestScheme: 'http://',
      requestUri: '/library/film/gravesend-film-review.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test legacy; www cluster; archive movie review',
      testId: 2
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
      requestUri: '/autos',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; autos',
      testId: 5
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
      requestUri: '/books/00/01/09/specials/joyce-ulysses.html',
      responseHeaderMatches: {
        'x-api-version': 'F-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; books',
      testId: 6
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
      requestUri: '/export_html/common/new_login_iframe.html',
      responseHeaderMatches: {
        'x-api-version': 'F-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test legacy; www cluster; export_html; login iframe',
      testId: 7
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
      requestUri:
        '/external/idg/2009/10/08/08idg-how-dangerous-could-a-hacked-robot-possibly-be-72478.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test legacy; www cluster; external authorship; IDG, variant 1 of 2',
      testId: 8
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
      requestUri: '/idg/IDG_852573C4006938800025748D0064C292.html',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test legacy; www cluster; external authorship; IDG, variant 2 of 2',
      testId: 9
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
      requestUri: '/inc_com/feature_inc1176120030123_legal.html',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test legacy; www cluster; external authorship; Inc.com',
      testId: 10
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
      requestUri:
        '/external/readwriteweb/2011/03/31/31readwriteweb-google-ditches-barcodes-for-nfc-36542.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test legacy; www cluster; external authorship; ReadWriteWeb',
      testId: 11
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
      requestUri:
        '/external/venturebeat/2011/09/26/26venturebeat-healthtaps-social-network-of-5000-doctors-is-6641.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test legacy; www cluster; external authorship; VentureBeat',
      testId: 12
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
      requestUri: '/favicon.ico',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; favicon file',
      testId: 13
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
      requestUri: '/googleglass',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; Google glass',
      testId: 14
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
      requestUri: '/features/common/moth/homepage.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test legacy; www cluster; feature; homepage MOTH',
      testId: 15
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
      requestUri: '/guantanamo-files/',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test legacy; www cluster; feature; Guantanamo files',
      testId: 16
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
      requestUri: '/features/includes/us/politics/politicsSubNavigation.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test legacy; www cluster; feature; subnavigation file',
      testId: 17
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
      requestUri: '/content/help/account/account.html',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy',
        location: 'https://help.nytimes.com'
      },
      responseStatusCode: [301],
      scenarioDescription:
        'Test legacy; www cluster; help pages, variant 1 of 2',
      testId: 18
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
      requestUri: '/info/help/letters.html',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test legacy; www cluster; help pages, variant 2 of 2',
      testId: 19
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
      requestUri: '/humans.txt',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; humans file',
      testId: 20
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
      requestUri: '/iht/2007/08/12/opinion/IHT-12edcohen.1.html',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; IHT opinion page',
      testId: 21
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
      requestUri: '/imagepages/2016/11/22/us/23trump7_hp.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test legacy; www cluster; imagepages',
      testId: 22
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
      requestUri: '/indexes/2001/09/11/',
      responseHeaderMatches: {
        'x-api-version': 'F-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; indexes homepage',
      testId: '23p'
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: 'http://',
      requestUri: '/indexes/2001/09/11/',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test legacy; www cluster; indexes homepage',
      testId: '23s'
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
      requestUri: '/interactive/2013/12/19/us/politics/19nsa-review.html',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; interactive; default',
      testId: 24
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
      requestUri: '/projects/2012/snow-fall/',
      responseHeaderMatches: {
        'x-api-version': 'F-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; interactive; Snowfall',
      testId: 25
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
      requestUri: '/learning/general/onthisday/bday/0418.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test legacy; www cluster; Learning Network',
      testId: 26
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
      requestUri: '/marketing/selfservice/audience.html',
      responseHeaderMatches: {
        'x-pagetype': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-continent': 'NA',
        'x-nyt-country': 'US',
        'x-api-version': 'F-WCM'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; marketing',
      testId: 27
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
      requestUri: '/newsgraphics/2014/01/05/poverty-map/',
      responseHeadersPresent: ['x-cache'],
      responseHeaderMatches: {
        'x-api-version': 'F-4',
        'x-pagetype': 'legacy-cacheable'
      },
      responseHeadersNotPresent: ['x-frame-options'],
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; newsgraphics',
      testId: 28
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
      requestUri:
        '/packages/html/magazine/2009-inauguration-gallery/index.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test legacy; www cluster; packages; HTML',
      testId: 29
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
      requestUri: '/redesign/',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; redesign page',
      testId: 30
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
      requestUri: '/ref/books/fiction-25-years.html',
      responseHeaderMatches: {
        'x-api-version': 'F-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; reference; books',
      testId: 31
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
      requestUri: '/ref/movies/1000best.html',
      responseHeaderMatches: {
        'x-api-version': 'F-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [301],
      scenarioDescription:
        'Test legacy; www cluster; reference; 1000 best movies',
      testId: 32
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
      requestUri: '/robots.txt',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test legacy; www cluster; robots file',
      testId: 33
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
      requestUri: '/svc/web/localstorage.html',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; service; local storage',
      testId: 35
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
      requestUri: '/svc/most-popular/getdata.json',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; service; most popular',
      testId: 37
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
      requestUri: '/services/json/sectionfronts/upshot/index.json',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription:
        'Test legacy; www cluster; service; section front JSON',
      testId: 38
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
      requestUri: '/sitemap_news.xml.gz',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; sitemap; news',
      testId: 39
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
      requestUri: '/specials/olympics/history/1968-ousted.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test legacy; www cluster; special; Olympics',
      testId: 41
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
      requestUri:
        '/fodors/top/features/travel/destinations/asia/china/hongkong/fdrs_feat_74_7.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test legacy; www cluster; travel; Fodors',
      testId: 44
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
      requestUri:
        '/cwire/2011/10/12/12climatewire-as-anti-climate-groups-activities-rise-so-do-14988.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription:
        'Test legacy; www cluster; wire service; Climatewire',
      testId: 47
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
      requestUri:
        '/gwire/2011/10/07/07greenwire-yellowstone-bear-euthanized-after-dna-evidence-52234.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL|5-4|4)/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test legacy; www cluster; wire service; Greenwire',
      testId: 48
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
      requestUri: '/uwire/uwire_HOQZ080120051652566.html',
      responseHeaderMatches: {
        'x-api-version': 'F-5-4',
        'x-cache': 'MISS',
        'x-frame-options': 'DENY',
        'x-pagetype': 'legacy'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test legacy; www cluster; wire service; uwire',
      testId: 49
    },
    {
      id: 'oEmbedFunctionTestScenerioForJSON',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: 'https://',
      requestUri:
        '/svc/oembed/json/?url=https://www.nytimes.com/2017/05/04/opinion/obamacare-house-vote.html',
      responseStatusCode: [200],
      scenarioDescription: 'Test oembed api',
      testId: 50
    }
  ];

  return scenarios;
}
