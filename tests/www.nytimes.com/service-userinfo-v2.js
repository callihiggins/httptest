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
        'dev': true,
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
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'NYT-S=' + suite.cookies.nyt_s,
      'requestScheme': 'http://',
      'requestUri': '/svc/web-products/userinfo-v2.json',
      'responseHeaderContains': {},
      'responseHeaderPattern': {
        'x-api-version': /F-(GU|5-0)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'service',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test userinfo service, version 2: valid NYT-S cookie; JSON format',
      'testId': 2,
      'userInfoAuthId': '37593002',
      'userInfoAuthName': 'qa_fake',
      'userInfoCountry': 'US',
      'userInfoSubscriptions': ['SVID', '_UID', 'BTA', 'XWD'],
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForService',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'NYT-S=' + suite.cookies.nyt_s,
      'requestScheme': 'http://',
      'requestUri': '/svc/web-products/userinfo-v2.json',
      'responseHeaderContains': {},
      'responseHeaderPattern': {
        'x-api-version': /F-(GU|5-0)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'service',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test userinfo service, version 2: valid NYT-S cookie; JSON format',
      'testId': 3,
      'userInfoAuthId': '37593002',
      'userInfoAuthName': 'qa_fake',
      'userInfoCountry': '(null)',
      'userInfoSubscriptions': ['SVID', '_UID', 'BTA', 'XWD'],
    },
  ];

  return scenarios;
}
