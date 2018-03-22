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
     *  Various nyt-a sanity checks. We try for at least 128 bits entropy in
     *  the Agent ID, which means 22 chars at 6 bits per char of base64.
     */

    {
      'scenarioDescription': 'creates new nyt-a when missing in request',
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
        'set-cookie': /(?:^|,)nyt-a=[a-zA-Z0-9_-]{22,};/, // tester seems to toString() header array, hence possible `,`
      },
      'responseStatusCode': 200,
      'testId': 1,
    },

    {
      'scenarioDescription': 'creates new nyt-a when empty in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestHeaderCookie': [
        'nyt-a=',
      ],
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-a=[a-zA-Z0-9_-]{22,};/, // enforce 22 character minimum
      },
      'responseStatusCode': 200,
      'testId': 2,
    },

    {
      'scenarioDescription': 'creates new nyt-a when empty among other cookies in request',
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
        'nyt-a=',
        'argh=blargh',
      ],
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-a=[a-zA-Z0-9_-]{22,};/, // enforce 22 character minimum
      },
      'responseStatusCode': 200,
      'testId': 3,
    },

    {
      'scenarioDescription': 'refreshes nyt-a when provided in request',
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestHeaderCookie': [
        'nyt-a=12345',
      ],
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-a=12345;/,
      },
      'responseStatusCode': 200,
      'testId': 4,
    },

    {
      'scenarioDescription': 'refreshes nyt-a when provided among other cookies in request',
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
        'nyt-a=54321',
        'argh=blargh',
      ],
      'requestUri': '/',
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-a=54321;/,
      },
      'responseStatusCode': 200,
      'testId': 5,
    },

  ];

  return scenarios;
}
