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
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; iPhone 6 Plus; does redirect',
      'testId': 3,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; iPad; does not redirect',
      'testId': 4,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; Samsung Galaxy Tab S (#1); does not redirect',
      'testId': 5,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; Samsung Galaxy Tab S (#2); does not redirect',
      'testId': 6,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; Amazon Silk Tablet; does not redirect',
      'testId': 7,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; Amazon Silk Desktop; does not redirect',
      'testId': 8,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; BlackBerry; does redirect',
      'testId': 9,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; BlackBerry Z10; does redirect',
      'testId': 10,
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
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; iPhone 6 Plus; does not redirect',
      'testId': 13,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; iPad; does not redirect',
      'testId': 14,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; Samsung Galaxy Tab S (#1); does not redirect',
      'testId': 15,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; Samsung Galaxy Tab S (#2); does not redirect',
      'testId': 16,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; Amazon Silk Tablet; does not redirect',
      'testId': 17,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; Amazon Silk Desktop; does not redirect',
      'testId': 18,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; BlackBerry; does not redirect',
      'testId': 19,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; BlackBerry Z10; does not redirect',
      'testId': 20,
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
    {
      'id': 'FunctionalTestScenarioDefinitionForRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; iPhone 6 Plus; does redirect',
      'testId': 23,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; iPad; does redirect',
      'testId': 24,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; Samsung Galaxy Tab S (#1); does redirect',
      'testId': 25,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; Samsung Galaxy Tab S (#2); does redirect',
      'testId': 26,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; Amazon Silk Tablet; does redirect',
      'testId': 27,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; Amazon Silk Desktop; does redirect',
      'testId': 28,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; BlackBerry; does redirect',
      'testId': 29,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; BlackBerry Z10; does redirect',
      'testId': 30,
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
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; valid NYT-S cookie; desktop; does not redirect',
      'testId': 31,
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
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; valid NYT-S cookie; iPhone; does redirect',
      'testId': 32,
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
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; valid NYT-S cookie; iPhone 6 Plus; does redirect',
      'testId': 33,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; valid NYT-S cookie; iPad; does not redirect',
      'testId': 34,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; valid NYT-S cookie; Samsung Galaxy Tab S (#1); does not redirect',
      'testId': 35,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; valid NYT-S cookie; Samsung Galaxy Tab S (#2); does not redirect',
      'testId': 36,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; valid NYT-S cookie; Amazon Silk Tablet; does not redirect',
      'testId': 37,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; valid NYT-S cookie; Amazon Silk Desktop; does not redirect',
      'testId': 38,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; valid NYT-S cookie; BlackBerry; does redirect',
      'testId': 39,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; valid NYT-S cookie; BlackBerry Z10; does redirect',
      'testId': 40,
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
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; valid NYT-S cookie; desktop; does not redirect',
      'testId': 41,
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
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; valid NYT-S cookie; iPhone; does not redirect',
      'testId': 42,
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
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; valid NYT-S cookie; iPhone 6 Plus; does not redirect',
      'testId': 43,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; valid NYT-S cookie; iPad; does not redirect',
      'testId': 44,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; valid NYT-S cookie; Samsung Galaxy Tab S (#1); does not redirect',
      'testId': 45,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; valid NYT-S cookie; Samsung Galaxy Tab S (#2); does not redirect',
      'testId': 46,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; valid NYT-S cookie; Amazon Silk Tablet; does not redirect',
      'testId': 47,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; valid NYT-S cookie; Amazon Silk Desktop; does not redirect',
      'testId': 48,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; valid NYT-S cookie; BlackBerry; does not redirect',
      'testId': 49,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=0"; valid NYT-S cookie; BlackBerry Z10; does not redirect',
      'testId': 50,
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
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; valid NYT-S cookie; desktop; does redirect',
      'testId': 51,
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
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; valid NYT-S cookie; iPhone; does redirect',
      'testId': 52,
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
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; valid NYT-S cookie; iPhone 6 Plus; does redirect',
      'testId': 53,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; valid NYT-S cookie; iPad; does redirect',
      'testId': 54,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; valid NYT-S cookie; Samsung Galaxy Tab S (#1); does redirect',
      'testId': 55,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; valid NYT-S cookie; Samsung Galaxy Tab S (#2); does redirect',
      'testId': 56,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; valid NYT-S cookie; Amazon Silk Tablet; does redirect',
      'testId': 57,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; valid NYT-S cookie; Amazon Silk Desktop; does redirect',
      'testId': 58,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; valid NYT-S cookie; BlackBerry; does redirect',
      'testId': 59,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.mobile + '/redirect?to-mobile=' + encodeURIComponent('https://' + suite.servername + '/slideshow/2015/06/22/dining/headline-for-chipotle-slide-show-goes-here/s/Haner-Chipotle-Feature-slide-9YN6.html?nytmobile=1&referer='),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'Test mobile redirect; slideshow; 2015; querystring "nytmobile=1"; valid NYT-S cookie; BlackBerry Z10; does redirect',
      'testId': 60,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; desktop; does not redirect',
      'testId': 61,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; iPhone; does not redirect',
      'testId': 62,
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
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; iPhone 6 Plus; does not redirect',
      'testId': 63,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; iPad; does not redirect',
      'testId': 64,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; Samsung Galaxy Tab S (#1); does not redirect',
      'testId': 65,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; Samsung Galaxy Tab S (#2); does not redirect',
      'testId': 66,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; Amazon Silk Tablet; does not redirect',
      'testId': 67,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; Amazon Silk Desktop; does not redirect',
      'testId': 68,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; BlackBerry; does not redirect',
      'testId': 69,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; BlackBerry Z10; does not redirect',
      'testId': 70,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; desktop; does not redirect',
      'testId': 71,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; iPhone; does not redirect',
      'testId': 72,
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
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; iPhone 6 Plus; does not redirect',
      'testId': 73,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; iPad; does not redirect',
      'testId': 74,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; Samsung Galaxy Tab S (#1); does not redirect',
      'testId': 75,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; Samsung Galaxy Tab S (#2); does not redirect',
      'testId': 76,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; Amazon Silk Tablet; does not redirect',
      'testId': 77,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; Amazon Silk Desktop; does not redirect',
      'testId': 78,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; BlackBerry; does not redirect',
      'testId': 79,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; BlackBerry Z10; does not redirect',
      'testId': 80,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; desktop; does not redirect',
      'testId': 81,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; iPhone; does not redirect',
      'testId': 82,
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
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; iPhone 6 Plus; does not redirect',
      'testId': 83,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; iPad; does not redirect',
      'testId': 84,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; Samsung Galaxy Tab S (#1); does not redirect',
      'testId': 85,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; Samsung Galaxy Tab S (#2); does not redirect',
      'testId': 86,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; Amazon Silk Tablet; does not redirect',
      'testId': 87,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; Amazon Silk Desktop; does not redirect',
      'testId': 88,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; BlackBerry; does not redirect',
      'testId': 89,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; BlackBerry Z10; does not redirect',
      'testId': 90,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; valid NYT-S cookie; desktop; does not redirect',
      'testId': 91,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; valid NYT-S cookie; iPhone; does not redirect',
      'testId': 92,
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
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; valid NYT-S cookie; iPhone 6 Plus; does not redirect',
      'testId': 93,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; valid NYT-S cookie; iPad; does not redirect',
      'testId': 94,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; valid NYT-S cookie; Samsung Galaxy Tab S (#1); does not redirect',
      'testId': 95,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; valid NYT-S cookie; Samsung Galaxy Tab S (#2); does not redirect',
      'testId': 96,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; valid NYT-S cookie; Amazon Silk Tablet; does not redirect',
      'testId': 97,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; valid NYT-S cookie; Amazon Silk Desktop; does not redirect',
      'testId': 98,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; valid NYT-S cookie; BlackBerry; does not redirect',
      'testId': 99,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; valid NYT-S cookie; BlackBerry Z10; does not redirect',
      'testId': 100,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; valid NYT-S cookie; desktop; does not redirect',
      'testId': 101,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; valid NYT-S cookie; iPhone; does not redirect',
      'testId': 102,
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
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; valid NYT-S cookie; iPhone 6 Plus; does not redirect',
      'testId': 103,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; valid NYT-S cookie; iPad; does not redirect',
      'testId': 104,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; valid NYT-S cookie; Samsung Galaxy Tab S (#1); does not redirect',
      'testId': 105,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; valid NYT-S cookie; Samsung Galaxy Tab S (#2); does not redirect',
      'testId': 106,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; valid NYT-S cookie; Amazon Silk Tablet; does not redirect',
      'testId': 107,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; valid NYT-S cookie; Amazon Silk Desktop; does not redirect',
      'testId': 108,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; valid NYT-S cookie; BlackBerry; does not redirect',
      'testId': 109,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=0',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=0"; valid NYT-S cookie; BlackBerry Z10; does not redirect',
      'testId': 110,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; valid NYT-S cookie; desktop; does not redirect',
      'testId': 111,
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
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; valid NYT-S cookie; iPhone; does not redirect',
      'testId': 112,
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
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_4 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12H143 Safari/600.1.4 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; valid NYT-S cookie; iPhone 6 Plus; does not redirect',
      'testId': 113,
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
        'User-agent': 'Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; valid NYT-S cookie; iPad; does not redirect',
      'testId': 114,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; SM-T805 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.109 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; valid NYT-S cookie; Samsung Galaxy Tab S (#1); does not redirect',
      'testId': 115,
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
        'User-agent': 'Mozilla/5.0 (Linux; Android 4.4.2; en-us; SAMSUNG SM-T700 Build/KOT49H) AppleWebKit/537.36 (KHTML, like Gecko) Version/1.5 Chrome/28.0.1500.94 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; valid NYT-S cookie; Samsung Galaxy Tab S (#2); does not redirect',
      'testId': 116,
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
        'User-agent': 'Mozilla/5.0 (Linux; U; Android 4.2.2; en-us; KFTHWI Build/JDQ39) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; valid NYT-S cookie; Amazon Silk Tablet; does not redirect',
      'testId': 117,
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
        'User-agent': 'Mozilla/5.0 (X11; Linux x86_64; U; en-us) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.22 like Chrome/34.0.1847.137 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; valid NYT-S cookie; Amazon Silk Desktop; does not redirect',
      'testId': 118,
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
        'User-agent': 'Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; valid NYT-S cookie; BlackBerry; does not redirect',
      'testId': 119,
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
        'User-agent': 'Mozilla/5.0 (BB10; Touch) AppleWebKit/537.35+ (KHTML, like Gecko) Version/10.3.1.2243 Mobile Safari/537.35+ (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/dining/slug.html?nytmobile=1',
      'responseHeaderMatches': {
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; slideshow; 2014; querystring "nytmobile=1"; valid NYT-S cookie; BlackBerry Z10; does not redirect',
      'testId': 120,
    },
  ];

  return scenarios;
}