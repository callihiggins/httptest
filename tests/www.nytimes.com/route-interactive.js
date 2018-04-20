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
    'id': 'FunctionalTestScenarioDefinitionForEmbeddedInteractiveWithNytimesUA',
    'isDeployedInEnv': {
      'prd': true,
      'stg': true,
      'dev': true,
      'sbx': false,
    },
    'requestHeaders': {
      'User-Agent': 'NYTimes',
    },
    'requestScheme': 'https://',
    'requestUri': '/interactive/2017/02/09/upshot/100000004922380.embedded.html',
    'responseHeaderMatches': {
      'x-pagetype': 'vi-interactive',
      'x-nyt-backend': 'projectvi_fe',
    },
    'responseHeadersPresent': [
      'age',
      'x-cache',
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
      'x-frame-options',
    ],
    'responseStatusCode': [200,404],
    'scenarioDescription': 'Test NYTimes Embedded Interactive with User-Agent',
    'testId': 1,
  },
  {
    'id': 'FunctionalTestScenarioDefinitionForEmbeddedInteractiveWithoutNytimesUA',
    'isDeployedInEnv': {
      'prd': true,
      'stg': true,
      'dev': true,
      'sbx': false,
    },
    'requestHeaders': {
    },
    'requestScheme': 'https://',
    'requestUri': '/interactive/2017/02/09/upshot/100000004922380.embedded.html',
    'responseHeaderMatches': {
      'x-pagetype': 'vi-interactive',
      'x-nyt-backend': 'projectvi_fe',
    },
    'responseHeadersPresent': [
      'age',
      'x-cache',
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
    'responseStatusCode': [200,404],
    'scenarioDescription': 'Test NYTimes Embedded Interactive Without User-Agent',
    'testId': 2,
  },
  {
    'id': 'FunctionalTestScenarioDefinitionForEmbeddedInteractiveWithReferer',
    'isDeployedInEnv': {
      'prd': true,
      'stg': true,
      'dev': true,
      'sbx': false,
    },
    'requestHeaders': {
      'Referer': 'https://mobile.nytimes.com/2017/02/14/briefing/michael-flynn-opec-india.html',
    },
    'requestScheme': 'https://',
    'requestUri': '/interactive/2016/01/12/us/100000004069963.embedded.html?isHybrid=true',
    'responseHeaderMatches': {
      'x-pagetype': 'vi-interactive',
      'x-nyt-backend': 'projectvi_fe',
    },
    'responseHeadersPresent': [
      'age',
      'x-cache',
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
      'x-frame-options',
    ],
    'responseStatusCode': [200,404],
    'scenarioDescription': 'Test NYTimes Embedded Interactive With Query String Param',
    'testId': 3,
  },
  {
    'id': 'FunctionalTestScenarioDefinitionForStandaloneInteractiveOnVi',
    'isDeployedInEnv': {
      'prd': true,
      'stg': true,
      'dev': true,
      'sbx': false,
    },
    'requestHeaders': {
    },
    'requestScheme': 'https://',
    'requestUri': '/interactive/2017/05/04/travel/what-to-do-36-hours-in-the-golden-triangle-thailand.html',
    'responseHeaderMatches': {
      'x-pagetype': 'vi-interactive',
      'x-nyt-backend': 'projectvi_fe',
    },
    'responseHeadersPresent': [
      'age',
      'x-cache',
      'x-served-by',
      'x-frame-options',
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
    'responseStatusCode': [200,404],
    'scenarioDescription': 'Test NYTimes Interactive served by Vi',
    'testId': 7,
  },
  {
    'id': 'FunctionalTestScenarioDefinitionForStandaloneInteractiveOnVi',
    'isDeployedInEnv': {
      'prd': true,
      'stg': true,
      'dev': true,
      'sbx': false,
    },
    'requestHeaders': {
    },
    'requestScheme': 'https://',
    'requestUri': '/interactive/2017/multimedia/test-interactive-standalone-qa.html',
    'responseHeaderMatches': {
      'x-pagetype': 'vi-interactive',
      'x-nyt-backend': 'projectvi_fe',
    },
    'responseHeadersPresent': [
      'age',
      'x-cache',
      'x-served-by',
      'x-frame-options',
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
    'responseStatusCode': [200,404],
    'scenarioDescription': 'Test NYTimes Interactive served by Vi',
    'testId': 8,
  },
  {
    'id': 'FunctionalTestScenarioDefinitionForEmbeddedInteractiveOnNYT5',
    'isDeployedInEnv': {
      'prd': true,
      'stg': true,
      'dev': true,
      'sbx': false,
    },
    'requestHeaders': {
    },
    'requestScheme': 'https://',
    'requestUri': '/interactive/2016/01/12/us/100000004069963.embedded.html',
    'responseHeaderMatches': {
      'x-pagetype': 'vi-interactive',
      'x-nyt-backend': 'projectvi_fe',
    },
    'responseHeadersPresent': [
      'age',
      'x-cache',
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
    'responseStatusCode': [200,404],
    'scenarioDescription': 'Test NYTimes Embedded Interactive served by NYT5',
    'testId': 9,
  },
  {
    'id': 'FunctionalTestScenarioDefinitionForEmbeddedInteractiveOnVi',
    'isDeployedInEnv': {
      'prd': true,
      'stg': true,
      'dev': true,
      'sbx': false,
    },
    'requestHeaders': {
    },
    'requestScheme': 'https://',
    'requestUri': '/interactive/2017/admin/100000005250034.embedded.html',
    'responseHeaderMatches': {
      'x-pagetype': 'vi-interactive',
      'x-nyt-backend': 'projectvi_fe',
    },
    'responseHeadersPresent': [
      'age',
      'x-cache',
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
    'responseStatusCode': [200,404],
    'scenarioDescription': 'Test NYTimes Embedded Interactive served by Vi',
    'testId': 10,
  },
  {
    'id': 'FunctionalTestScenarioDefinitionForEmbeddedInteractiveOnVi',
    'isDeployedInEnv': {
      'prd': true,
      'stg': true,
      'dev': true,
      'sbx': false,
    },
    'requestHeaders': {
      'Referer': 'https://www.stg.nytimes.com/2017/10/02/automobiles/test-oak-with-embedded-interactive.html',
    },
    'requestScheme': 'https://',
    'requestUri': '/interactive/2017/admin/100000005194102.embedded.html',
    'responseHeaderMatches': {
      'x-pagetype': 'vi-interactive',
      'x-nyt-backend': 'projectvi_fe',
    },
    'responseHeadersPresent': [
      'age',
      'x-cache',
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
      'x-frame-options',
    ],
    'responseStatusCode': [200,404],
    'scenarioDescription': 'Test NYTimes Embedded Interactive Served By Project Vi',
    'testId': 11,
  }
  ];

  return scenarios;
}