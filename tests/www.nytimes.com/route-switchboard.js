var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/theater',
      responseHeaderMatches: {
        'x-pagetype': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /theater is served from switchboard',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/movies',
      responseHeaderMatches: {
        'x-pagetype': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /movies is served from switchboard',
      testId: 2
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/best-sellers',
      responseHeaderMatches: {
        'x-pagetype': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /best-sellers is served from switchboard',
      testId: 3
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/restaurants/',
      responseHeaderMatches: {
        'x-pagetype': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /restaurants/ is served from switchboard',
      testId: 4
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/listings',
      responseHeaderMatches: {
        'x-pagetype': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /listings is served from switchboard',
      testId: 5
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/briefing',
      responseHeaderMatches: {
        'x-pagetype': 'switchboard',
      },
      responseStatusCode: [302],
      scenarioDescription: 'Test /briefing is served from switchboard',
      testId: 6
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/ambriefing',
      responseHeaderMatches: {
        'x-pagetype': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /ambriefing is served from switchboard',
      testId: 7
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/thedaily',
      responseHeaderMatches: {
        'x-pagetype': 'switchboard',
      },
      responseStatusCode: [302],
      scenarioDescription: 'Test /thedaily is served from switchboard',
      testId: 8
    },
  ];

  return scenarios;
}
