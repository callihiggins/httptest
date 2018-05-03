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
        'x-nyt-route': 'legacy-gke'
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
      requestScheme: 'http://',
      requestUri: '/slideshow/2013/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke'
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
      requestScheme: 'http://',
      requestUri: '/slideshow/2001/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke'
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
      requestScheme: 'http://',
      requestUri: '/slideshow/2005/01/01/us/slug.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke'
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
        'x-nyt-route': 'vi-slideshow'
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
        'x-nyt-route': 'vi-slideshow'
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
      requestHeaderCookie: ['nyt.dv.nyt5-on-gke.slideshow=1'],
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2016/12/14/travel/our-favorite-travel-photography-of-2016/s/18BEST-OF-2016-IMAGES-slide-8RFM.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GS',
        'x-nyt-route': 'slideshow'
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
      requestHeaderCookie: ['nyt.dv.nyt5-on-gke.slideshow=1'],
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2015/12/25/t-magazine/oddball-geniuses-tarantino-fassbender-rampling/s/25tmag-11well_rihanna-t_CA0-copy.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GS',
        'x-nyt-route': 'slideshow'
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
      requestHeaderCookie: ['nyt.dv.nyt5-on-gke.slideshow=1'],
      requestScheme: 'https://',
      requestUri:
        '/slideshow/2014/09/21/upshot/23up-un/s/21up-un-slide-ZRTJ.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GS',
        'x-nyt-route': 'slideshow'
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
      requestHeaderCookie: ['nyt.dv.nyt5-on-gke.slideshow=1'],
      requestScheme: 'http://',
      requestUri: '/slideshow/2013/12/25/dining/20131225-REST.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GS',
        'x-nyt-route': 'slideshow'
      },
      responseStatusCode: [200, 301],
      scenarioDescription:
        'Test slideshow; Serve 2013 slideshow from NYT5 GKE with HTTP, /slideshow/2013/12/25/dining/20131225-REST.html',
      testId: 105
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: false
      },
      requestHeaderCookie: ['nyt.dv.nyt5-on-gke.slideshow=1'],
      requestScheme: 'http://',
      requestUri: '/slideshow/2011/07/10/world/africa/10sudan.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GS',
        'x-nyt-route': 'slideshow'
      },
      responseStatusCode: [200, 301],
      scenarioDescription:
        'Test slideshow; Serve 2011 slideshow on NYT5 GKE with HTTP, /slideshow/2011/07/10/world/africa/10sudan.html',
      testId: 106
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: false
      },
      requestHeaderCookie: ['nyt.dv.nyt5-on-gke.slideshow=1'],
      requestScheme: 'http://',
      requestUri: '/slideshow/2009/04/27/science/042809-Ants_index.html',
      responseHeaderMatches: {
        'x-api-version': 'F-GS',
        'x-nyt-route': 'slideshow'
      },
      responseStatusCode: [200, 301],
      scenarioDescription:
        'Test slideshow; Serve 2009 slideshow on NYT5 GKE with HTTP, /slideshow/2009/04/27/science/042809-Ants_index.html',
      testId: 107
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestHeaderCookie: ['nyt.dv.nyt5-on-gke.slideshow=1'],
      requestScheme: 'http://',
      requestUri: '/slideshow/2007/10/10/nytfrontpage/20071010POD_7.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke'
      },
      responseStatusCode: [200, 301],
      scenarioDescription:
        'Test slideshow2007 slideshow fallback to NYT4 ESX, /slideshow/2007/10/10/nytfrontpage/20071010POD_7.html',
      testId: 108
    }
  ];

  return scenarios;
}
