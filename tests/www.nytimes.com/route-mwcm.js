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
        'dev': true,
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
        'dev': true,
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
        'prd': false,
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
        'prd': false,
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
        'prd': false,
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
  ];

  return scenarios;
}
