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
        dev: true
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
        dev: true
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
        dev: true
      },
      requestScheme: "https://",
      requestUri: "/programs/ftu/public/healthcheck.txt",
      responseHeaderMatches: {
        "x-frame-options": "DENY",
        "x-nyt-route": "programs-gcs",
        "x-nyt-backend": "gcs_origin"
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
      testId: 3
    },
    {
      id: "FunctionalTestScenarioDefinitionForGCSUpdate",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: "https://",
      requestUri: "/programs/public/healthcheck.txt",
      responseHeaderMatches: {
        "x-frame-options": "DENY",
        "x-nyt-route": "programs-gcs",
        "x-nyt-backend": "gcs_origin",
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
      testId: 4
    },
    {
      id: "FunctionalTestScenarioStripAllQueryParams",
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestScheme: "https://",
      requestUri: "/programs/well-challenge?buildId=5176112502013952&q=8sdjv073mcl0s",
      responseHeaderMatches: {
        "x-frame-options": "DENY",
        "x-nyt-route": "programs-service",
        "x-nyt-backend": "programs_svc",
        "x-nyt-final-url": "/programs/well-challenge"
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
      scenarioDescription: "Programs strip all query parameters from final url in prd env",
      testId: 5
    },
    {
      id: "FunctionalTestScenarioFilterQueryParamsStaging",
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestScheme: "https://",
      requestUri: "/programs/well-challenge?buildId=5176112502013952&q=8sdjv073mcl0s",
      responseHeaderMatches: {
        "x-frame-options": "DENY",
        "x-nyt-route": "programs-service",
        "x-nyt-backend": "programs_svc",
        "x-nyt-final-url": "/programs/well-challenge?buildId=5176112502013952"
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
      scenarioDescription: "Programs filter query string for buildId only in stg env",
      testId: 6
    },
    {
      id: "FunctionalTestScenarioFilterQueryParamsStaging",
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true
      },
      requestScheme: "https://",
      requestUri: "/programs/well-challenge?buildId=5176112502013952&q=8sdjv073mcl0s",
      responseHeaderMatches: {
        "x-frame-options": "DENY",
        "x-nyt-route": "programs-service",
        "x-nyt-backend": "programs_svc",
        "x-nyt-final-url": "/programs/well-challenge?buildId=5176112502013952&q=8sdjv073mcl0s"
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
      scenarioDescription: "Programs keep all query strings in dev env",
      testId: 7
    },
  ];

  return scenarios;
}
