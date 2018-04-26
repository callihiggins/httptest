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
      requestUri: "/adx/bin/clientside/f80b44b9Q2Fuuuuuu.u.rsLrQ5CzrQ27uuuuuuuu.4d3sQ3E.8Q27uuuu8zQ3EzQ27zP",
      responseHeaderMatches: {
        "x-api-version": "F-AS",
        "x-nyt-route": "adx-static"
      },
      responseHeadersPresent: [
        "cache-control",
        "x-goog-generation"
      ],
      responseStatusCode: [200],
      scenarioDescription: "ADX Clientside responds with 200 from GCS",
      testId: 1
    },
    {
      id: "FunctionalTestScenarioDefinitionForHtmlPage",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: "https://",
      requestUri: "/adx/bin/adxrun.html?jsonp=processAdx&page=www.nytimes.com%2Fyr%2Fmo%2Fday%2Fus%2Fvegas-motive-mass-shootings.html&positions=Inv1%2CInv2%2CInv3%2Cab1%2Cab2%2Cab3%2Cprop1%2Cprop2%2CAnchor%2CBar1%2CADX_CLIENTSIDE&autoconfirm=0&v=3&cpp=0&attributes=nyt5&keywords=Las+Vegas++Nev++Shooting+(October++2017)%2CPaddock++Stephen+C+(1953-2017)%2CFederal+Bureau+of+Investigation%2CLas+Vegas+(Nev)&secureClientside=1",
      responseHeaderMatches: {
        "x-api-version": "F-AS",
        "x-nyt-route": "adx-static"
      },
      responseHeadersPresent: [
        "cache-control",
        "x-goog-generation"
      ],
      responseStatusCode: [200],
      scenarioDescription: "ADX adxrun.html responds with 200 from GCS",
      testId: 2
    },
    {
      id: "FunctionalTestScenarioDefinitionForHtmlPage",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: "https://",
      requestUri: "/adx/bin/adxrun.json",
      responseHeaderMatches: {
        "x-api-version": "F-AS",
        "x-nyt-route": "adx-static"
      },
      responseHeadersPresent: [
        "cache-control",
        "x-goog-generation"
      ],
      responseStatusCode: [200],
      scenarioDescription: "ADX adxrun.json responds with 200 from GCS",
      testId: 3
    },
    {
      id: "FunctionalTestScenarioDefinitionForHtmlPage",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: "https://",
      requestUri: "/svc/adxmulti/hello.json",
      responseHeaderMatches: {
        "x-api-version": "F-AS",
        "x-nyt-route": "adx-static"
      },
      responseHeadersPresent: [
        "cache-control",
        "x-goog-generation"
      ],
      responseStatusCode: [200],
      scenarioDescription: "ADX adxmulti responds with 200 from GCS",
      testId: 4
    },
    {
      id: "FunctionalTestScenarioDefinitionForHtmlPage",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: "https://",
      requestUri: "/gst/svc/adx.html",
      responseHeaderMatches: {
        "x-api-version": "F-AS",
        "x-nyt-route": "adx-static"
      },
      responseHeadersPresent: [
        "cache-control",
        "x-goog-generation"
      ],
      responseStatusCode: [200],
      scenarioDescription: "ADX /gst/svc/adx.html responds with 200 from GCS",
      testId: 5
    },
    {
      id: "FunctionalTestScenarioDefinitionForHtmlPage",
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
        sbx: false
      },
      requestScheme: "https://",
      requestUri: "/adxbin/hello.txt",
      responseHeaderMatches: {
        "x-api-version": "F-AS",
        "x-nyt-route": "adx-static"
      },
      responseHeadersPresent: [
        "cache-control",
        "x-goog-generation"
      ],
      responseStatusCode: [200],
      scenarioDescription: "ADX /adxbin/ responds with 200 from GCS",
      testId: 6
    },
  ];

  return scenarios;
}
