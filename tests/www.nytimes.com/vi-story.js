var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);


/**
 * @return array
 */
function getScenarioEvents()
{
  var scenarios = [

    // staging

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'No vistory cookie',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestHeaderCookie': [
        'vistory=',
      ],
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Empty vistory cookie',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[a][012][0-9];/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'abra set story VI cookie using query param',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[z][012][0-9];/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'abra unset story VI cookie using query param',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-VI',
        'x-pagetype': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with no fancy header stuff. Allocated',
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
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with no fancy header stuff. Not Allocated',
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
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/02/23/learning/oak-style-guide.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-VI',
        'x-pagetype': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'OAK article served by VI. Allocated',
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
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/02/23/learning/oak-style-guide.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-VI',
        'x-pagetype': 'vi-story',
        'fastly-restarts': '1',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'OAK article still served by VI. Not Allocated',
      'testId': 8,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/test.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'fastly-restarts': /1/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with compatibility issues. Allocated',
      'testId': 9,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/test.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with compatibility issues. Not Allocated',
      'testId': 10,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2013/10/24/arts/music/christian-mcbride-trio-at-dizzys-club-coca-cola.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with no fancy header. Allocated',
      'testId': 11,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2013/10/24/arts/music/christian-mcbride-trio-at-dizzys-club-coca-cola.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with no fancy header. Not Allocated',
      'testId': 12,
    },

    // Production

    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/07/14/science/sun-cycles-solar-maximum-minimum-corona.html',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'No vistory cookie',
      'testId': 100,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestHeaderCookie': [
        'vistory=',
      ],
      'requestScheme': 'https://',
      'requestUri': '/2017/07/14/science/sun-cycles-solar-maximum-minimum-corona.html',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Empty vistory cookie',
      'testId': 200,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/07/14/science/sun-cycles-solar-maximum-minimum-corona.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[a][012][0-9];/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'abra set story VI cookie using query param',
      'testId': 300,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/07/14/science/sun-cycles-solar-maximum-minimum-corona.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[z][012][0-9];/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'abra unset story VI cookie using query param',
      'testId': 400,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/15/nyregion/harvey-weinstein-new-york-sex-assault-investigation.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-VI',
        'x-pagetype': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with no fancy header stuff. Allocated',
      'testId': 500,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/15/nyregion/harvey-weinstein-new-york-sex-assault-investigation.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with no fancy header stuff. Not Allocated',
      'testId': 600,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/08/26/arts/things-to-do-in-new-york-metropolitan-museum-flume.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-VI',
        'x-pagetype': 'vi-story',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'OAK article served by VI. Allocated',
      'testId': 700,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/08/26/arts/things-to-do-in-new-york-metropolitan-museum-flume.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-VI',
        'x-pagetype': 'vi-story',
        'fastly-restarts': '1',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'OAK article still served by VI. Not Allocated',
      'testId': 800,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2018/01/30/us/politics/trump-state-of-the-union.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
        'fastly-restarts': /1/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with compatibility issues. Allocated',
      'testId': 900,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/11/theater/denise-gough-st-anns-warehouse-angels-in-america.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with compatibility issues. Not Allocated',
      'testId': 1000,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2013/06/25/sports/tennis/tough-first-day-at-wimbledon-for-us-women-despite-stephens-win.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with no fancy header. Allocated',
      'testId': 1100,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaders': {
        'x-nyt-debug': '1'
      },
      'requestScheme': 'https://',
      'requestUri': '/2013/06/25/sports/tennis/tough-first-day-at-wimbledon-for-us-women-despite-stephens-win.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with no fancy header. Not Allocated',
      'testId': 1200,
    },
  ];

  return scenarios;
}
