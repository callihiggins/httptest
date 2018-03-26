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
     *  Various nyt-gdpr sanity checks. We try for at least 128 bits entropy in
     *  the Agent ID, which means 22 chars at 6 bits per char of base64.
     */

    {
      'scenarioDescription': 'creates new nyt-gdpr when missing in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': 200,
      'testId': 1,
    },

    {
      'scenarioDescription': 'creates new nyt-gdpr when empty in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestHeaderCookie': [
        'nyt-gdpr=',
      ],
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': 200,
      'testId': 2,
    },

    {
      'scenarioDescription': 'creates new nyt-gdpr when empty among other cookies in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
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
      'responseStatusCode': 200,
      'testId': 3,
    },

    {
      'scenarioDescription': 'refreshes nyt-gdpr when provided in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestHeaderCookie': [
        'nyt-gdpr=1',
      ],
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=1;/,
      },
      'responseStatusCode': 200,
      'testId': 4,
    },

    {
      'scenarioDescription': 'refreshes nyt-gdpr when provided among other cookies in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestHeaderCookie': [
        'foo=bar',
        'nyt-gdpr=0',
        'argh=blargh',
      ],
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=0;/,
      },
      'responseStatusCode': 200,
      'testId': 5,
    },

  ];

  return scenarios;
}
