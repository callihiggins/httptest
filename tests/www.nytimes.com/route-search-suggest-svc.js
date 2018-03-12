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
      'id': 'FunctionalTestScenarioDefinitionForService Search Suggest',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
      },
      'requestHeaders': {
        'authorization': 'Basic ThisShouldCauseAFastlyPass',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/suggest/v1/timestags?query=foo',
      'responseHeaderPattern': {
        'x-pagetype': /(search-suggest|legacy)/,
        'x-nyt-backend': /(search_suggest|www_https)/,
      },
      'responseHeaderMatches': {
        'x-cache': 'MISS',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'route-search-suggest-svc: ensure Fastly pass; /svc/suggest/v1/timestags?query=foo',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
      },
      'requestHeaders': {
        'authorization': 'Basic ThisShouldCauseAFastlyPass',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/suggest/v1/timestags?query=obama',
      'responseHeaderPattern': {
        'x-pagetype': /(search-suggest|legacy)/,
        'x-nyt-backend': /(search_suggest|www_https)/,
      },
      'responseHeaderMatches': {
        'x-cache': 'MISS',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'route-search-suggest-svc: ensure Fastly pass; /svc/suggest/v1/timestags?query=obama',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': false,
      },
      'requestHeaders': {
        'authorization': 'Basic ThisShouldCauseAFastlyPass',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/suggest/v1/timestags?query=fart',
      'responseHeaderPattern': {
        'x-pagetype': /(search-suggest|legacy)/,
        'x-nyt-backend': /(search_suggest|www_https)/,
      },
      'responseHeaderMatches': {
        'x-cache': 'MISS',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'route-search-suggest-svc: ensure Fastly pass; /svc/suggest/v1/timestags?query=fart',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForService Search Suggest',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': true,
      },
      'requestHeaders': {
        'authorization': 'Basic ThisShouldCauseAFastlyPass',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/suggest/v1/timestags?query=foo',
      'responseHeaderPattern': {
        'x-pagetype': /(search-suggest)/,
        'x-nyt-backend': /(search_suggest)/,
      },
      'responseHeaderMatches': {
        'x-cache': 'MISS',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'route-search-suggest-svc: ensure Fastly pass; /svc/suggest/v1/timestags?query=foo',
      'testId': 101,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': true,
      },
      'requestHeaders': {
        'authorization': 'Basic ThisShouldCauseAFastlyPass',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/suggest/v1/timestags?query=obama',
      'responseHeaderPattern': {
        'x-pagetype': /(search-suggest)/,
        'x-nyt-backend': /(search_suggest)/,
      },
      'responseHeaderMatches': {
        'x-cache': 'MISS',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'route-search-suggest-svc: ensure Fastly pass; /svc/suggest/v1/timestags?query=obama',
      'testId': 102,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': false,
        'stg': false,
        'dev': true,
      },
      'requestHeaders': {
        'authorization': 'Basic ThisShouldCauseAFastlyPass',
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/suggest/v1/timestags?query=fart',
      'responseHeaderPattern': {
        'x-pagetype': /(search-suggest)/,
        'x-nyt-backend': /(search_suggest)/,
      },
      'responseHeaderMatches': {
        'x-cache': 'MISS',
      },
      'responseStatusCode': [200, 404],
      'scenarioDescription': 'route-search-suggest-svc: ensure Fastly pass; /svc/suggest/v1/timestags?query=fart',
      'testId': 103,
    },    
  ];
  return scenarios;
}