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
      },
      'requestScheme': 'https://',
      'requestUri': '/books/best-sellers/',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-bestsellers',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'scenarioDescription': 'Vi Bestsellers Page;  /books/best-sellers/',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/books/best-sellers/combined-print-and-e-book-fiction/',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-bestsellers',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'scenarioDescription': 'Vi Bestsellers Page;  /books/best-sellers/combined-print-and-e-book-fiction/',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestScheme': 'https://',
      'requestUri': '/books/best-sellers/combined-print-and-e-book-fiction/2016/03/01/',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_fe',
        'x-nyt-route': 'vi-bestsellers',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'scenarioDescription': 'Vi Bestsellers Page; /books/best-sellers/combined-print-and-e-book-fiction/2016/03/01/',
      'testId': 3,
    },
  ];

  return scenarios;
}
