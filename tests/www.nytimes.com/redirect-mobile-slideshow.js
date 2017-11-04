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
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; desktop; does not redirect',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; iPhone; does redirect',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; desktop; does not redirect',
      'testId': 11,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; iPhone; does not redirect',
      'testId': 12,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; desktop; does redirect',
      'testId': 21,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; iPhone; does redirect',
      'testId': 22,
    },
  ];

  return scenarios;
}