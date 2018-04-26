var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios, bodyHandler);


/**
 * @return void
 */
function bodyHandler(s, t, body, response)
{

  if (response.statusCode != 200) {
    t.fail("Response code not valid, failing check for jQuery callback signature");
    return;
  }

  if (s.skipJquerySignatureCheck) {
    t.ok("test requested to skip check for jQuery callback signature")
    return;
  }

  //t.ok(match, "Response body contains ESI replacement signature '/**/ jQuery'");
  t.ok(body.indexOf("jQuery") > -1, "Found jQuery callback signature in response");
}

/**
 * @return array
 */
function getScenarioEvents()
{
  var scenarios = [
    {
      'isDeployedInEnv': {
        'dev': true,
        'stg': true,
        'prd': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/community/V3/requestHandler?cmd=GetBasicInfo',
      'responseHeaderMatches': {
        'x-nyt-backend': 'community_svc',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'community-svc',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'route-community-svc: test GetBasicInfo, contains no ESI',
      'skipJquerySignatureCheck': true,
      'testId': 1,
    },
    {
      'isDeployedInEnv': {
        'dev': true,
        'stg': true,
        'prd': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/community/V3/requestHandler?callback=jQuery21407773274087830635_1520633908267&url=https%253A%252F%252Fwww.nytimes.com%252F2018%252F03%252F08%252Fus%252Fpolitics%252Ftrump-meeting-kim-jong-un.html&cmd=GetCommentSummary&method=get&_=1520633908271',
      'responseHeaderMatches': {
        'x-nyt-backend': 'community_svc',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'community-svc-cacheable',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'route-community-svc: GetCommentSummary is cacheable if user not logged in, https',
      'skipJquerySignatureCheck': false,
      'testId': 2,
    },
    {
      'isDeployedInEnv': {
        'dev': true,
        'stg': true,
        'prd': true,
      },
      'requestHeaderCookie': ['NYT-S=' + suite.cookies.nyt_s],
      'requestScheme': 'https://',
      'requestUri': '/svc/community/V3/requestHandler?callback=jQuery21407773274087830635_1520633908267&url=https%253A%252F%252Fwww.nytimes.com%252F2018%252F03%252F08%252Fus%252Fpolitics%252Ftrump-meeting-kim-jong-un.html&cmd=GetCommentSummary&method=get&_=1520633908271',
      'responseHeaderMatches': {
        'x-nyt-backend': 'community_svc',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'community-svc',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'route-community-svc: GetCommentSummary is not cacheable if user is logged in, https',
      'skipJquerySignatureCheck': false,
      'testId': 3,
    },
    {
      'isDeployedInEnv': {
        'dev': true,
        'stg': true,
        'prd': true,
      },
      'requestScheme': 'http://',
      'requestUri': '/svc/community/V3/requestHandler?callback=jQuery21407773274087830635_1520633908267&url=https%253A%252F%252Fwww.nytimes.com%252F2018%252F03%252F08%252Fus%252Fpolitics%252Ftrump-meeting-kim-jong-un.html&cmd=GetCommentSummary&method=get&_=1520633908271',
      'responseHeaderMatches': {
        'x-nyt-backend': 'community_svc',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'community-svc-cacheable',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'route-community-svc: GetCommentSummary is cacheable if user not logged in, http',
      'skipJquerySignatureCheck': false,
      'testId': 4,
    },
    {
      'isDeployedInEnv': {
        'dev': true,
        'stg': true,
        'prd': true,
      },
      'requestHeaderCookie': ['NYT-S=' + suite.cookies.nyt_s],
      'requestScheme': 'http://',
      'requestUri': '/svc/community/V3/requestHandler?callback=jQuery21407773274087830635_1520633908267&url=https%253A%252F%252Fwww.nytimes.com%252F2018%252F03%252F08%252Fus%252Fpolitics%252Ftrump-meeting-kim-jong-un.html&cmd=GetCommentSummary&method=get&_=1520633908271',
      'responseHeaderMatches': {
        'x-nyt-backend': 'community_svc',
        'x-frame-options': 'DENY',
        'x-nyt-route': 'community-svc',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'route-community-svc: GetCommentSummary is not cacheable if user is logged in, http',
      'skipJquerySignatureCheck': false,
      'testId': 5,
    },
  ]
  return scenarios;
}
