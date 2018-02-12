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
        prd: false,
        stg: true,
        dev: true,
      },
      requestScheme: "http://",
      requestUri: "/amex",
      requestHeaderCookie: "nyt.dv.nyt5-on-gke=1",
      responseHeaderMatches: {
        "x-api-version": "F-GL",
        "x-pagetype": "legacy"
      },
      responseStatusCode: [301],
      scenarioDescription: "Test 301 redirect on WWW Legacy GKE /amex",
      testId: 1
    },
    {
      id: "FunctionalTestScenarioDefinitionForHtmlPage",
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: true,
      },
      requestScheme: "http://",
      requestUri: "/.remote.txt",
      requestHeaderCookie: "nyt.dv.nyt5-on-gke=1",
      responseHeaderMatches: {
        "x-api-version": "F-GL-S",
        "x-pagetype": "legacy"
      },
      responseStatusCode: [200],
      scenarioDescription: "Test GCS file on WWW Legacy GKE /.remote.txt ",
      testId: 2
    },
    {
      id: "FunctionalTestScenarioDefinitionForStaticGKE",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: "https://",
      requestUri: "/js/selectWidget.js",
      responseHeaderMatches: {
        "x-api-version": "F-GL",
        "x-pagetype": "legacy-gke",
        "content-type": "application/javascript"
      },
      responseStatusCode: [200],
      scenarioDescription:
        "Test WWW JS served from Legacy GKE Backend",
      testId: 3
    },
    {
      id: "FunctionalTestScenarioDefinitionForStaticGKE",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: "https://",
      requestUri: "/css/article.css",
      responseHeaderMatches: {
        "x-api-version": "F-GL",
        "x-pagetype": "legacy-gke",
      },
      responseStatusCode: [200],
      scenarioDescription:
        "Test WWW CSS served from Legacy GKE Backend",
      testId: 4
    },
    {
      id: "FunctionalTestScenarioDefinitionForStaticGKE",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: "https://",
      requestUri: "/bi/js/analytics/EventTracker.js",
      responseHeaderMatches: {
        "x-api-version": "F-GL-S",
        "x-pagetype": "legacy-gke",
        "content-type": "application/javascript"
      },
      responseStatusCode: [200],
      scenarioDescription:
        "Test WWW JS served from Legacy GKE Storage",
      testId: 5
    },
    {
      id: "FunctionalTestScenarioDefinitionForStaticGKE",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: "https://",
      requestUri: "/svc/comscore/pvc.html",
      responseHeaderMatches: {
        "x-api-version": "F-GL",
        "x-pagetype": "legacy-gke"
      },
      responseStatusCode: [200],
      scenarioDescription:
        "Test comscore html served from Legacy GKE backend",
      testId: 6
    },
  ];

  return scenarios;
}
