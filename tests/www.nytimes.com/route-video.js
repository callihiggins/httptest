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
      'id':  'Functional Test For Video Library',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'video-library',
      },
      'requestScheme': 'https://',
      'requestUri': '/video/sciencetake',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a video library page',
      'testId': 1,
    },
    {
      'id':  'Functional Test For Video Library Homepage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'video-library',
      },
      'requestScheme': 'https://',
      'requestUri': '/video?param=1',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting the video library homepage with a query string at the end',
      'testId': 2,
    },
    {
      'id':  'Functional Test For Video API',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'video-api',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/video/api/v3/video/100000002883899',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting a /svc/video endpoint',
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
      'requestHeaders': {
          'Fastly-Debug': '1',
      },
      'requestScheme': 'https://',
      'requestUri': '/video-media/360/video.min.js',
      'responseHeaderMatches': {
        'x-frame-options': 'DENY',
        'content-type': 'application/x-javascript',
        'x-api-version': 'F-VM',
      },
      'responseHeadersPresent': [
        'age',
        'x-cache',
        'x-cache-hits',
        'x-served-by',
      ],
      'responseHeadersNotPresent': [
        'via',
        'x-powered-by',
        'x-age',
        'x-varnish',
        'x-origin-server',
        'x-varnishcacheduration',
      ],
      'responseStatusCode': 200,
      'scenarioDescription': 'Test /video-media routing',
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
      'requestHeaders': {
        'Fastly-Debug': '1',
      },
      'requestScheme': 'https://',
      'requestUri': '/video-media/hls/2017/03/27/38483_1_arconic-fiction-video_v1_wg/segment-2-f2-v1-a1.ts',
      'responseHeaderMatches': {
        'x-frame-options': 'DENY',
        'content-type': 'video/MP2T',
        'surrogate-key': 'video/38483 video/chop-chop',
        'x-api-version': 'F-VM',
      },
      'responseHeadersPresent': [
        'age',
        'x-cache',
        'x-cache-hits',
        'x-served-by',
      ],
      'responseHeadersNotPresent': [
        'via',
        'x-powered-by',
        'x-age',
        'x-varnish',
        'x-origin-server',
        'x-varnishcacheduration',
      ],
      'responseStatusCode': 200,
      'scenarioDescription': 'Test /video-media routing',
      'testId': 5,
    },
    {
      'id':  'Functional Test For Video Offsite Player',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'responseHeaderMatches': {
        'x-pagetype': 'video-offsite-player',
      },
      'requestScheme': 'https://',
      'requestUri': '/video/players/offsite/index.html?videoId=100000003586257',
      'responseStatusCode': 200,
      'scenarioDescription': 'Test hitting the video offsite player',
      'testId': 6,
    },
  ];
  return scenarios;
}
