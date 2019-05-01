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
      'requestUri': '/svc/web-products/geoip-test.html?ip-override=85.90.227.224',
      'responseHeaderMatches': {
        'x-nyt-continent': 'EU',
        'x-nyt-country': 'GB',
        'x-nyt-region': 'LND',
        'x-nyt-city': 'london',
      },
      'responseHeaderPattern': {
        'x-nyt-gmt-offset': /(0|100)/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test geo hash return value for IP 85.90.227.224',
      'testId': 25,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/web-products/geoip-test.html?ip-override=112.120.130.250',
      'responseHeaderMatches': {
        'x-nyt-gmt-offset': '800',
        'x-nyt-continent': 'AS',
        'x-nyt-country': 'HK',
        'x-nyt-region': 'NO REGION',
        'x-nyt-city': 'quarry bay',
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test geo hash return value for IP 112.120.130.250',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/web-products/geoip-test.html?ip-override=170.157.174.185',
      'responseHeaderMatches': {
        'x-nyt-continent': 'OC',
        'x-nyt-country': 'AU',
        'x-nyt-region': 'ACT',
        'x-nyt-city': 'canberra',
      },
      'responseHeaderPattern': {
        'x-nyt-gmt-offset': /1[0-1]00/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test geo hash return value for IP 170.157.174.185',
      'testId': 11,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/svc/web-products/geoip-test.html?ip-override=137.99.78.82',
      'responseHeaderMatches': {
        'x-nyt-continent': 'NA',
        'x-nyt-country': 'US',
        'x-nyt-region': 'CT',
        'x-nyt-city': 'storrs mansfield',
      },
      'responseHeaderPattern': {
        'x-nyt-gmt-offset': /-[45]00/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test geo hash return value for IP 137.99.78.82',
      'testId': 272,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/?ip-override=173.63.201.100',
      'responseHeaderMatches': {
        'x-nyt-continent': 'NA',
        'x-nyt-country': 'US',
        'x-nyt-region': 'NJ',
        'x-nyt-city': 'holmdel',
      },
      'responseHeaderPattern': {
        'x-nyt-gmt-offset': /-[45]00/,
        'x-nyt-geo-hash': /NAUSNY-[45]00/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test geo hash return value for IP 173.63.201.100, NJ should get NY geo-hash',
      'testId': 273,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/?ip-override=192.206.151.131',
      'responseHeaderMatches': {
        'x-nyt-continent': 'NA',
        'x-nyt-country': 'CA',
        'x-nyt-region': 'ON',
        'x-nyt-city': 'toronto',
      },
      'responseHeaderPattern': {
        'x-nyt-gmt-offset': /-[45]00/,
        'x-nyt-geo-hash': /NACA-[45]00/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test geo hash return value for IP 192.206.151.131, CA should get CA geo-hash',
      'testId': 274,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/?ip-override=52.95.131.27',
      'responseHeaderMatches': {
        'x-nyt-continent': 'OC',
        'x-nyt-country': 'AU',
        'x-nyt-region': 'NSW',
        'x-nyt-city': 'sydney',
      },
      'responseHeaderPattern': {
        'x-nyt-gmt-offset': /1[01]00/,
        'x-nyt-geo-hash': /OCAU1[01]00/,
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test geo hash return value for IP 52.95.131.27, AU should get AU geo-hash',
      'testId': 275,
    }

  ];

  return scenarios;
}
