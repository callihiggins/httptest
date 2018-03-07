var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "FunctionalTestScenarioDefinitionForSitemap",
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': true,
        'sbx': false,
      },
      requestScheme: 'http://',
      requestUri: '/sitemaps/sitemap_news/sitemap.xml.gz',
      responseHeaderMatches: {
        'x-pagetype': 'sitemap'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test sitemap, migrated from netscaler',
      testId: 1
    },
  ];

  return scenarios;
}
