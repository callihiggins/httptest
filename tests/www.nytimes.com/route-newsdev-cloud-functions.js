var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForNewsdevCloudFunctions',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/svc/int/functions/contact-reporter',
      responseHeaderMatches: {
        'x-nyt-route': 'newsdev-cloud-functions',
        'x-nyt-backend': 'newsdev_cloud_functions_us_central1',
        'access-control-allow-origin': '*',
      },
      responseStatusCode: [302],
      scenarioDescription: 'Test /svc/int/functions is served from newsdev cloud functions backend',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForUnsubscribeNewsdevCloudFunctions',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/svc/int/functions/sources-unsubscribe/healthz',
      responseHeaderMatches: {
        'x-nyt-route': 'newsdev-cloud-functions',
        'x-nyt-backend': 'newsdev_cloud_functions_us_central1',
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test /svc/int/functions is served from newsdev cloud functions backend',
      testId: 2
    },
    {
      id: 'FunctionalTestScenarioDefinitionForNewsdevCloudFunctionsAccess',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/svc/int/functions/healthcheck',
      responseHeaderMatches: {
        'x-nyt-route': 'newsdev-cloud-functions',
        'x-nyt-backend': 'newsdev_cloud_functions_us_central1',
      },
      responseStatusCode: [404],
      scenarioDescription: 'Test /svc/int/functions does not expose functions without a www- prefix',
      testId: 3
    },
    {
      id: 'FunctionalTestScenarioDefinitionForNewsdevCloudFunctionsCORS',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/svc/int/functions/contact-reporter',
      responseHeaderMatches: {
        'x-nyt-route': 'newsdev-cloud-functions',
        'x-nyt-backend': 'newsdev_cloud_functions_us_central1',
        'access-control-allow-origin': '*',
      },
      scenarioDescription: 'Test response headers from cloud functions are preserved',
      testId: 4
    },
  ];

  return scenarios;
}
