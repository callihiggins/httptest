var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents()
{
  var scenarios = [
    {
      'id': 'RedirectHomescreenToggle',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'vi_www_hp_opt=',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/homescreen',
      'responseStatusCode': [301],
      'scenarioDescription': '/homescreen redirects to homepage, sets the cookie to 0',
      'responseHeaderMatch': {
        'location': 'https://www.nytimes.com',
      },
      'testId': 1,
    },
    {
      'id': 'RedirectHomescreenToggle',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'vi_www_hp_opt=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/homescreen',
      'responseStatusCode': [301],
      'scenarioDescription': '/homescreen redirects to homepage, sets the cookie to 0',
      'responseHeaderMatch': {
        'location': 'https://www.nytimes.com',
      },
      'testId': 2,
    },
    {
      'id': 'RedirectHomescreenToggle',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'vi_www_hp_opt=0',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/homescreen',
      'responseStatusCode': [301],
      'scenarioDescription': '/homescreen redirects to homepage, sets the cookie to 1',
      'responseHeaderMatch': {
        'location': 'https://www.nytimes.com',
      },
      // 'responseHeaderPattern': {
      //   'Set-Cookie': /^vi_www_hp_opt=1; path=\/; domain=.nytimes.com; expires=(.+)/g,
      // },
      'testId': 3,
    },
  ];

  return scenarios;
}
