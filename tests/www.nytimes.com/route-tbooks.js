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
      'requestScheme': 'https://',
      'requestUri': '/tbooks',
      'responseHeaderMatches': {
        'x-nyt-route': 'tbooks',
        'x-nyt-backend':'tbooks',
        'debug-var-nyt-force-pass': 'false',
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test /tbooks',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/tbooks/book/gawkers-bad-awful-year/',
      'responseHeaderMatches': {
        'x-nyt-route': 'tbooks',
        'x-nyt-backend':'tbooks',
        'debug-var-nyt-force-pass': 'false',
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test /tbooks book URL',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/tbooks?action=click&contentCollection=insider&region=navbar&module=collectionsnav&pagetype=sectionfront&pgtype=sectionfront',
      'responseHeaderMatches': {
        'x-nyt-route': 'tbooks',
        'x-nyt-backend':'tbooks',
        'debug-var-nyt-force-pass': 'false',
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test /tbooks book URL with query params',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestHeaderCookie': 'comment_author_foo=some_test',
      'requestUri': '/tbooks/book/gawkers-bad-awful-year/',
      'responseHeaderMatches': {
        'x-nyt-route': 'tbooks-pass',
        'x-nyt-backend':'tbooks',
        'debug-var-nyt-force-pass': 'true',
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test /tbooks book URL',
      'testId': 4,
    },

  ];

  return scenarios;
}
