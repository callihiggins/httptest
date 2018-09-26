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
  t.ok(userinfo.data.demographics, "Response body has a 'demographics' key under 'data'");
  t.ok(userinfo.data.geo, "Response body has a 'geo' key under 'data'");
  t.ok(userinfo.data.subscription, "Response body has a 'subscription' key under 'data'");
  t.equal(userinfo.data.id, s.userInfoAuthId, "User Auth ID equals '" + s.userInfoAuthId + "'");
  t.equal(userinfo.data.name, s.userInfoAuthName, "User Auth Name equals '" + s.userInfoAuthName + "'");
  t.equal(userinfo.data.geo.country, s.userInfoCountry, "User country equals '" + s.userInfoCountry + "'");
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
        'dev': true,
      },
      'requestHeaderCookie': '',
      'requestHeaderRemoteIp': '170.149.161.130',
      'requestScheme': 'http://',
      'requestUri': '/svc/web-products/userinfo-v3.json',
      'responseHeaderContains': {},
      'responseHeaderMatches': {
        'x-nyt-route': 'service',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test userinfo service, version 3: no cookies; GeoIP of USA; JSON format',
      'testId': 1,
      'userInfoAuthId': '0',
      'userInfoAuthName': '',
      'userInfoCountry': 'united states',
      'userInfoSubscriptions': [],
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForService',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': 'NYT-S=' + suite.cookies.nyt_s,
      'requestHeaderRemoteIp': '170.149.161.130',
      'requestScheme': 'http://',
      'requestUri': '/svc/web-products/userinfo-v3.json',
      'responseHeaderContains': {},
      'responseHeaderMatches': {
        'x-nyt-route': 'service',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test userinfo service, version 3: valid NYT-S cookie; GeoIP of USA; JSON format',
      'testId': 2,
      'userInfoAuthId': '37593002',
      'userInfoAuthName': 'qa_fake',
      'userInfoCountry': 'United States',
      'userInfoSubscriptions': ['SVID', '_UID', 'BTA', 'XWD'],
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForService',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaderCookie': 'NYT-S=' + suite.cookies.nyt_s,
      'requestHeaderRemoteIp': '170.149.161.130',
      'requestHeaders': {
        'x-nyt-edge-cdn': 'fastly',
      },
      'requestScheme': 'http://',
      'requestUri': '/svc/web-products/userinfo-v3.json',
      'responseHeaderContains': {},
      'responseHeaderMatches': {
        'x-nyt-route': 'service',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test userinfo service, version 3: valid NYT-S cookie; GeoIP of USA; JSON format',
      'testId': 3,
      'userInfoAuthId': '37593002',
      'userInfoAuthName': 'qa_fake',
      'userInfoCountry': 'United States',
      'userInfoSubscriptions': ['SVID', '_UID', 'BTA', 'XWD'],
    },
  ];

  return scenarios;
}
