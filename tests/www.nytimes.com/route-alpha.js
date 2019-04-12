var suite = require('/lib/suite.js');
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true
      },
      requestHeaders: {
        Host: 'apple.dev.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-timeswire',
        'x-nyt-backend': 'alpha_fe',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host apple.dev.nytimes.com; Vi Timeswire Page; /timeswire',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true
      },
      requestHeaders: {
        Host: 'apple-preview.dev.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-timeswire',
        'x-nyt-backend': 'alpha_preview',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host apple-preview.dev.nytimes.com; Vi Timeswire Page; /timeswire',
      testId: 2
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true
      },
      requestHeaders: {
        Host: 'apple-test.dev.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-timeswire',
        'x-nyt-backend': 'alpha_test',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host apple-test.dev.nytimes.com; test Vi Timeswire Page; /timeswire',
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
        Host: 'apple-preview.dev.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/section/well',
      responseHeaderMatches: {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test Collection fallback to NYT5; /section/well',
      testId: 4
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true
      },
      requestHeaders: {
        Host: 'apple-preview.dev.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/section/opinion',
      responseHeaderMatches: {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'alpha_preview',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test scoop collection preview;/section/opinion',
      testId: 5
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestHeaders: {
        Host: 'apple.stg.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-timeswire',
        'x-nyt-backend': 'alpha_fe',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host apple.stg.nytimes.com; Vi Timeswire Page; /timeswire',
      testId: 6
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestHeaders: {
        Host: 'apple-preview.stg.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-timeswire',
        'x-nyt-backend': 'alpha_preview',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host apple-preview.stg.nytimes.com; Vi Timeswire Page; /timeswire',
      testId: 7
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestHeaders: {
        Host: 'apple-preview.stg.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/section/well',
      responseHeaderMatches: {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test Collection fallback to NYT5; /section/well',
      testId: 9
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestHeaders: {
        Host: 'apple.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-timeswire',
        'x-nyt-backend': 'alpha_fe',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host apple.nytimes.com; Vi Timeswire Page; /timeswire',
      testId: 11
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestHeaders: {
        Host: 'apple-preview.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/timeswire',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-timeswire',
        'x-nyt-backend': 'alpha_preview',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host apple-preview.nytimes.com; Vi Timeswire Page; /timeswire',
      testId: 12
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestHeaders: {
        Host: 'apple-preview.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri: '/section/well',
      responseHeaderMatches: {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'collection_fe',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test Collection fallback to NYT5; /section/well',
      testId: 13
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestHeaders: {
        Host: 'apple-preview.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri:
        '/section/opinion?previewDate=1547060138970&contentUri=nyt://legacycollection/fdbfedd6-69a1-5364-8437-d5870bb61b5a&device=desktop&scooppreview&contentId=100000004178830',
      responseHeaderMatches: {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'alpha_preview',
        'x-gdpr': '0'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test scoop collection preview;/section/opinion',
      testId: 14
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true
      },
      requestHeaders: {
        Host: 'apple-preview.dev.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri:
        '/section/opinion?contentUri=112222&device=desktop&scooppreview',
      responseHeaderMatches: {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'alpha_preview',
        'x-gdpr': '0',
        'x-nyt-final-url':
          '/section/opinion?contentUri=112222&device=desktop&scooppreview'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test query string filter preview;/section/opinion',
      testId: 15
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestHeaders: {
        Host: 'apple-preview.stg.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri:
        '/section/opinion?contentUri=112222&device=desktop&scooppreview',
      responseHeaderMatches: {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'alpha_preview',
        'x-gdpr': '0',
        'x-nyt-final-url':
          '/section/opinion?contentUri=112222&device=desktop&scooppreview'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test query string filter preview;/section/opinion',
      testId: 16
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: false,
        dev: false
      },
      requestHeaders: {
        Host: 'apple-preview.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri:
        '/section/opinion?contentUri=112222&device=desktop&scooppreview',
      responseHeaderMatches: {
        'x-nyt-route': 'collection',
        'x-nyt-backend': 'alpha_preview',
        'x-gdpr': '0',
        'x-nyt-final-url':
          '/section/opinion?contentUri=112222&device=desktop&scooppreview'
      },
      responseHeaderPattern: {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test query string filter preview;/section/opinion',
      testId: 17
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true
      },
      requestHeaders: {
        Host: 'alpha.dev.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri:
        '/.info',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-info',
        'x-nyt-backend': 'alpha_fe',
        'x-nyt-final-url':
          '/.info'
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test info route on alpha_fe; /.info',
      testId: 18
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
        '/.info',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-info',
        'x-nyt-backend': 'alpha_preview',
        'x-nyt-final-url':
          '/.info'
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test info route on alpha_preview; /.info',
      testId: 19
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestHeaders: {
        Host: 'alpha.stg.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri:
        '/.info',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-info',
        'x-nyt-backend': 'alpha_fe',
        'x-nyt-final-url':
          '/.info'
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test info route on alpha_fe; /.info',
      testId: 20
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
        '/.info',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-info',
        'x-nyt-backend': 'alpha_preview',
        'x-nyt-final-url':
          '/.info'
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test info route on alpha_preview; /.info',
      testId: 21
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true
      },
      requestHeaders: {
        Host: 'alpha.dev.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri:
        '/code/welcome',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-code',
        'x-nyt-backend': 'alpha_fe',
        'x-nyt-final-url':
          '/code/welcome'
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test /code route on alpha_fe; /code/welcome',
      testId: 22
    },
    {
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: false,
        stg: false,
        dev: true
      },
      requestHeaders: {
        Host: 'alpha.stg.nytimes.com'
      },
      requestScheme: 'https://',
      requestUri:
        '/code/welcome',
      responseHeaderMatches: {
        'x-nyt-route': 'vi-code',
        'x-nyt-backend': 'alpha_fe',
        'x-nyt-final-url':
          '/code/welcome'
      },
      responseStatusCode: [200],
      scenarioDescription:
        'Alpha host; test /code route on alpha_fe; /code/welcome',
      testId: 23
    },
  ];

  return scenarios;
}
