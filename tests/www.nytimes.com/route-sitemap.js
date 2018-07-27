var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "Sitemap Redirect to https",
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      requestScheme: 'http://',
      requestUri: '/sitemaps/sitemap_news/sitemap.xml.gz',
      responseHeaderMatches: {
        'x-nyt-backend': 'sitemap',
        'x-nyt-route': 'sitemap'
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test sitemap, redirect from http to https',
      testId: 1
    },
    {
      id: "Sitemap served from https",
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      requestScheme: 'https://',
      requestUri: '/sitemaps/sitemap_news/sitemap.xml.gz',
      responseHeaderMatches: {
        'x-nyt-backend': 'sitemap',
        'x-nyt-route': 'sitemap'
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test sitemap, migrated from netscaler',
      testId: 1
    },
  ];

  return scenarios;
}
