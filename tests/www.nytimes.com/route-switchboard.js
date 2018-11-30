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
        'x-nyt-route': 'switchboard',
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
        'x-nyt-route': 'switchboard',
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
        'x-nyt-route': 'switchboard',
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
        'x-nyt-route': 'switchboard',
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
        'x-nyt-route': 'switchboard',
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
        'x-nyt-route': 'switchboard',
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
        'x-nyt-route': 'switchboard',
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
        'x-nyt-route': 'switchboard',
      },
      responseStatusCode: [302],
      scenarioDescription: 'Test /thedaily is served from switchboard',
      testId: 8
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'http://',
      requestUri: '/the-daily',
      responseHeaderMatches: {
        'x-nyt-route': 'switchboard',
      },
      responseStatusCode: [302],
      scenarioDescription: 'Test /the-daily is served from switchboard',
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
      requestUri: '/thedailyoffer',
      responseHeaderMatches: {
        'x-nyt-route': 'legacy-gke',
      },
      scenarioDescription: 'Test /thedailyoffer is not served from switchboard',
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
      requestUri: '/thedailylistener',
      responseHeaderMatches: {
        'x-nyt-route': 'legacy-gke',
      },
      scenarioDescription: 'Test /thedailylistener is not served from switchboard',
      testId: 11
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/stillprocessing',
      responseHeaderMatches: {
        'x-nyt-route': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /stillprocessing is served from switchboard',
      testId: 12
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/book-review-podcast',
      responseHeaderMatches: {
        'x-nyt-route': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /book-review-podcast is served from switchboard',
      testId: 13
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/popcast',
      responseHeaderMatches: {
        'x-nyt-route': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /popcast is served from switchboard',
      testId: 14
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/podcasts/modern-love',
      responseHeaderMatches: {
        'x-nyt-route': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /podcasts/modern-love is served from switchboard',
      testId: 15
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/podcasts/music-popcast',
      responseHeaderMatches: {
        'x-nyt-route': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /podcasts/music-popcast is served from switchboard',
      testId: 16
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/dearsugars',
      responseHeaderMatches: {
        'x-nyt-route': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /dearsugars is served from switchboard',
      testId: 17
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      requestScheme: 'https://',
      requestUri: '/podcasts/',
      responseHeaderMatches: {
        'x-nyt-route': 'switchboard',
        'x-gdpr': '0',
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test podcasts on /podcasts/',
      testId: 18,
    },
    {
      id: 'FunctionalTestScenarioDefinitionForLegacyGKE',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/the-argument',
      responseHeaderMatches: {
        'x-nyt-route': 'switchboard',
      },
      responseStatusCode: [301],
      scenarioDescription: 'Test /dearsugars is served from switchboard',
      testId: 19
    },
  ];

  return scenarios;
}
