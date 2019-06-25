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
      'requestUri': '/paidpost/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-paidpost',
        'x-nyt-backend': 'projectvi_fe',
        'x-frame-options': 'DENY',
        'x-gdpr': '0',
      },
      'scenarioDescription': 'Test HTTPS; paidpost; secure',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'Referer': 'https://media.insightexpress.com/foo/bar',
      },
      'requestScheme': 'https://',
      'requestUri': '/paidpost/mexico-tourism/my-journey-to-mexico.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-paidpost',
        'x-nyt-backend': 'projectvi_fe',
        'x-gdpr': '0',
      },
      'responseHeadersNotPresent': [
          'x-frame-options'
      ],
      'scenarioDescription': 'Test missing x-frame-options with whitelisted referer',
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
      'requestUri': '/paidpost/advertiser/headline.html?previewDate=1561476655968&contentUri=nyt://paidpost/44cba1ee-7c5c-5bba-a51f-cf70b111515e&device=desktop&scooppreview&contentId=100000006289908&extraParam',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-paidpost',
        'x-nyt-backend': 'projectvi_fe',
        'x-frame-options': 'DENY',
        'x-gdpr': '0',
        'x-nyt-final-url': '/paidpost/advertiser/headline.html',
      },
      'scenarioDescription': 'www host; test query string filter removed',
      testId: 3
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true
      },
      requestHeaders: {
        Host: 'alpha-preview.dev.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri:
        '/paidpost/advertiser/headline.html?previewDate=1561476655968&contentUri=nyt://paidpost/44cba1ee-7c5c-5bba-a51f-cf70b111515e&device=desktop&scooppreview&contentId=100000006289908&extraParam=2&emptyParam',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-paidpost',
        'x-nyt-backend': 'alpha_preview',
        'x-gdpr': '0',
        'x-nyt-final-url':
          '/paidpost/advertiser/headline.html?contentId=100000006289908&contentUri=nyt://paidpost/44cba1ee-7c5c-5bba-a51f-cf70b111515e&device=desktop&previewDate=1561476655968&scooppreview'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      scenarioDescription:
        'Alpha host /paidpost; test query string sort and filter whitelist preview; /paidpost',
      testId: 4
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestHeaders: {
        Host: 'alpha-preview.stg.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri:
        '/paidpost/advertiser/headline.html?previewDate=1561476655968&contentUri=nyt://paidpost/44cba1ee-7c5c-5bba-a51f-cf70b111515e&device=desktop&scooppreview&contentId=100000006289908&extraParam=2&emptyParam',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-paidpost',
        'x-nyt-backend': 'alpha_preview',
        'x-gdpr': '0',
        'x-nyt-final-url':
          '/paidpost/advertiser/headline.html?contentId=100000006289908&contentUri=nyt://paidpost/44cba1ee-7c5c-5bba-a51f-cf70b111515e&device=desktop&previewDate=1561476655968&scooppreview'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      scenarioDescription:
        'Alpha host /paidpost; test query string sort and filter whitelist preview; /paidpost',
      testId: 5
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestHeaders: {
        Host: 'alpha-preview.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri:
        '/paidpost/advertiser/headline.html?previewDate=1561476655968&contentUri=nyt://paidpost/44cba1ee-7c5c-5bba-a51f-cf70b111515e&device=desktop&scooppreview&contentId=100000006289908&extraParam=2&emptyParam',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-paidpost',
        'x-nyt-backend': 'alpha_preview',
        'x-gdpr': '0',
        'x-nyt-final-url':
          '/paidpost/advertiser/headline.html?contentId=100000006289908&contentUri=nyt://paidpost/44cba1ee-7c5c-5bba-a51f-cf70b111515e&device=desktop&previewDate=1561476655968&scooppreview'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      scenarioDescription:
        'Alpha host /paidpost; test query string sort and filter whitelist preview; /paidpost',
      testId: 6
    }
  ];

  return scenarios;
}
