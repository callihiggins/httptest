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
      'requestUri': '/slideshow/2017/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
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
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2016/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
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
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
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
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test slideshow; Internal HTTPS enabled',
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
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2013/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-4',
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
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2011/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-4',
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
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2009/01/01/us/slug.html',
      'responseHeaderMatches': {
       'x-api-version': 'F-5-4',
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
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2007/01/01/us/slug.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-5-4',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [404],
      'scenarioDescription': 'Test slideshow; Serve pre-2014 slideshows on NYT5 with HTTP',
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
      'requestHeaderCookie': [
        'nyt.dv.nyt5-on-gke.slideshow=1',
      ],
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2017/09/17/fashion/emmys-2017-red-carpet-dresses/s/17REDCARPETEMMY2.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test slideshow; Internal HTTPS enabled, /slideshow/2017/09/17/fashion/emmys-2017-red-carpet-dresses/s/17REDCARPETEMMY2.html ',
      'testId': 101,
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
        'nyt.dv.nyt5-on-gke.slideshow=1',
      ],
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2016/12/14/travel/our-favorite-travel-photography-of-2016/s/18BEST-OF-2016-IMAGES-slide-8RFM.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test slideshow; Internal HTTPS enabled, /slideshow/2016/12/14/travel/our-favorite-travel-photography-of-2016/s/18BEST-OF-2016-IMAGES-slide-8RFM.html',
      'testId': 102,
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
        'nyt.dv.nyt5-on-gke.slideshow=1',
      ],
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2015/12/25/t-magazine/oddball-geniuses-tarantino-fassbender-rampling/s/25tmag-11well_rihanna-t_CA0-copy.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test slideshow; Internal HTTPS enabled, /slideshow/2015/12/25/t-magazine/oddball-geniuses-tarantino-fassbender-rampling/s/25tmag-11well_rihanna-t_CA0-copy.html',
      'testId': 103,
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
        'nyt.dv.nyt5-on-gke.slideshow=1',
      ],
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2014/09/21/upshot/23up-un/s/21up-un-slide-ZRTJ.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test slideshow; Internal HTTPS enabled, /slideshow/2014/09/21/upshot/23up-un/s/21up-un-slide-ZRTJ.html',
      'testId': 104,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'nyt.dv.nyt5-on-gke.slideshow=1',
      ],
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2013/12/25/dining/20131225-REST.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test slideshow; Serve 2013 from NYT4 with HTTP, /slideshow/2013/12/25/dining/20131225-REST.html',
      'testId': 105,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'nyt.dv.nyt5-on-gke.slideshow=1',
      ],
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2011/07/10/world/africa/10sudan.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test slideshow; Serve pre-2014 slideshows on NYT5 with HTTP, /slideshow/2011/07/10/world/africa/10sudan.html',
      'testId': 106,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'nyt.dv.nyt5-on-gke.slideshow=1',
      ],
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2009/04/27/science/042809-Ants_index.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test slideshow; Serve pre-2014 slideshows on NYT5 with HTTP, /slideshow/2009/04/27/science/042809-Ants_index.html',
      'testId': 107,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': [
        'nyt.dv.nyt5-on-gke.slideshow=1',
      ],
      'requestScheme': 'https://',
      'requestUri': '/slideshow/2007/10/10/nytfrontpage/20071010POD_7.html',
      'responseHeaderMatches': {
        'x-api-version': 'F-GS',
        'x-pagetype': 'slideshow',
      },
      'responseStatusCode': [200,404],
      'scenarioDescription': 'Test slideshow; Serve pre-2014 slideshows on NYT5 with HTTP, /slideshow/2007/10/10/nytfrontpage/20071010POD_7.html',
      'testId': 108,
    },
  ];

  return scenarios;
}
