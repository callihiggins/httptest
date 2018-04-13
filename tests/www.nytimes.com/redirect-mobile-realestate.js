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
      'id': 'FunctionalTestScenarioDefinitionForRealEstateRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/find-a-home',
      'responseHeaderMatches': {
        'location': 'https://m.realestatelistings.nytimes.com/',
      },
      'responseStatusCode': 302,
      'scenarioDescription': 'Test mobile redirect; realestate; cookie "nyt-mobile=1"; iPhone; does redirect',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRealEstateRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/homes-for-sale',
      'responseHeaderMatches': {
        'location': 'https://m.realestatelistings.nytimes.com/?channel=sales',
      },
      'responseStatusCode': 302,
      'scenarioDescription': 'Test mobile realestate sales channel redirect; realestate; cookie "nyt-mobile=1";  mobile; does redirect',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRealEstateRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/homes-for-rent',
      'responseHeaderMatches': {
        'location': 'https://m.realestatelistings.nytimes.com/?channel=rentals',
      },
      'responseStatusCode': 302,
      'scenarioDescription': 'Test mobile realestate rental channel redirect; realestate; mobile; cookie "nyt-mobile=1"; does redirect',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRealEstateRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/usa/ny/new-york/upper-east-side/homes-for-sale/333-east-79th-street/185-18332621',
      'responseHeaderMatches': {
        'location': 'https://m.realestatelistings.nytimes.com/listing/185-18332621',
      },
      'responseStatusCode': 302,
      'scenarioDescription': 'Test mobile realestate rental channel redirect; realestate; mobile; cookie "nyt-mobile=1"; does redirect',
      'testId': 4,
    },    
    {
      'id': 'FunctionalTestScenarioDefinitionForRealEstateRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/usa/ny/brooklyn/park-slope/building/939-union-street/5304',
      'responseHeaderMatches': {
        'location': 'https://m.realestatelistings.nytimes.com/',
      },
      'responseStatusCode': 302,
      'scenarioDescription': 'Test mobile realestate buildings redirect; realestate; mobile; cookie "nyt-mobile=1"; does redirect',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForRealEstateRedirect',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
        'sbx': false,
      },
      'requestHeaderCookie': 'nyt-mobile=1',
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/my-real-estate',
      'responseHeaderMatches': {
        'location': 'https://m.realestatelistings.nytimes.com/savedlistings',
      },
      'responseStatusCode': 302,
      'scenarioDescription': 'Test mobile realestate saved listings redirect; realestate; mobile; cookie "nyt-mobile=1"; does redirect',
      'testId': 6,
    },     
  ];

  return scenarios;
}
