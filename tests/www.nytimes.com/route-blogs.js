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
      'requestUri': '/politics/first-draft/2015/05/21/republicans-plan-to-replace-health-law-is-shrug-senator-says/',
      'responseHeaderMatches': {
        'x-nyt-backend': 'blogs',
        'x-nyt-route': 'blog',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,        
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test routing; first-draft; Blogs; /politics/first-draft/2015/05/21/republicans-plan-to-replace-health-law-is-shrug-senator-says/',
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
      'requestUri': '/news/affordable-care-act/2014/03/06/more-than-one-way-to-buy-a-plan/',
      'responseHeaderMatches': {
        'x-nyt-backend': 'blogs',
        'x-nyt-route': 'blog',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test routing; /news; Blogs; /news/affordable-care-act/2014/03/06/more-than-one-way-to-buy-a-plan/',
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
      'requestUri': '/times-insider/2014/04/01/dangerous-roads-constant-crises-adam-nossiter-on-central-africa/',
      'responseHeaderMatches': {
        'x-nyt-backend': 'blogs',
        'x-nyt-route': 'blog',
        'x-gdpr': '0',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test routing; times-insider; Blogs; /times-insider/2014/04/01/dangerous-roads-constant-crises-adam-nossiter-on-central-africa/',
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
      'requestUri': '/live/2016-golden-globes/?gdpr=1',
      'responseHeaderMatches': {
        'x-nyt-backend': 'blogs',
        'x-nyt-route': 'blog',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },        
      'responseStatusCode': [200,301,404],
      'scenarioDescription': 'Test routing; /live; blogs; /live/2016-golden-globes/',
      'testId': 4,
    },
  ];

  return scenarios;
}
