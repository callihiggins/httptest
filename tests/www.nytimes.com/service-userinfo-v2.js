var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios, bodyHandler);

/**
 * @return void
 */
function bodyHandler(s, t, body, response)
{
  if (response.statusCode != 200) {
    t.fail("Response body is a valid JSON string");
    return;
  }
  var userinfo = JSON.parse(body);
  t.ok(userinfo, "Response body is a valid JSON string");
  t.ok(userinfo.meta, "Response body has a 'meta' key");
  t.ok(userinfo.data, "Response body has a 'data' key");
  t.ok(userinfo.data.subscription, "Response body has a 'subscription' key under 'data'");
  t.equal(userinfo.data.id, s.userInfoAuthId, "User Auth ID equals '" + s.userInfoAuthId + "'");
  t.equal(userinfo.data.name, s.userInfoAuthName, "User Auth Name equals '" + s.userInfoAuthName + "'");
  t.equal(userinfo.data.country, s.userInfoCountry, "User country equals '" + s.userInfoCountry + "'");
  s.userInfoSubscriptions.forEach(function (i) {
    t.ok(userinfo.data.subscription.indexOf(i) > -1, "User subscription list contains value '" + i + "'");
  })
}

/**
 * @return array
 */
function getScenarioEvents()
{
  var scenarios = [
    {
      'id': 'FunctionalTestScenarioDefinitionForService',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': '',
      'requestScheme': 'http://',
      'requestUri': '/svc/web-products/userinfo-v2.json',
      'responseHeaderContains': {},
      'responseHeaderMatches': {
        'x-api-version': 'F-0',
        'x-pagetype': 'service',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test userinfo service, version 2: no cookies; JSON format',
      'testId': 1,
      'userInfoAuthId': '0',
      'userInfoAuthName': '',
      'userInfoCountry': '(null)',
      'userInfoSubscriptions': [],
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForService',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'NYT-S=' + suite.cookies.nyt_s,
      'requestScheme': 'http://',
      'requestUri': '/svc/web-products/userinfo-v2.json',
      'responseHeaderContains': {},
      'responseHeaderMatches': {
        'x-api-version': 'F-5-0',
        'x-pagetype': 'service',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test userinfo service, version 2: valid NYT-S cookie; JSON format',
      'testId': 2,
      'userInfoAuthId': '37593002',
      'userInfoAuthName': 'qa_fake',
      'userInfoCountry': '(null)',
      'userInfoSubscriptions': ['', 'SVID', '_UID', 'BTA', 'XWD'],
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForService',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-d=101.1vD1a2L0lCAI0N0K0s9Iny1/5XWG074Z0t0p8GS00R2pGc0hUYSr0nDo9y1nOoGf0M07yz0i1Xbw031n8M0RV1Sv0pC2ea1/7nuK0A37ae0pApKk1/7nu30A0daU1w0mSI0H6XuD0SV75h1mT6Xs1yOq54@68863438/4ea33cbc',
      'requestScheme': 'http://',
      'requestUri': '/svc/web-products/userinfo-v2.json',
      'responseHeaderContains': {},
      'responseHeaderMatches': {
        'x-api-version': 'F-0',
        'x-pagetype': 'service',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test userinfo service, version 2: valid nyt-d cookie; JSON format',
      'testId': 3,
      'userInfoAuthId': '0',
      'userInfoAuthName': '',
      'userInfoCountry': 'US',
      'userInfoSubscriptions': [],
    },
  ];

  return scenarios;
}
