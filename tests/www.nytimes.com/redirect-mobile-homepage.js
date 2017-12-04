var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents()
{
  var scenarios = [    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; homepage; desktop; does not redirect',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; iPhone; does redirect',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=0',
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=0"; desktop; does not redirect',
      'testId': 11,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=0',
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=0"; iPhone; does not redirect',
      'testId': 12,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=1"; desktop; does redirect',
      'testId': 21,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=1"; iPhone; does redirect',
      'testId': 22,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=0',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; homepage; cookie "nyt-mobile=0"; desktop; does not redirect',
      'testId': 31,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=0',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; homepage; cookie "nyt-mobile=0"; iPhone; does not redirect',
      'testId': 32,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=0',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=0',
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=0"; cookie "nyt-mobile=0"; desktop; does not redirect',
      'testId': 41,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=0',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=0',
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=0"; cookie "nyt-mobile=0"; iPhone; does not redirect',
      'testId': 42,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=0',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=1',
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=1"; cookie "nyt-mobile=0"; desktop; does not redirect',
      'testId': 51,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=0',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=1',
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=1"; cookie "nyt-mobile=0"; iPhone; does not redirect',
      'testId': 52,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; cookie "nyt-mobile=1"; desktop; does redirect',
      'testId': 61,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; cookie "nyt-mobile=1"; iPhone; does redirect',
      'testId': 62,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=0',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?nytmobile=0&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=0"; cookie "nyt-mobile=1"; desktop; does redirect',
      'testId': 71,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=0',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?nytmobile=0&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=0"; cookie "nyt-mobile=1"; iPhone; does redirect',
      'testId': 72,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=1"; cookie "nyt-mobile=1"; desktop; does redirect',
      'testId': 81,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=1"; cookie "nyt-mobile=1"; iPhone; does redirect',
      'testId': 82,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; valid NYT-S cookie; iPhone; does redirect',
      'testId': 92,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; cookie "nyt-mobile=1"; valid NYT-S cookie; desktop; does redirect',
      'testId': 151,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; cookie "nyt-mobile=1"; valid NYT-S cookie; iPhone; does redirect',
      'testId': 152,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/?nytmobile=0',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/?nytmobile=0&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; homepage; querystring "nytmobile=0"; cookie "nyt-mobile=1"; valid NYT-S cookie; iPhone; does redirect',
      'testId': 162,
    },
  ];

  return scenarios;
}
