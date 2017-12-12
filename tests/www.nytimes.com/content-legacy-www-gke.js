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
        sbx: false
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
        sbx: false
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
    }
  ];

  return scenarios;
}
