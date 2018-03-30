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
      requestUri: '/.well-known/assetlinks.json',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-pagetype': 'legacy-gke',
      },
      responseStatusCode: 200,
      scenarioDescription: 'Test well-known/assetlinks.json; non-secure',
      testId: 1
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
      requestUri: '/.well-known/assetlinks.json',
      responseHeaderMatches: {
        'x-nyt-backend': 'www_legacy_gke',
        'x-pagetype': 'legacy-gke',
      },
      responseStatusCode: 200,
      scenarioDescription: 'Test well-known/assetlinks.json; secure',
      testId: 2
    }
  ];

  return scenarios;
}
