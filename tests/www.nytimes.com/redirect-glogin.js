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
      'requestHeaderCookie': [
        'NYT-BCET=' + suite.cookies.nyt_bcet,
        'NYT-S=' + suite.cookies.nyt_s_invalid,
      ],
      'requestHeaders': {
        'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Mobile/14E304 [FBAN/FBIOS;FBAV/88.1.0.64.70;FBBV/55330959;FBDV/iPhone8,1;FBMD/iPhone;FBSN/iOS;FBSV/10.3.1;FBSS/2;FBCR/AT&T;FBID/phone;FBLC/en_US;FBOP/5;FBRV/55506002',
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/10/11/slug.html?nytmobile=0',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Facebook Native in-app browser does not redirect to glogin: iOS',
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
      'requestHeaderCookie': [
        'NYT-BCET=' + suite.cookies.nyt_bcet,
        'NYT-S=' + suite.cookies.nyt_s_invalid,
      ],
      'requestHeaders': {
        'User-Agent': 'Mozilla/5.0 (Linux; Android 7.0; E6653 Build/32.3.A.2.33; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/57.0.2987.132 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/119.0.0.23.70',
      },
      'requestScheme': 'https://',
      'requestUri': '/2016/10/11/slug.html?nytmobile=0',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Facebook Native in-app browser does not redirect to glogin: Android',
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
      'requestHeaderCookie': [
        'NYT-BCET=' + suite.cookies.nyt_bcet,
        'NYT-S=' + suite.cookies.nyt_s_invalid,
      ],
      'requestHeaderCookie': [
        'NYT-S=4sdkjasjdlkjaslkdjalksjdkasjd', // setting bogus cookie here to make this non-anonymous
      ],
      'requestScheme': 'https://',
      'requestUri': '/2015/08/02/education/edlife/four-steps-to-choosing-a-career-path.html?_r=0&GLS=1590843953%7Cz1fxF9cXL5SqGJTUwaFuYdcYQNVR53n9%2BN95mIcjRNM%3D&abra=WP_ProjectVi_www_hp=0',
      'responseHeaderMatches': {
        'x-pagetype': 'article',
      },
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'glogin down valid GLS paramter does NOT redirect to /glogin',
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
      'requestHeaderCookie': [
        'NYT-BCET=' + suite.cookies.nyt_bcet,
        'NYT-S=' + suite.cookies.nyt_s_invalid,
      ],
      'requestHeaderCookie': [
        'NYT-S=4sdkjasjdlkjaslkdjalksjdkasjd', // setting bogus cookie here to make this non-anonymous
      ],
      'requestScheme': 'https://',
      'requestUri': '/2015/08/02/education/edlife/four-steps-to-choosing-a-career-path.html?_r=0&GLS=159084393%7Cz1fxF9cXL5SqGJTUwaFuYdcYQNVR53n9%2BN95mIcjRNM%3D&abra=WP_ProjectVi_www_hp=0',
      'responseHeaderMatches': {
        'x-api-version': 'F-0',
        'location': 'https://' + suite.hosts.glogin + '/glogin?URI=' + encodeURIComponent('https://' + suite.servername + '/2015/08/02/education/edlife/four-steps-to-choosing-a-career-path.html?_r=1&GLS=159084393%7Cz1fxF9cXL5SqGJTUwaFuYdcYQNVR53n9%2BN95mIcjRNM%3D&abra=WP_ProjectVi_www_hp=0'),
      },
      'responseStatusCode': 303,
      'scenarioDescription': 'glogin down invalid GLS parameter DOES redirect to /glogin',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'NYT-BCET=' + suite.cookies.nyt_bcet,
        'NYT-S=' + suite.cookies.nyt_s_invalid,
      ],
      'requestHeaders': {
        'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0_3 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) nytios',
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/2017/02/09/upshot/100000004922380.app.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Interactive .app.html does not redirect to glogin: iOS',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': false,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'NYT-BCET=' + suite.cookies.nyt_bcet,
        'NYT-S=' + suite.cookies.nyt_s_invalid,
      ],
      'requestHeaders': {
        'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0_3 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) nytios',
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/2017/02/09/upshot/100000004922380.embedded.html',
      'responseHeaderPattern': {
        'x-api-version': /F-(GA|5-5)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Interactive .app.html does not redirect to glogin: iOS',
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
      'requestHeaderCookie': [
        'NYT-BCET=' + suite.cookies.nyt_bcet,
        'NYT-S=' + suite.cookies.nyt_s_invalid,
      ],
      'requestHeaders': {
        'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0_3 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) nytios',
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/2017/multimedia/100000005059100.app.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-VI',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Interactive .app.html does not redirect to glogin: iOS',
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
        'NYT-S=' + suite.cookies.nyt_s_invalid,
      ],
      'requestHeaders': {
        'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0_3 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) nytios',
      },
      'requestScheme': 'https://',
      'requestUri': '/interactive/2017/admin/100000005250034.embedded.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-VI',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Interactive .app.html does not redirect to glogin: iOS',
      'testId': 8,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'NYT-BCET=' + suite.cookies.nyt_bcet,
        'NYT-S=' + suite.cookies.nyt_s_invalid,
      ],
      'requestScheme': 'https://',
      'requestUri': '/vi-assets/dummy-url-do-not-redirect-to-glogin.css',
      'responseHeaderPattern': {
        'x-nyt-backend': /^projectvi_asset/,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'vi-asset',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'vi-asset route does not redirect to glogin',
      'testId': 9,
    },
  ];

  return scenarios;
}
