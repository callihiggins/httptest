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
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
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
      requestUri:
        '/external/idg/2009/10/08/08idg-how-dangerous-could-a-hacked-robot-possibly-be-72478.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-frame-options': /DENY/,
        'x-pagetype': /legacy-gke/
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
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-frame-options': /DENY/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/,
        location: /https:\/\/help.nytimes.com/
      },
      responseStatusCode: [301, 404],
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
      scenarioDescription: 'Test legacy; www cluster; imagepages',
      testId: 22
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
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [200, 301, 404],
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
      requestUri: '/learning/general/onthisday/bday/0418.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
      requestUri:
        '/packages/html/magazine/2009-inauguration-gallery/index.html',
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
      requestUri: '/robots.txt',
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [200, 404],
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
        'x-pagetype': /legacy-gke/
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
        'x-pagetype': /legacy-gke/
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
        'x-pagetype': /legacy-gke/
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
        'x-pagetype': /legacy-gke/
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
      responseHeaderPattern: {
        'x-api-version': /F-(GL)/,
        'x-pagetype': /legacy-gke/
      },
      responseStatusCode: [301, 404],
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
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/travel',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /travel served from Legacy GKE Backend',
      testId: 51
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/recipes/1016392/recipe.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /recipes served from Legacy GKE Backend',
      testId: 52
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/most-popular',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /most-popular served from Legacy GKE Backend',
      testId: 53
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/most-popular-emailed?derp=1',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription:
        'Test /most-popular-emailed served from Legacy GKE Backend',
      testId: 54
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/most-popular-viewed?awesome=yup',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription:
        'Test /most-popular-viewed served from Legacy GKE Backend',
      testId: 55
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/technology/personaltech/cellphones/overview.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription:
        'Test /technology/personaltech/ served from Legacy GKE Backend',
      testId: 56
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/gst/tmagazine/video/index.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription:
        'Test /gst/tmagazine/video served from Legacy GKE Backend',
      testId: 57
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/keyword/habitat',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [404],
      scenarioDescription: 'Test /keyword served from Legacy GKE Backend',
      testId: 58
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/premium/xword/puzzles.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /premium served from Legacy GKE Backend',
      testId: 59
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/svc/movies/mymovietimes.html?output_type=html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [403],
      scenarioDescription: 'Test /svc/movies served from Legacy GKE Backend',
      testId: 60
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/events/dance/christopher-caines-33623.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /events served from Legacy GKE Backend',
      testId: 61
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri:
        '/mem/theater/treview.html?res=9E04E3D61539F930A25750C0A967948260',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /mem/theater/ served from Legacy GKE Backend',
      testId: 63
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/gst/theater/tdetails.html?id=1125015367926',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /gst/theater/ served from Legacy GKE Backend',
      testId: 64
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/tv/show/185421/Four-Extraordinary-Women/overview',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /tv served from Legacy GKE Backend',
      testId: 65
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri:
        '/health/guides/disease/stroke-related-to-cocaine-use/overview.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /health/guides served from Legacy GKE Backend',
      testId: 66
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/RealMedia/ads/adstream_jx.ads',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [404],
      scenarioDescription: 'Test /RealMedia served from Legacy GKE Backend',
      testId: 68
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/guests/directory/Social_Sciences/',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /guests/ served from Legacy GKE Backend',
      testId: 69
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri:
        '/new/2003/bmw/z4/100191224/roadtestarticle.html?articleId=99257',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /dev/ served from Legacy GKE Backend',
      testId: 70
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/admin/index.php?login',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [404],
      scenarioDescription: 'Test /admin/ served from Legacy GKE Backend',
      testId: 71
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/administrator/components/com_catalog/',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription:
        'Test /administrator/ served from Legacy GKE Backend',
      testId: 72
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/allbusiness/AB4113314_primary.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /allbusiness/ served from Legacy GKE Backend',
      testId: 73
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/books/first/e/ellis-founding.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /books/ served from Legacy GKE Backend',
      testId: 74
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/rss/asia.xml',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /rss/ served from Legacy GKE Backend',
      testId: 75
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/nyt/rss/HomePage',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [404],
      scenarioDescription:
        'Test /nyt/rss/HomePage served from Legacy GKE Backend',
      testId: 76
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/sports',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /sports served from Legacy GKE Backend',
      testId: 77
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri:
        '/logout?WT.nav=shell&action=Click&module=LogOut&pgtype=article&region=TopBar',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /logout served from Legacy GKE Backend',
      testId: 78
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/hdleftnav',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /hdleftnav served from Legacy GKE Backend',
      testId: 79
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/membercenter/sitehelp.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /membercenter served from Legacy GKE Backend',
      testId: 80
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/thedailyoffer',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /thedailyoffer served from Legacy GKE Backend',
      testId: 81
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/ref/health/healthguide/esn-Raynauds-expert.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /ref/ served from Legacy GKE Backend',
      testId: 82
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/movie/review?res=9C05EEDE1E3BEF3ABC4E51DFB467838C659EDE',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /movie/ served from Legacy GKE Backend',
      testId: 83
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/export_html/common/new_login_iframe.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [403],
      scenarioDescription:
        'Test /export_html/common/new_login_iframe.html served from Legacy GKE Backend',
      testId: 84
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri:
        '/mem/email-this.html?url=http%3A%2F%2Fwww.nytimes.com%2F1995%2F01%2F26%2Fnyregion%2Fwhen-cinderella-is-a-teacher-awards-are-the-glass-slipper-at-the-annual-ball.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription:
        'Test /mem/email-this.html served from Legacy GKE Backend',
      testId: 85
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/gst/movies/msearch.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /gst/movies/ served from Legacy GKE Backend',
      testId: 86
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/websvc/user/data.json?callback=jQuery17105667599483611219',
      responseHeaderMatches: {
        'x-api-version': 'F-GL',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [403],
      scenarioDescription: 'Test /websvc served from Legacy GKE Backend',
      testId: 87
    }
  ];

  return scenarios;
}
