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
      'requestScheme': 'https://',
      'requestUri': '/2016/11/04/homepage/new-york-times-open-access-election-2016.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'Test routing; article; NYT5; /2016/11/04/homepage/new-york-times-open-access-election-2016.html',
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
      'requestScheme': 'http://',
      'requestUri': '/2004/01/09/us/2004-campaign-fund-raising-financial-firms-are-bush-s-biggest-donors-study.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'x-nyt-backend': /(article_fe|www_fe)/
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test routing; article; NYT5; /2004/01/09/us/2004-campaign-fund-raising-financial-firms-are-bush-s-biggest-donors-study.html',
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
      'requestScheme': 'http://',
      'requestUri': '/2005/03/01/business/worldbusiness/chinas-oil-diplomacy-in-latin-america.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'x-nyt-backend': /(article_fe|www_fe)/
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test routing; article; NYT5; /2005/03/01/business/worldbusiness/chinas-oil-diplomacy-in-latin-america.html',
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
      'requestScheme': 'http://',
      'requestUri': '/1959/01/11/archives/sports-of-the-times-forecast-for-1959.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'x-nyt-backend': /(article_fe|www_fe)/
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test routing; article; NYT5; /1959/01/11/archives/sports-of-the-times-forecast-for-1959.html',
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
      'requestScheme': 'http://',
      'requestUri': '/1964/01/01/mexico-tightens-control-of-semipublic-concerns.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test routing; article; NYT5; /1964/01/01/mexico-tightens-control-of-semipublic-concerns.html',
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
      'requestScheme': 'http://',
      'requestUri': '/1979/01/01/archives/carolyn-spiro-married-to-gregory-j-cannata.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'x-nyt-backend': /(article_fe|www_fe)/
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test routing; article; NYT5; /1979/01/01/archives/carolyn-spiro-married-to-gregory-j-cannata.html',
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
      'requestScheme': 'http://',
      'requestUri': '/2001/01/20/technology/20ANNIVERSARY.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'x-nyt-backend': /(article_fe|www_fe)/
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [301,404],
      'scenarioDescription': 'Test routing; article; NYT5; redirect; /2001/01/20/technology/20ANNIVERSARY.html',
      'testId': 7,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'http://',
      'requestUri': '/2001/01/20/technology/the-new-york-times-five-years-on-the-web.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'x-nyt-backend': /(article_fe|www_fe)/
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test routing; article; NYT5; /2001/01/20/technology/the-new-york-times-five-years-on-the-web.html',
      'testId': 8,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'http://',
      'requestUri': '/2006/01/29/fashion/sundaystyles/29LOVE.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'x-nyt-backend': /(article_fe|www_fe)/
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200,404,301],
      'scenarioDescription': 'Test routing; article; NYT5; /2006/01/29/fashion/sundaystyles/29LOVE.html',
      'testId': 9,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'http://',
      'requestUri': '/2006/02/26/fashion/sundaystyles/26LOVE.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'x-nyt-backend': /(article_fe|www_fe)/
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200,404,301],
      'scenarioDescription': 'Test routing; article; NYT5; /2006/02/26/fashion/sundaystyles/26LOVE.html',
      'testId': 10,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'http://',
      'requestUri': '/2006/11/12/fashion/12love.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test routing; article; NYT5; /2006/11/12/fashion/12love.html',
      'testId': 11,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'http://',
      'requestUri': '/blog/2000/01/01/us/slug.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test routing; article; NYT5; blogpost as article; /blog/2000/01/01/us/slug.html',
      'testId': 12,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'http://',
      'requestUri': '/1850/01/01/us/slug.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'x-nyt-backend': /(article_fe|www_fe)/
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test routing; article; NYT5; /1850/01/01/us/slug.html',
      'testId': 13,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'http://',
      'requestUri': '/1920/01/01/us/slug.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'x-nyt-backend': /(article_fe|www_fe)/
      },
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test routing; article; NYT5; /1920/01/01/us/slug.html',
      'testId': 14,
    },
  ];

  return scenarios;
}
