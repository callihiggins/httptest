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
      'requestUri': '/2017/07/06/automobiles/trump-in-poland-urges-west-to-defend-our-civilization.html',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
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
      'requestUri': '/2017/07/06/automobiles/trump-in-poland-urges-west-to-defend-our-civilization.html',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
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
      'requestUri': '/2017/07/06/automobiles/trump-in-poland-urges-west-to-defend-our-civilization.html?abra=WP_ProjectVi_Story=st',
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
      'requestUri': '/2017/07/06/automobiles/trump-in-poland-urges-west-to-defend-our-civilization.html?abra=WP_ProjectVi_Story=horse',
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
        'dev': false,
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
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
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
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
        'fastly-restarts': '1',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with a fancy header. Allocated',
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
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with a fancy header. Not Allocated',
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
      'requestUri': '/2016/01/04/science/year-of-the-horse-or-year-of-the-horse-seeker.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
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
      'requestUri': '/2016/01/04/science/year-of-the-horse-or-year-of-the-horse-seeker.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with no fancy header. Not Allocated',
      'testId': 12,
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
      'requestUri': '/2016/07/28/automobiles/tim-kaines-dad-style-makes-a-statement-in-philadelphia.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with a fancy header. Allocated',
      'testId': 13,
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
      'requestUri': '/2016/07/28/automobiles/tim-kaines-dad-style-makes-a-statement-in-philadelphia.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with a fancy header. Not Allocated',
      'testId': 14,
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
      'requestUri': '/reuters/2017/10/08/world/americas/08reuters-storm-nate.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200, 410],
      'scenarioDescription': 'Wire article outside correct date range. Not Allocated',
      'testId': 15,
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
      'requestUri': '/reuters/2017/10/08/world/americas/08reuters-storm-nate.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200, 410],
      'scenarioDescription': 'Wire article outside correct date range. Allocated',
      'testId': 16,
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
      'requestUri': '/aponline/2017/10/16/us/ap-us-harvey-weinstein.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200, 410],
      'scenarioDescription': 'Wire article in correct date range. Not Allocated',
      'testId': 17,
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
      'requestUri': '/aponline/2017/10/16/us/ap-us-harvey-weinstein.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-VI',
      },
      'responseStatusCode': [200, 410],
      'scenarioDescription': 'Wire article in correct date range. Allocated',
      'testId': 18,
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
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
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
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
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
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
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
      'requestUri': '/2017/10/11/theater/denise-gough-st-anns-warehouse-angels-in-america.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
        'fastly-restarts': '1',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with a fancy header. Allocated',
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
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK in correct date range with a fancy header. Not Allocated',
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
      'requestUri': '/2015/01/16/science/earth/study-raises-alarm-for-health-of-ocean-life.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
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
      'requestUri': '/2015/01/16/science/earth/study-raises-alarm-for-health-of-ocean-life.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with no fancy header. Not Allocated',
      'testId': 1200,
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
      'requestUri': '/2016/09/25/opinion/sunday/hillary-clinton-for-president.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with a fancy header. Allocated',
      'testId': 1300,
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
      'requestUri': '/2016/09/25/opinion/sunday/hillary-clinton-for-president.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Non-OAK outside correct date range with a fancy header. Not Allocated',
      'testId': 1400,
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
      'requestUri': '/aponline/2017/10/08/sports/football/ap-fbn-seahawks-rams.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200, 410],
      'scenarioDescription': 'Wire article outside correct date range. Not Allocated',
      'testId': 1500,
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
      'requestUri': '/aponline/2017/10/08/sports/football/ap-fbn-seahawks-rams.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200, 410],
      'scenarioDescription': 'Wire article outside correct date range. Allocated',
      'testId': 1600,
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
      'requestUri': '/aponline/2017/10/16/us/ap-us-harvey-weinstein.html?abra=WP_ProjectVi_Story=horse',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-5-5',
      },
      'responseStatusCode': [200, 410],
      'scenarioDescription': 'Wire article in correct date range. Not Allocated',
      'testId': 1700,
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
      'requestUri': '/aponline/2017/10/16/us/ap-us-harvey-weinstein.html?abra=WP_ProjectVi_Story=st',
      'responseHeaderPattern': {
        'set-cookie': /\bvistory=[abcz][012][0-9];/,
      },
      'responseHeaderContains': {
        'x-api-version': 'F-VI',
      },
      'responseStatusCode': [200, 410],
      'scenarioDescription': 'Wire article in correct date range. Allocated',
      'testId': 1800,
    },
  ];

  return scenarios;
}
