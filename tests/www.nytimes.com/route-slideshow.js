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
      requestUri: '/slideshow/2016/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test slideshow; 301 page fallback to NYT4',
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
      requestUri: '/slideshow/2015/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test slideshow; 301 page fallback to NYT4',
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
      requestUri: '/slideshow/2014/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test slideshow; 301 page fallback to NYT4',
      testId: 4
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/slideshow/2013/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test slideshow; 301 page fallback to NYT4',
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
      requestUri: '/slideshow/2001/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test slideshow; 301 page fallback to NYT4',
      testId: 6
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/slideshow/2005/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test slideshow; 301 page fallback to NYT4',
      testId: 7
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2018/01/08/style/partying-after-the-golden-globes/s/08GG-SCENECITY-slide-IMOK.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; HTTPS enabled, /slideshow/2018/01/08/style/partying-after-the-golden-globes/s/08GG-SCENECITY-slide-IMOK.html ',
      testId: 99
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2017/09/17/fashion/emmys-2017-red-carpet-dresses/s/17REDCARPETEMMY2.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; HTTPS enabled, /slideshow/2017/09/17/fashion/emmys-2017-red-carpet-dresses/s/17REDCARPETEMMY2.html ',
      testId: 101
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2016/12/14/travel/our-favorite-travel-photography-of-2016/s/18BEST-OF-2016-IMAGES-slide-8RFM.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; HTTPS enabled, /slideshow/2016/12/14/travel/our-favorite-travel-photography-of-2016/s/18BEST-OF-2016-IMAGES-slide-8RFM.html',
      testId: 102
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2015/12/25/t-magazine/oddball-geniuses-tarantino-fassbender-rampling/s/25tmag-11well_rihanna-t_CA0-copy.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; HTTPS enabled, /slideshow/2015/12/25/t-magazine/oddball-geniuses-tarantino-fassbender-rampling/s/25tmag-11well_rihanna-t_CA0-copy.html',
      testId: 103
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: false
      },
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2014/09/21/upshot/23up-un/s/21up-un-slide-ZRTJ.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; HTTPS enabled, /slideshow/2014/09/21/upshot/23up-un/s/21up-un-slide-ZRTJ.html',
      testId: 104
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: false
      },
      requestScheme: 'https://',
      requestUri: '/slideshow/2013/12/25/dining/20131225-REST.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; Serve 2013 slideshow from Vi with HTTPS, /slideshow/2013/12/25/dining/20131225-REST.html',
      testId: 105
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: false
      },
      requestScheme: 'https://',
      requestUri: '/slideshow/2011/07/10/world/africa/10sudan.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; Serve 2011 slideshow on Vi with HTTPS, /slideshow/2011/07/10/world/africa/10sudan.html',
      testId: 106
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestScheme: 'https://',
      requestUri: '/slideshow/2009/04/27/science/042809-Ants_index.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; Serve 2009 slideshow on Vi with HTTPS, /slideshow/2009/04/27/science/042809-Ants_index.html',
      testId: 107
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestScheme: 'https://',
      requestUri: '/slideshow/2007/10/10/nytfrontpage/20071010POD_7.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200, 301],
      scenarioDescription:
        'Test slideshow2007 slideshow fallback to NYT4 ESX, /slideshow/2007/10/10/nytfrontpage/20071010POD_7.html',
      testId: 108
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2017/12/29/realestate/new-york-citys-biggest-residential-sales-in-2017/s/31YEAREND-slide-EQPY.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GS',
        'x-nyt-route': 'slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; HTTPS enabled; realestate, /slideshow/2017/12/29/realestate/new-york-citys-biggest-residential-sales-in-2017/s/31YEAREND-slide-EQPY.html',
      testId: 109
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2017/08/22/realestate/slides-headline/s/22METS-1503371668421.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GS',
        'x-nyt-route': 'slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; HTTPS enabled; realestate, /slideshow/2017/08/22/realestate/slides-headline/s/22METS-1503371668421.html',
      testId: 110
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestHeaders: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'
      },
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2018/01/08/style/partying-after-the-golden-globes/s/08GG-SCENECITY-slide-IMOK.html?gdpr=1',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; HTTPS enabled; Internet Explorer, /slideshow/2018/01/08/style/partying-after-the-golden-globes/s/08GG-SCENECITY-slide-IMOK.html ',
      testId: 111
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestHeaders: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'
      },
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2017/09/17/fashion/emmys-2017-red-carpet-dresses/s/17REDCARPETEMMY2.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; HTTPS enabled; Internet Explorer, /slideshow/2017/09/17/fashion/emmys-2017-red-carpet-dresses/s/17REDCARPETEMMY2.html ',
      testId: 112
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestHeaders: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'
      },
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2018/02/15/dining/the-pool/s/15-slideshow-1.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; HTTPS enabled; Internet Explorer, /slideshow/2018/02/15/dining/the-pool/s/15-slideshow-1.html',
      testId: 113
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestHeaders: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'
      },
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2017/08/10/arts/imitate/test-headline/s/20DYING.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; HTTPS enabled; Internet Explorer, /slideshow/2017/08/10/arts/imitate/test-headline/s/20DYING.html',
      testId: 113
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestScheme: 'https://',
      requestUri: '/slideshow/2010/01/04/sports/2010-nyt4-slideshow-in-600px.html?gdpr=1',
      responseHeaderMatches: {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-slideshow',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test slideshow; Serve 2010 slideshow on Vi with HTTPS (stg), /slideshow/2010/01/04/sports/2010-nyt4-slideshow-in-600px.html',
      testId: 114
    },
  ];

  return scenarios;
}
