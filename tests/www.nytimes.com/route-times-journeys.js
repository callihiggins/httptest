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
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-nyt-route': 'times-journeys',
      },
      'scenarioDescription': 'Test Times Journeys; landing page, canonical',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-nyt-route': 'times-journeys',
      },
      'scenarioDescription': 'Test Times Journeys; landing page, non-canonical variant 1',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/timesjourneys/',
      'responseHeaderMatches': {
        'x-nyt-backend': "blogs",
      },
      'scenarioDescription': 'Test Times Journeys; landing page, non-canonical variant 2',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/timesjourneys',
      'responseHeaderMatches': {
        'x-nyt-backend': "blogs",
      },
      'scenarioDescription': 'Test Times Journeys; landing page, non-canonical variant 3',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-nyt-route': 'times-journeys',
      },
      'scenarioDescription': 'Test Times Journeys; landing page; identity cookies are set',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'foo=' + suite.cookies.is_16k,
      ],
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-nyt-route': 'times-journeys',
      },
      'scenarioDescription': 'Test Times Journeys; landing page; 16k+ cookie string',
      'testId': 6,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys?queryparam=123',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-nyt-route': 'times-journeys',
      },
      'scenarioDescription': 'Test Times Journeys; landing page; with query params',
      'testId': 7,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/students/',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-nyt-route': 'times-journeys-students',
      },
      'scenarioDescription': 'Test Times Journeys Students; landing page, canonical',
      'testId': 8,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/students',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-nyt-route': 'times-journeys-students',
      },
      'scenarioDescription': 'Test Times Journeys Students; landing page, non-canonical variant 1',
      'testId': 9,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/timesjourneys/students/',
      'responseHeaderMatches': {
        'x-nyt-backend': "blogs",
      },
      'scenarioDescription': 'Test Times Journeys Students; landing page, non-canonical variant 2',
      'testId': 10,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/timesjourneys/students',
      'responseHeaderMatches': {
        'x-nyt-backend': "blogs",
      },
      'scenarioDescription': 'Test Times Journeys Students; landing page, non-canonical variant 3',
      'testId': 11,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/students/',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-nyt-route': 'times-journeys-students',
      },
      'scenarioDescription': 'Test Times Journeys Students; landing page; identity cookies are set',
      'testId': 12,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaderCookie': [
        'foo=' + suite.cookies.is_16k,
      ],
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/students/',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-nyt-route': 'times-journeys-students',
      },
      'scenarioDescription': 'Test Times Journeys Students; landing page; 16k+ cookie string',
      'testId': 13,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestQueryString': '',
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/students?queryparam=123',
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-nyt-route': 'times-journeys-students',
      },
      'scenarioDescription': 'Test Times Journeys Students; landing page; with query params',
      'testId': 14,
    },
    {
      'id':  'Functional Test For Allowing Terms and Conditions in iframe',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'responseHeaderMatches': {
        'x-api-version': 'F-TJ',
        'x-nyt-route': 'times-journeys',
      },
      'responseHeadersNotPresent': [
        'x-frame-options',
      ],
      'requestScheme': 'https://',
      'requestUri': '/times-journeys/travel/behind-the-scenes-of-new-york-theater/terms/',
      'scenarioDescription': 'Test missing x-frame-options from times-journeys',
      'testId': 15,
    },
  ];

  return scenarios;
}
