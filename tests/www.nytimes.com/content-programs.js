var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "FunctionalTestScenarioDefinitionForHtmlPage",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: "https://",
      requestUri: "/programs/status.txt",
      responseHeaderMatches: {
        "x-api-version": "F-PS",
        "x-frame-options": "DENY",
        "x-pagetype": "programs-service"
      },
      responseHeadersPresent: ["x-cache", "x-served-by"],
      responseHeadersNotPresent: [
        "nnCoection",
        "via",
        "x-age",
        "x-backend",
        "x-detectedruntimeconfigflag",
        "x-esi-status",
        "x-hash",
        "x-origin-server",
        "x-powered-by",
        "x-servername",
        "x-servername2",
        "x-varnish",
        "x-varnishcacheduration"
      ],
      responseStatusCode: [200],
      scenarioDescription: "Programs web app; status server is responding OK",
      testId: 1
    },
    {
      id: "FunctionalTestScenarioDefinitionForSVC",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: "https://",
      requestUri: "/programs/svc/shaq/v1/healthcheck",
      responseHeaderMatches: {
        "x-frame-options": "DENY",
        "x-cache": "MISS",        
        "x-pagetype": "programs-service"
      },
      responseHeadersPresent: ["x-cache", "x-served-by"],
      responseHeadersNotPresent: [
        "nnCoection",
        "via",
        "x-age",
        "x-backend",
        "x-detectedruntimeconfigflag",
        "x-esi-status",
        "x-hash",
        "x-origin-server",
        "x-powered-by",
        "x-servername",
        "x-servername2",
        "x-varnish",
        "x-varnishcacheduration"
      ],
      responseStatusCode: [200],
      scenarioDescription: "Programs shaq web app; status server is responding OK",
      testId: 2
    }    
  ];

  return scenarios;
}
