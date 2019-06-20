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
    requestScheme: 'http://',
    requestUri: '/save75',
    responseHeaderMatches: {
      'x-nyt-route': 'legacy-gke',
      'x-nyt-backend': 'www_legacy_gke'
    },
    scenarioDescription: 'Test legacy; vanity redirect; </save75>',
    testId: 1
  },
  {
    id: 'FunctionalTestScenarioDefinitionForStaticGKE',
    isDeployedInEnv: {
      prd: true,
      stg: true,
      dev: true
    },
    requestScheme: 'https://',
    requestUri: '/js/selectWidget.js',
    responseHeaderMatches: {
      'x-nyt-backend': 'www_legacy_gke',
      'x-nyt-route': 'legacy-gke',
      'content-type': 'application/javascript'
    },
    scenarioDescription: 'Test WWW JS served from Legacy GKE Backend',
    testId: 2
  },
  {
    id: 'FunctionalTestScenarioDefinitionForStaticGKE',
    isDeployedInEnv: {
      prd: true,
      stg: true,
      dev: true
    },
    requestScheme: 'https://',
    requestUri: '/.well-known/apple-app-site-association',
    responseHeaderMatches: {
      'x-nyt-backend': 'www_legacy_gke',
      'x-nyt-route': 'legacy-gke'
    },
    scenarioDescription: 'Test well-known served from WWW Legacy GKE',
    testId: 3
  },
  {
    id: 'FunctionalTestScenarioDefinitionForStaticGKE',
    isDeployedInEnv: {
      prd: true,
      stg: true,
      dev: true
    },
    requestScheme: 'https://',
    requestUri: '/svc/comscore/pvc.html',
    responseHeaderMatches: {
      'x-nyt-backend': 'www_legacy_gke',
      'x-nyt-route': 'legacy-gke'
    },
    scenarioDescription: 'Test comscore html served from Legacy GKE backend',
    testId: 4
  },
  {
    id: 'FunctionalTestScenarioDefinitionForStaticGKE',
    isDeployedInEnv: {
      prd: true,
      stg: true,
      dev: true
    },
    requestScheme: 'https://',
    requestUri: '/services/xml/rss/nyt/Dealbook.xml',
    responseHeaderMatches: {
      'x-nyt-backend': 'www_legacy_gke',
      'x-nyt-route': 'legacy-gke'
    },
    scenarioDescription:
      'Test rss xml redirects served from Legacy GKE backend',
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
    requestUri: '/favicon.ico',
    responseHeaderMatches: {
      'x-nyt-backend': 'www_legacy_gke',
      'x-nyt-route': 'legacy-gke',
    },
    scenarioDescription: 'Test legacy; www cluster; favicon file',
    testId: 6
  },
  {
    id: 'FunctionalTestScenarioDefinitionForHtmlPage',
    isDeployedInEnv: {
      prd: true,
      stg: true,
      dev: true
    },
    requestScheme: 'http://',
    requestUri: '/humans.txt',
    responseHeaderMatches: {
      'x-nyt-backend': 'www_legacy_gke',
      'x-nyt-route': 'legacy-gke',
    },
    scenarioDescription: 'Test legacy; www cluster; humans file',
    testId: 7
  },
  {
    id: 'FunctionalTestScenarioDefinitionForHtmlPage',
    isDeployedInEnv: {
      prd: true,
      stg: true,
      dev: true
    },
    requestScheme: 'http://',
    requestUri: '/interactive/2013/12/19/us/politics/19nsa-review.html',
    responseHeaderMatches: {
      'x-nyt-backend': 'www_legacy_gke',
      'x-nyt-route': 'legacy-gke',
    },
    scenarioDescription: 'Test legacy; www cluster; interactive; default',
    testId: 8
  },
  {
    id: 'FunctionalTestScenarioDefinitionForHtmlPage',
    isDeployedInEnv: {
      prd: true,
      stg: true,
      dev: true
    },
    requestScheme: 'http://',
    requestUri:
      '/packages/html/magazine/2009-inauguration-gallery/index.html',
    responseHeaderMatches: {
      'x-nyt-backend': 'www_legacy_gke',
      'x-nyt-route': 'legacy-gke',
    },
    scenarioDescription: 'Test legacy; www cluster; packages; HTML',
    testId: 9
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
      'x-nyt-backend': 'www_legacy_gke',
      'x-nyt-route': 'legacy-gke'
    },
    scenarioDescription: 'Test /gst/movies/ served from Legacy GKE Backend',
    testId: 10
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
      'x-nyt-backend': 'www_legacy_gke',
      'x-nyt-route': 'legacy-gke'
    },
    responseHeaderPattern: {
      'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      'x-gdpr': /^[0-1]$/,
    },
    scenarioDescription: 'Legacy route sets gdpr cookie and header',
    testId: 11
  },
];
return scenarios;
}
