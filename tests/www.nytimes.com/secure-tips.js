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
        stg: false,
        dev: false
      },
      requestScheme: 'http://',
      requestUri: '/tips?test=true',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke',
        'referrer-policy': 'no-referrer',
        location: 'https://' + suite.servername + '/tips?test=true'
      },
      responseStatusCode: 301,
      scenarioDescription: 'Test HTTPS Everywhere; tips; non-secure',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestScheme: 'https://',
      requestUri: '/tips?test=true',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-nyt-route': 'legacy-gke',
        'referrer-policy': 'no-referrer'
      },
      responseStatusCode: [301, 404],
      scenarioDescription: 'Test HTTPS Everywhere; tips; secure',
      testId: 2
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/newsgraphics/2016/news-tips/index.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'gcs_origin',
        'x-nyt-route': 'newsgraphics-gcs',
        'referrer-policy': 'no-referrer',
        location:
          'https://' +
          suite.servername +
          '/newsgraphics/2016/news-tips/index.html'
      },
      responseStatusCode: 301,
      scenarioDescription: 'Test HTTPS Everywhere; news-tips; non-secure',
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
      requestUri: '/newsgraphics/2016/news-tips/index.html',
      responseHeaderMatches: {
        'x-nyt-backend': 'gcs_origin',
        'x-nyt-route': 'newsgraphics-gcs',
        'referrer-policy': 'no-referrer'
      },
      responseStatusCode: 200,
      scenarioDescription: 'Test HTTPS Everywhere; news-tips; secure',
      testId: 4
    },
  ];

  return scenarios;
}
