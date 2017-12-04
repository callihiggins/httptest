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
      'timestamp': 1,
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
      'requestHeaders': {
        'Fastly-Debug': '1',
      },
      'requestScheme': 'https://',
      'requestUri': '/video-media/2017/03/27/38483_1_arconic-fiction-video_v1_wg_hls/segment-2-f2-v1-a1.ts',
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
      'timestamp': 1,
      'testId': 2,
    },
  ];

  return scenarios;
}
