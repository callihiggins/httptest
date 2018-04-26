var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: "FunctionalTestScenarioDefinitionForService",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: "https://",
      requestUri: "/svc/user/mobile/entitlements/mtd.json",
      requestHeaderCookie: 'NYT-S=' + suite.cookies.nyt_s,
      
      responseHeaderMatches: {
        "x-api-version": "F-PFE",
        "x-nyt-route": "profile-fe",
        "x-nyt-backend": "profile_fe",
        "cache-control": "private",
      },
      responseStatusCode: [200],
      scenarioDescription: "Request to profile-fe is successful",
      testId: 1
    },
  ];

  return scenarios;
}
