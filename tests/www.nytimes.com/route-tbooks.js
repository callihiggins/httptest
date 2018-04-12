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
      'requestUri': '/tbooks',
      'responseHeaderMatches': {
        'x-pagetype': 'tbooks',
        'x-nyt-backend':'tbooks',
        'x-nyt-force-pass': 'true',
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
        'dev': true,
        'sbx': false,
      },
      'requestScheme': 'https://',
      'requestUri': '/tbooks/book/gawkers-bad-awful-year/',
      'responseHeaderMatches': {
        'x-pagetype': 'tbooks',
        'x-nyt-backend':'tbooks',
        'x-nyt-force-pass': 'true',
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test /tbooks book URL',
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
      'requestUri': '/tbooks?action=click&contentCollection=insider&region=navbar&module=collectionsnav&pagetype=sectionfront&pgtype=sectionfront',
      'responseHeaderMatches': {
        'x-pagetype': 'tbooks',
        'x-nyt-backend':'tbooks',
        'x-nyt-force-pass': 'true',
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test /tbooks book URL with query params',
      'testId': 1,
    },
  ];

  return scenarios;
}