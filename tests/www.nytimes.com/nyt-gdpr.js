var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);


/**
 * @return array
 */
function getScenarioEvents()
{
  var scenarios = [

    /*
     *  Various nyt-gdpr sanity checks.
     *  And standalone GDPR service validations.
     */

    {
      'scenarioDescription': 'creates new nyt-gdpr when missing in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'testId': 1,
    },

    {
      'scenarioDescription': 'creates new nyt-gdpr when empty in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestHeaderCookie': [
        'nyt-gdpr=',
      ],
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'testId': 2,
    },

    {
      'scenarioDescription': 'creates new nyt-gdpr when empty among other cookies in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestHeaderCookie': [
        'foo=bar',
        'nyt-gdpr=',
        'argh=blargh',
      ],
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'testId': 3,
    },

    {
      'scenarioDescription': 'suppresses nyt-gdpr when provided in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestHeaderCookie': [
        'nyt-gdpr=1',
      ],
      'requestUri': '/',
      'responseHeadersNotPresent': [
        'x-gdpr',
      ],
      'responseStatusCode': 200,
      'testId': 4,
    },

    {
      'scenarioDescription': 'suppresses nyt-gdpr when provided among other cookies in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': false
      },
      'requestScheme': 'https://',
      'requestHeaderCookie': [
        'foo=bar',
        'nyt-gdpr=0',
        'argh=blargh',
      ],
      'requestUri': '/',
      'responseHeadersNotPresent': [
        'x-gdpr',
      ],
      'responseStatusCode': 200,
      'testId': 5,
    },
    {
      'scenarioDescription': 'force gdpr by query param',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/?gdpr=1',
      'responseHeaderPattern': {
        'x-gdpr': /1/,
      },
      'testId': 6,
    },
    {
      'scenarioDescription': 'force gdpr by query param',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/?gdpr=0',
      'responseHeaderPattern': {
        'x-gdpr': /0/,
      },
      'testId': 7,
    },
    {
      'scenarioDescription': 'GDPR service endpoint',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/gdpr.json',
      'responseHeaderPattern': {
        'x-gdpr': /(0|1)/,
      },
      'responseStatusCode': 200,
      'testId': 8,
    },
    {
      'scenarioDescription': 'GDPR AMP service endpoint. No NYT-T cookie. No nyt-gdpr cookie.',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/amp-consent.json',
      'responseHeaderPattern': {
        'x-nyt-amp-consent': /false/,
      },
      'responseStatusCode': 200,
      'testId': 9,
    },
    {
      'scenarioDescription': 'GDPR AMP service endpoint. No NYT-T cookie. nyt-gdpr=0 cookie.',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/amp-consent.json?gdpr=0',
      'requestHeaderCookie': ['nyt-gdpr=0'],
      'responseHeaderPattern': {
        'x-nyt-amp-consent': /false/,
      },
      'responseStatusCode': 200,
      'testId': 10,
    },
    {
      'scenarioDescription': 'GDPR AMP service endpoint. No NYT-T cookie. nyt-gdpr=1 cookie.',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/amp-consent.json?gdpr=1',
      'requestHeaderCookie': ['nyt-gdpr=1'],
      'responseHeaderPattern': {
        'x-nyt-amp-consent': /true/,
      },
      'responseStatusCode': 200,
      'testId': 11,
    },
    {
      'scenarioDescription': 'GDPR AMP service endpoint. NYT-T=ok cookie. nyt-gdpr=0 cookie.',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/amp-consent.json?gdpr=0',
      'requestHeaderCookie': ['NYT-T=ok', 'nyt-gdpr=0'],
      'responseHeaderPattern': {
        'x-nyt-amp-consent': /false/,
      },
      'responseStatusCode': 200,
      'testId': 12,
    },
    {
      'scenarioDescription': 'GDPR AMP service endpoint. NYT-T=ok cookie. nyt-gdpr=1 cookie.',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/amp-consent.json?gdpr=1',
      'requestHeaderCookie': ['NYT-T=ok', 'nyt-gdpr=1'],
      'responseHeaderPattern': {
        'x-nyt-amp-consent': /false/,
      },
      'responseStatusCode': 200,
      'testId': 13,
    },
    {
      'scenarioDescription': 'GDPR AMP service endpoint. NYT-T=out cookie. nyt-gdpr=1 cookie.',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/amp-consent.json?gdpr=1',
      'requestHeaderCookie': ['NYT-T=out', 'nyt-gdpr=1'],
      'responseHeaderPattern': {
        'x-nyt-amp-consent': /true/,
      },
      'responseStatusCode': 200,
      'testId': 14,
    },
  ];

  return scenarios;
}
