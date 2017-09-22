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
      'requestUri': '/slideshow/2017/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test slideshow; Internal HTTPS enabled',
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
      'requestUri': '/slideshow/2016/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test slideshow; Internal HTTPS enabled',
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
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test slideshow; Internal HTTPS enabled',
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
      'requestUri': '/slideshow/2014/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test slideshow; Internal HTTPS enabled',
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
      'requestScheme': 'http://',
      'requestUri': '/slideshow/2013/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test slideshow; Serve 2013 from NYT4 with HTTP',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestScheme': 'http://',
      'requestUri': '/slideshow/2011/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test slideshow; Serve pre-2014 slideshows on NYT5 with HTTP',
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
      'requestScheme': 'http://',
      'requestUri': '/slideshow/2009/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test slideshow; Serve pre-2014 slideshows on NYT5 with HTTP',
      'testId': 7,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'NYT-BCET=' + suite.cookies.nyt_bcet,
        'NYT-S=' + suite.cookies.nyt_s,
      ],
      'requestScheme': 'http://',
      'requestUri': '/slideshow/2007/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-5',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test slideshow; Serve pre-2014 slideshows on NYT5 with HTTP',
      'testId': 8,
    },
  ];

  return scenarios;
}
