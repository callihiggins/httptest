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
        prd: false,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/amex',
      requestHeaderCookie: 'nyt.dv.nyt5-on-gke=1',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test 301 redirect on WWW Legacy GKE /amex',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/.remote.txt',
      requestHeaderCookie: 'nyt.dv.nyt5-on-gke=1',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test GCS file on WWW Legacy GKE /.remote.txt ',
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
      requestUri: '/js/selectWidget.js',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-pagetype': 'legacy-gke',
        'content-type': 'application/javascript'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test WWW JS served from Legacy GKE Backend',
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
      requestUri: '/css/article.css',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test WWW CSS served from Legacy GKE Backend',
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
      requestUri: '/bi/js/analytics/EventTracker.js',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-pagetype': 'legacy-gke',
        'content-type': 'application/javascript'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test WWW JS served from Legacy GKE Storage',
      testId: 5
    },
    {
      id: 'FunctionalTestScenarioDefinitionForStaticGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/apple-app-site-association',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test apple-app-site-association served from WWW Legacy GKE',
      testId: 6
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
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [200, 404],
      scenarioDescription: 'Test well-known served from WWW Legacy GKE',
      testId: 7
    },
    {
      id: 'FunctionalTestScenarioDefinitionForStaticGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/frommers/',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [200, 301, 404],
      scenarioDescription: 'Test frommers served from WWW Legacy GKE',
      testId: 8
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
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test comscore html served from Legacy GKE backend',
      testId: 10
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
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [301],
      scenarioDescription:
        'Test rss xml redirects served from Legacy GKE backend',
      testId: 11
    },
    {
      id: 'FunctionalTestScenarioDefinitionForStaticGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/js/nyt5/ab/abconfig.json',
      responseHeaderPattern: {
        'x-api-version': /F-GL/,
        'x-pagetype': /legacy/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Test abconfig.json file serving from Legacy GKE backend',
      testId: 12
    },
    {
      id: 'FunctionalTestScenarioDefinitionForStaticGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/svc/web/localstorage.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-pagetype': 'legacy-gke'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test localstorage html served from Legacy GKE backend',
      testId: 13
    },
  ];

  return scenarios;
}
