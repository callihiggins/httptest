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
        'sbx': false,
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/students/',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-pagetype': 'times-journeys-students',
      },
      'scenarioDescription': 'Test Times Journeys Students; landing page, canonical',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/students',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-pagetype': 'times-journeys-students',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test Times Journeys Students; landing page, non-canonical variant 1',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/timesjourneys/students/',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-TJS',
        'x-pagetype': 'timesjourneysstudents',
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test Times Journeys Students; landing page, non-canonical variant 2',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/timesjourneys/students',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-TJS',
        'x-pagetype': 'timesjourneysstudents',
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test Times Journeys Students; landing page, non-canonical variant 3',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s,
        'NYT-BCET=' + suite.cookies.nyt_bcet,
      ],
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/students/',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-pagetype': 'times-journeys-students',
      },
      'scenarioDescription': 'Test Times Journeys Students; landing page; identity cookies are set',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s,
        'NYT-BCET=' + suite.cookies.nyt_bcet,
        'foo=' + suite.cookies.is_16k,
      ],
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/students/',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-pagetype': 'times-journeys-students',
      },
      'scenarioDescription': 'Test Times Journeys Students; landing page; 16k+ cookie string',
      'testId': 6,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'NYT-S=' + suite.cookies.nyt_s,
        'NYT-BCET=' + suite.cookies.nyt_bcet,
      ],
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/students?queryparam=123',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-pagetype': 'times-journeys-students',
      },
      'scenarioDescription': 'Test Times Journeys Students; landing page; with query params',
      'testId': 6,
    },
  ];

  return scenarios;
}
