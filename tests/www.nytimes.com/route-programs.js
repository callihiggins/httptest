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
        "x-nyt-route": "programs-service"
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
        sbx: true
      },
      requestScheme: "https://",
      requestUri: "/programs/svc/shaq/v1/healthcheck",
      responseHeaderMatches: {
        "x-frame-options": "DENY",
        "x-cache": "MISS",
        "x-nyt-route": "shaq-service"
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
    },
    {
      id: "FunctionalTestScenarioDefinitionForGCS",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: "https://",
      requestUri: "/programs/ftu/public/healthcheck.txt",
      responseHeaderMatches: {
        "x-api-version": "F-PGCS",
        "x-frame-options": "DENY",
        "x-nyt-route": "programs-gcs"
      },
      responseHeadersPresent: ["x-cache", "x-served-by"],
      responseHeadersNotPresent: [
        "cookie",
        "nnCoection",
        "via",
        "x-age",
        "x-backend",
        "x-detectedruntimeconfigflag",
        "x-esi-status",
        "x-gcs-bucket",
        "x-hash",
        "x-origin-server",
        "x-powered-by",
        "x-servername",
        "x-servername2",
        "x-varnish",
        "x-varnishcacheduration"
      ],
      responseStatusCode: [200],
      scenarioDescription: "Programs asset CDN; GCS is responding OK",
      testId: "3"
    },
    {
      id: "FunctionalTestScenarioDefinitionForGCSUpdate",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: "https://",
      requestUri: "/programs/public/healthcheck.txt",
      responseHeaderMatches: {
        "x-api-version": "F-PGCS",
        "x-frame-options": "DENY",
        "x-nyt-route": "programs-gcs"
      },
      responseHeadersPresent: ["x-cache", "x-served-by"],
      responseHeadersNotPresent: [
        "cookie",
        "nnCoection",
        "via",
        "x-age",
        "x-backend",
        "x-detectedruntimeconfigflag",
        "x-esi-status",
        "x-gcs-bucket",
        "x-hash",
        "x-origin-server",
        "x-powered-by",
        "x-servername",
        "x-servername2",
        "x-varnish",
        "x-varnishcacheduration"
      ],
      responseStatusCode: [200],
      scenarioDescription: "Programs asset CDN; GCS is responding OK",
      testId: "4"
    },
  ];

  return scenarios;
}
