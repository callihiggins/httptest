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
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseStatusCode': 200,
      'scenarioDescription': 'WCM subscription: 200 status code test',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/notfound.html',
      'responseStatusCode': 404,
      'scenarioDescription': 'WCM subscription: 404 status code test',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd.html?testQueryString=test',
      'responseHeaderPattern' : {
        'location' : /testQueryString=test/,
      },
      'responseStatusCode': 302,
      'scenarioDescription': 'WCM subscription redirect [302] with preserving query string test',
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
      'requestScheme': 'http://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderContains' : {
        'location': 'https://' + suite.servername + '/subscription/hd/1041.html',
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'WCM subscription protocol upgrade [http => https] test',
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
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=170.149.100.75',
      'responseHeaderMatches': {
        'x-frame-options': 'DENY',
        'x-nyt-currency': 'USD',
        'x-nyt-continent': 'NA',
        'x-nyt-country': 'US',
        'x-nyt-region': 'NY',
        'x-api-version': 'F-WCM',
      },
      'responseHeadersPresent': [
        'age',
        'cache-control',
        'x-api-version',
        'x-cache',
        'x-cache-hits',
        'x-origin-server',
        'x-pagetype',
        'x-served-by',
      ],
      'responseHeadersNotPresent': [
        'nnCoection',
        'via',
        'x-backend',
        'x-detectedruntimeconfigflag',
        'x-esi-status',
        'x-hash',
        'x-powered-by',
        'x-servername',
        'x-servername2',
        'x-varnish',
      ],
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription header test',
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
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'requestHeaders': {
        'Fastly-Debug': 1
      },
      'responseHeadersPresent': [
        'surrogate-key',
      ],
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "surrogate-key" header presence test',
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
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'requestHeaders': {
        'Fastly-Debug': 1
      },
      'responseHeadersPresent': [
        'x-varnishcacheduration', // TODO: surrogate-cache-control
      ],
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "x-varnishcacheduration" header presence test',
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
        'Fastly-Debug': 1
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderPattern': {
        'vary': /Accept-Encoding/,
        'vary': /X-NYT-Currency/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "vary" header presence test',
      'testId': 7,
    },
    /*
    * Below tests are for 'x-nyt-currency' and 'x-nyt-country' response headers
    */
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=91.187.91.187',
      'responseHeaderMatches': {
        'x-nyt-currency': 'USD',
        'x-nyt-country': 'AD',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "x-nyt-currency", "x-nyt-country" headers for IP 91.187.91.187',
      'testId': 8,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=91.118.126.194',
      'responseHeaderMatches': {
        'x-nyt-currency': 'EUR',
        'x-nyt-country': 'AT',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "x-nyt-currency", "x-nyt-country" headers for IP 91.118.126.194',
      'testId': 9,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=170.157.174.185',
      'responseHeaderMatches': {
        'x-nyt-currency': 'AUD',
        'x-nyt-country': 'AU',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "x-nyt-currency", "x-nyt-country" headers for IP 170.157.174.185',
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
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=129.128.1.199',
      'responseHeaderMatches': {
        'x-nyt-currency': 'CAD',
        'x-nyt-country': 'CA',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "x-nyt-currency", "x-nyt-country" headers for IP 129.128.1.199',
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
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=85.90.227.224',
      'responseHeaderMatches': {
        'x-nyt-currency': 'GBP',
        'x-nyt-country': 'GB',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "x-nyt-currency", "x-nyt-country" headers for IP 85.90.227.224',
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
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=195.43.49.101',
      'responseHeaderMatches': {
        'x-nyt-currency': 'GBP',
        'x-nyt-country': 'GB',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "x-nyt-currency", "x-nyt-country" headers for IP 195.43.49.101',
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
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=115.187.34.211',
      'responseHeaderMatches': {
        'x-nyt-currency': 'INR',
        'x-nyt-country': 'IN',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "x-nyt-currency", "x-nyt-country" headers for IP 115.187.34.211',
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
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=66.220.253.41',
      'responseHeaderMatches': {
        'x-nyt-currency': 'USD',
        'x-nyt-country': 'US',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "x-nyt-currency", "x-nyt-country" headers for IP 66.220.253.41',
      'testId': 15,
    },
  ];

  return scenarios;
}
