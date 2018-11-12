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
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'WCM subscription: 200 status code test',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/notfound.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': 404,
      'scenarioDescription': 'WCM subscription: 404 status code test',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd.html?testQueryString=test',
      'responseHeaderPattern' : {
        'location' : /testQueryString=test/,
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
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
        'dev': true,
      },
      'requestScheme': 'http://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderContains' : {
        'location': 'https://' + suite.servername + '/subscription/hd/1041.html',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
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
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=170.149.100.75',
      'responseHeaderMatches': {
        'x-frame-options': 'DENY',
        'x-nyt-currency': 'USD',
        'x-nyt-continent': 'NA',
        'x-nyt-country': 'US',
        'x-nyt-region': 'NY',
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseHeadersPresent': [
        'age',
        'cache-control',
        'x-api-version',
        'x-cache',
        'x-cache-hits',
        'x-origin-server',
        'x-nyt-route',
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
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'requestHeaders': {
        'Fastly-Debug': 1
      },
      'responseHeadersPresent': [
        'surrogate-key',
      ],
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "surrogate-key" header presence test',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
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
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
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
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=91.187.91.187',
      'responseHeaderMatches': {
        'x-nyt-currency': 'USD',
        'x-nyt-country': 'AD',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
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
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=91.118.126.194',
      'responseHeaderMatches': {
        'x-nyt-currency': 'EUR',
        'x-nyt-country': 'AT',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
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
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=170.157.174.185',
      'responseHeaderMatches': {
        'x-nyt-currency': 'AUD',
        'x-nyt-country': 'AU',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
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
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=129.128.1.199',
      'responseHeaderMatches': {
        'x-nyt-currency': 'CAD',
        'x-nyt-country': 'CA',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
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
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=85.90.227.224',
      'responseHeaderMatches': {
        'x-nyt-currency': 'GBP',
        'x-nyt-country': 'GB',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
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
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=195.43.49.101',
      'responseHeaderMatches': {
        'x-nyt-currency': 'GBP',
        'x-nyt-country': 'GB',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
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
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=115.187.34.211',
      'responseHeaderMatches': {
        'x-nyt-currency': 'INR',
        'x-nyt-country': 'IN',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
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
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html?ip-override=66.220.253.41',
      'responseHeaderMatches': {
        'x-nyt-currency': 'USD',
        'x-nyt-country': 'US',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "x-nyt-currency", "x-nyt-country" headers for IP 66.220.253.41',
      'testId': 15,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/marketing/surveys/crs-15101-australia.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-frame-options': 'DENY',
        'x-nyt-currency': 'USD',
        'x-nyt-continent': 'NA',
        'x-nyt-country': 'US',
      },
      'responseHeadersPresent': [
        'age',
        'cache-control',
        'x-api-version',
        'x-cache',
        'x-cache-hits',
        'x-origin-server',
        'x-nyt-route',
        'x-served-by',
        'x-nyt-region',
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
      'responseStatusCode': [200,301],
      'scenarioDescription': 'WCM marketing/surveys header test',
      'testId': 16,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/marketing/surveys/survey-not-found.html',
      'responseStatusCode': 404,
      'scenarioDescription': 'WCM Marketing Surveys: 404 status code test',
      'testId': 17,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'http://',
      'requestUri': '/services/mobile/index.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-continent': 'NA',
        'x-nyt-country': 'US',
      },
      'responseHeadersPresent': [
        'age',
        'cache-control',
        'x-api-version',
        'x-cache',
        'x-cache-hits',
        'x-origin-server',
        'x-nyt-route',
        'x-served-by',
        'x-nyt-region',
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
      'scenarioDescription': 'WCM /services/mobile headers test',
      'testId': 18,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/services/mobile/index.html',
      'responseHeaderContains' : {
        'location': 'http://' + suite.servername + '/services/mobile/index.html',
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'WCM /services/mobile force https to http test',
      'testId': 19,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'http://',
      'requestUri': '/marketing/hd/welcome/index.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-continent': 'NA',
        'x-nyt-country': 'US',
      },
      'responseHeadersPresent': [
        'age',
        'cache-control',
        'x-api-version',
        'x-cache',
        'x-cache-hits',
        'x-origin-server',
        'x-nyt-route',
        'x-served-by',
        'x-nyt-region',
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
      'scenarioDescription': 'WCM /marketing headers test',
      'testId': 20,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/marketing/hd/welcome/index.html',
      'responseHeaderContains' : {
        'location': 'http://' + suite.servername + '/marketing/hd/welcome/index.html',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'WCM /marketing force https to http test',
      'testId': 21,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'http://',
      'requestUri': '/subscriptions/lp8Y84W.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-continent': 'NA',
        'x-nyt-country': 'US',
      },
      'responseHeadersPresent': [
        'age',
        'cache-control',
        'x-api-version',
        'x-cache',
        'x-cache-hits',
        'x-origin-server',
        'x-nyt-route',
        'x-served-by',
        'x-nyt-region',
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
      'scenarioDescription': 'WCM /subscriptions headers test, validate routing',
      'testId': 22,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestUri': '/subscriptions/promotions/lp3FURL.html?ptr=verizon',
      'responseHeaderContains' : {
        'location': 'http://' + suite.servername + '/subscription/promotions/verizon.html?ptr=verizon',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'WCM /subscriptions/promotions redirect scenario for verizon',
      'testId': 23,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestUri': '/subscriptions/promotions/lp3FURL.html?ptr=sharethetimes',
      'responseHeaderContains' : {
        'location': 'http://' + suite.servername + '/subscription/promotions/sharethetimes.html?ptr=sharethetimes',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'WCM /subscriptions/promotions redirect scenario for sharethetimes',
      'testId': 24,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestUri': '/subscriptions/promotions/lp3FURL.html?ptr=marathon',
      'responseHeaderContains' : {
        'location': 'http://' + suite.servername + '/subscription/promotions/marathon.html?ptr=marathon',
      },
      'responseStatusCode': [301],
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'scenarioDescription': 'WCM /subscriptions/promotions redirect scenario for marathon',
      'testId': 25,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscriptions/promotions/lp3FURL.html?ptr=newsindia',
      'responseHeaderContains' : {
        'location': 'http://' + suite.servername + '/subscription/promotions/newsindia.html?ptr=newsindia',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'WCM /subscriptions/promotions redirect scenario for newsindia',
      'testId': 26,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/marketing/gdpr/tests/fastly.html?test1=test1',
      'responseHeaderContains' : {
        'x-nyt-final-url': '/marketing/gdpr/tests/fastly.html?test1=test1',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm-params',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM /marketing/gdpr headers test, query params preserved',
      'testId': 27,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/marketing/moco/tests/fastly.html?test1=test1',
      'responseHeaderContains' : {
        'x-nyt-final-url': '/marketing/moco/tests/fastly.html?test1=test1',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm-params',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM /marketing/moco headers test, query params preserved',
      'testId': 28,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': false,
      },
      'requestHeaders': {
        'Fastly-Debug': 1
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/tests/nginxfastly/test-request-header.html',
      'responseHeaderPattern': {
        'vary': /X-NYT-Subscriber/,
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "X-NYT-Subscriber vary" header presence test',
      'testId': 29,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': false,
      },
      'requestHeaders': {
        'Fastly-Debug': 1
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/tests/nginxfastly/test-request-header.html',
      'responseHeaderPattern': {
        'vary': /X-NYT-Device/,
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "X-NYT-Device vary" header presence test',
      'testId': 30,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/tests/nginxfastly/lp8HYKU.html',
      'requestHeaderCookie': 'mwcm_exclude_optimizely=true',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-final-url': '/subscription/tests/nginxfastly/lp8HYKU.html?exclude_optimizely=true',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "checks presence of cookie:mwcm_exclude_optimizely and addes qs exclude_optimizely"',
      'testId': 31,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/tests/nginxfastly/lp8HYKU.html',
      'requestHeaderCookie': 'mwcm_exclude_jsonkidd=true',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-final-url': '/subscription/tests/nginxfastly/lp8HYKU.html?exclude_jsonkidd=true',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "checks presence of cookie:mwcm_exclude_jsonkidd and addes qs exclude_optimizely"',
      'testId': 32,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/tests/nginxfastly/lp8HYKU.html',
      'requestHeaderCookie': ['mwcm_exclude_jsonkidd=true', 'mwcm_exclude_optimizely=true'],
      'responseHeaderPattern': {
        'x-nyt-final-url': /exclude_jsonkidd=true/,
        'x-nyt-final-url': /exclude_optimizely=true/,
        'x-nyt-final-url': /subscription\/tests\/nginxfastly\/lp8HYKU\.html/,
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "checks presence of cookie:mwcm_exclude_jsonkidd adds qs exclude_jsonkidd=true"',
      'testId': 33,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'requestHeaderCookie': 'mwcm_exclude_optimizely=true',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-final-url': '/subscription/hd/1041.html',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "ignores the cookie:exclude_optimizely=true for hd pages and does not add the exclude_optimizely qs parameter"',
      'testId': 34,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'requestHeaderCookie': 'mwcm_exclude_jsonkidd=true',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-final-url': '/subscription/hd/1041.html',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "ignores the cookie:mwcm_exclude_jsonkidd=true for hd pages and does not add the exclude_jsonkidd qs parameter"',
      'testId': 35,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/exo/tests/fastly.html?test1=test1',
      'responseHeaderContains' : {
        'x-nyt-final-url': '/subscription/exo/tests/fastly.html?test1=test1',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm-params',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM /subscription/exo headers test, query params preserved',
      'testId': 36,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'requestHeaderCookie': 'nyt-m=D003BE2989BA6B4476E9EF81AC17234A&e=i.1370059200&t=i.10&v=i.10&l=l.25.3767397534.187745581.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1.-1&n=i.2&g=i.5&er=i.1366659192&vr=l.4.18.0.0.0&pr=l.4.305.0.0.0&vp=i.0&gf=l.10.3767397534.187745581.-1.-1.-1.-1.-1.-1.-1.-1&ft=i.0&fv=i.0&gl=l.5.-1.-1.-1.-1.-1&cav=i.16&imu=i.1&igu=i.1&iue=i.0&ier=i.0&iru=i.0&ifpv=i.0&isr=i.0&imv=i.1&igv=i.0&igav=i.0',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-gateway-hits': '5',
        'x-nyt-metered-hits': '10',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription nyt-m cookie:sets X-NYT-Metered-Hits and X-NYT-Gateway-Hits',
      'testId': 37,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1,
        'Referer': 'https://www.nytimes.com/subscription/multiproduct/lp8HYKU.com'
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-referer': 'subscription',
        'x-nyt-targeting-source': 'lp',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription referer targeting: sets subscription if nytimes.com/subscription/*',
      'testId': 38,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1,
        'Referer': 'https://www.facebook.com'
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-referer': 'facebook',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription referer targeting: sets facebook if facebook.com',
      'testId': 39,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1,
        'Referer': 'https://www.google.com'
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-referer': 'google',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription referer targeting: sets google if google.com',
      'testId': 40,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-device': 'desktop',
        'x-nyt-subscriber': 'false',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription sets x-nyt-subscriber="false" if NYT-S cookie is not presents',
      'testId': 41,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1,
      },
      'requestScheme': 'https://',
      'requestHeaderCookie': 'NYT-S=somehash',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-subscriber': 'true',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription sets x-nyt-subscriber="true" if NYT-S cookie presents',
      'testId': 42,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/marketing/mpc/tests/fastly.html?test1=test1',
      'responseHeaderContains' : {
        'x-nyt-final-url': '/marketing/mpc/tests/fastly.html?test1=test1',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm-params',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM /marketing/mpc headers test, query params preserved',
      'testId': 43,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'scenarioDescription': 'WCM /subscription.html headers test, x-nyt-route=mwcm',
      'testId': 44,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'scenarioDescription': 'WCM /subscription headers test, x-nyt-route=mwcm',
      'testId': 45,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription?testparam=test',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'scenarioDescription': 'WCM /subscription headers test, x-nyt-route=mwcm',
      'testId': 46,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1,
        'Referer': 'https://www.nytimes.com'
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-targeting-source': 'hp',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription source targeting: sets "hp" if the referer is nytimes.com',
      'testId': 47,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1,
        'Referer': 'https://www.nytimes.com/'
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-targeting-source': 'hp',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription source targeting: sets "hp" if the referer is nytimes.com/',
      'testId': 48,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1,
        'Referer': 'https://www.nytimes.com/2011/03/13/business/13hire.html'
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-targeting-source': 'nyt5',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription source targeting: sets "nyt5" if the referer is nytimes.com/(18[5-9][0-9]|19[0-9][0-9]|200[0-9]|201[0-3])/',
      'testId': 49,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1,
        'Referer': 'https://www.nytimes.com/2018/09/25/world/americas/united-nations-general-assembly-live-updates.html'
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-targeting-source': 'vi',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription source targeting: sets "vi" if the referer is nytimes.com/201[4-9]/',
      'testId': 50,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Fastly-Debug': 1,
        'Referer': 'https://www.nytimes.com/interactive/2017/12/21/us/2017-year-in-graphics.html'
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-targeting-source': 'ip',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription source targeting: sets "ip" if the referer is nytimes.com/interactive/',
      'testId': 51,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/tests/nginxfastly/lp8HYKU.html?campaignId=123XY&promoDate=20181212&skipFastly=true&test1=test1',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-nyt-final-url': '/subscription/tests/nginxfastly/lp8HYKU.html?campaignId=123XY&promoDate=20181212&skipFastly=true',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "allows campaignId, skipFastly and promoDate qs string params to mwcm backend and strips test1 qs param"',
      'testId': 52,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/tests/nginxfastly/lp8HYKU.html?skipFastly=true',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'x-cache': 'MISS',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription "cache type should be MISS if skipFastly=true qs && x-nyt-nyhq-access flag present"',
      'testId': 52,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/marketing/account/tests/fastly.html?test1=test1',
      'responseHeaderContains' : {
        'x-nyt-final-url': '/marketing/account/tests/fastly.html?test1=test1',
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm-params',
        'x-nyt-backend': 'mwcm',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM /marketing/tests headers test, query params preserved',
      'testId': 53,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'requestHeaders': {
        'Origin': 'http://www.vi.nytimes.com:3000'
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'access-control-allow-origin': 'http://www.vi.nytimes.com:3000',
        'access-control-allow-credentials': 'true',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription CORS test',
      'testId': 54,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'requestHeaders': {
        'Origin': 'null'
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'access-control-allow-origin': '*',
        'access-control-allow-credentials': 'true',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription CORS test - should not fail if no origin header or origin has a null value',
      'testId': 55,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
        'access-control-allow-origin': '*',
        'access-control-allow-credentials': 'true',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription CORS test - should not fail if no origin header or origin has a null value',
      'testId': 56,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/subscription/hd/1041.html',
      'requestHeaders': {
        'Origin': 'http://www.facebook.com'
      },
      'responseHeaderMatches': {
        'x-nyt-route': 'mwcm',
        'x-nyt-backend': 'mwcm',
      },
      'responseHeadersNotPresent': [
        'access-control-allow-origin',
        'access-control-allow-credentials'
      ],
      'responseStatusCode': [200],
      'scenarioDescription': 'WCM subscription CORS should fail if its not a nytimes domain/sub-domain',
      'testId': 57,
    },
  ];

  return scenarios;
}
