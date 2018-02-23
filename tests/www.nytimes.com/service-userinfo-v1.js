var suite = require('/lib/suite.js');
var lodash = require('lodash');
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
  t.ok(lodash.isEqual(userinfo.data.subscription, s.userInfoSubscriptions), "User subscriptions match expected values");
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
        'prd': false,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': '',
      'requestScheme': 'http://',
      'requestUri': '/svc/web-products/userinfo.json',
      'responseHeaderContains': {},
      'responseHeaderMatches': {
        'x-api-version': 'F-0',
        'x-pagetype': 'service',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test userinfo service, version 1: no cookies; JSON format',
      'testId': 1,
      'userInfoAuthId': '0',
      'userInfoAuthName': '',
      'userInfoSubscriptions': {'web': '0', 'mobile': '0', 'crosswords': '0', 'hd': '0', 'now': '0'},
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForService',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': 'NYT-S=' + suite.cookies.nyt_s,
      'requestScheme': 'http://',
      'requestUri': '/svc/web-products/userinfo.json',
      'responseHeaderContains': {},
      'responseHeaderPattern': {
        'x-api-version': /F-(GU|5-0)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'service',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test userinfo service, version 1: valid NYT-S cookie; JSON format',
      'testId': 2,
      'userInfoAuthId': '37593002',
      'userInfoAuthName': 'qa_fake',
      'userInfoSubscriptions': {'web': '0', 'mobile': '0', 'crosswords': '1', 'hd': '0', 'now': '0'},
    },
  ];

  return scenarios;
}
