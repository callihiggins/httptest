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
      'id': 'FunctionalTestScenarioDefinitionForAbra',
      'scenarioDescription': 'Project Ocean ABRA test from Brazil on the Home route should be allocated and return the debug-vi-abtest header',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/?ip-override=187.44.210.58', // This should map to Brazil
      'requestHeaders': {
        'project-ocean-test': 'true'
      },
      'requestHeaderCookie': [
        'nyt-a=eb6222b5c4b843ffd255ca86f7decb8c'
      ],
      'responseHeaderContains': {
        'x-nyt-country': 'BR',
        'debug-vi-abtest': 'dfp_latamv2=1_gdpr_test'
      },
      'testId': 1
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForAbra',
      'scenarioDescription': 'Project Ocean test ABRA from Brazil on the Story route should be allocated and return the debug-vi-abtest header',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/2019/05/29/us/terrill-thomas-milwaukee-settlement.html?ip-override=187.44.210.58', // This should map to Brazil
      'requestHeaders': {
        'project-ocean-test': 'true'
      },
      'requestHeaderCookie': [
        'nyt-a=eb6222b5c4b843ffd255ca86f7decb8c'
      ],
      'responseHeaderContains': {
        'x-nyt-country': 'BR',
        'debug-vi-abtest': 'dfp_latamv2=1_gdpr_test'
      },
      'testId': 2
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForAbra',
      'scenarioDescription': 'Project Ocean test ABRA from Brazil on the Collection route should not be allocated and return the debug-vi-abtest header',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/column/36-hours?ip-override=187.44.210.58', // This should map to Brazil
      'requestHeaders': {
        'project-ocean-test': 'true'
      },
      'requestHeaderCookie': [
        'nyt-a=eb6222b5c4b843ffd255ca86f7decb8c'
      ],
      'responseHeaderContains': {
        'x-nyt-country': 'BR',
        'x-nyt-route': 'vi-collection'
      },
      'responseHeadersNotPresent': [
        'debug-vi-abtest'
      ],
      'testId': 2
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForAbra',
      'scenarioDescription': 'Project Ocean ABRA test from US on the Home route should not be allocated and return the debug-vi-abtest header',
      'isDeployedInEnv': {
          'prd': true,
          'stg': true,
          'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'requestHeaders': {
          'project-ocean-test': 'true'
      },
      'requestHeaderCookie': [
        'nyt-a=eb6222b5c4b843ffd255ca86f7decb8c'
      ],
      'responseHeaderContains': {
          'x-nyt-country': 'US'
      },
      'responseHeadersNotPresent': [
        'debug-vi-abtest'
      ],
      'testId': 3
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForAbra',
      'scenarioDescription': 'Project Ocean test ABRA from US on the Story route should not be allocated and return the debug-vi-abtest header',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/2019/05/29/us/terrill-thomas-milwaukee-settlement.html',
      'requestHeaders': {
        'project-ocean-test': 'true'
      },
      'requestHeaderCookie': [
        'nyt-a=eb6222b5c4b843ffd255ca86f7decb8c'
      ],
      'responseHeaderContains': {
        'x-nyt-country': 'US'
      },
      'responseHeadersNotPresent': [
        'debug-vi-abtest'
      ],
      'testId': 4
    }
  ];

  return scenarios;
}
