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
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': '',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/08/26/arts/things-to-do-in-new-york-metropolitan-museum-flume.html',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.glogin + '/glogin?URI=' + encodeURIComponent('https://' + suite.servername + '/2016/08/26/arts/things-to-do-in-new-york-metropolitan-museum-flume.html?_r=0'),
      },
      'responseStatusCode': [303],
      'scenarioDescription': 'Test mobile redirect; OAK article; 2016; desktop; no cookies; redirect to glogin',
      'testId': '1b',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/07/15/books/elements-on-stg.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-VI',
      },
      'responseHeadersNotPresent': [
        'location',
      ],
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; OAK article; 2016; desktop; valid NYT-S cookie; does not redirect',
      'testId': '2a',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/08/26/arts/things-to-do-in-new-york-metropolitan-museum-flume.html',
      'responseHeaderMatches': {
        'x-cms-format': 'oak',
      },
      'responseHeadersNotPresent': [
        'location',
      ],
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; OAK article; 2016; desktop; valid NYT-S cookie; does not redirect',
      'testId': '2b',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': '',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/08/26/arts/things-to-do-in-new-york-metropolitan-museum-flume.html',
      'responseHeaderMatches': {
        'location': 'https://' + suite.hosts.glogin + '/glogin?URI=' + encodeURIComponent('https://' + suite.servername + '/2016/08/26/arts/things-to-do-in-new-york-metropolitan-museum-flume.html?_r=0'),
      },
      'responseStatusCode': [303],
      'scenarioDescription': 'Test mobile redirect; OAK article; 2016; iPhone; no cookies; redirect to glogin',
      'testId': '3b',
      'testId': 6,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/07/15/books/elements-on-stg.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-VI',
      },
      'responseHeadersNotPresent': [
        'location',
      ],
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; OAK article; 2016; iPhone; valid NYT-S cookie; does not redirect',
      'testId': '4a',
      'testId': 7,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (NodeJS test suite <falkae@nytimes.com>)',
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/08/26/arts/things-to-do-in-new-york-metropolitan-museum-flume.html',
      'responseHeaderMatches': {
        'x-cms-format': 'oak',
      },
      'responseHeadersNotPresent': [
        'location',
      ],
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test mobile redirect; OAK article; 2016; iPhone; valid NYT-S cookie; does not redirect',
      'testId': '4b',
      'testId': 8,
    },
  ];

  return scenarios;
}
