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
      id: 'FunctionalTestScenarioDefinitionForHtmlPage',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true,
      },
      requestScheme: 'https://',
      requestUri: '/real-estate/find-a-home?gdpr=1',
      responseHeaderMatches: {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'x-gdpr': '1',
      },
      'responseHeaderPattern': {
        'set-cookie': /(?:^|,)nyt-gdpr=(0|1);/,
      },
      responseStatusCode: 200,
      scenarioDescription:
        'Test real estate: "/real-estate/find-a-home" ',
      testId: 1
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/find-a-home?price=5&bad1=4&region=2&bad2=5&neighborhood=hello',
      'responseHeaderMatches': {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'x-nyt-final-url': '/real-estate/find-a-home?neighborhood=hello&price=5&region=2',
      },
      'responseStatusCode': 200,
      'scenarioDescription': 'Test realestate querystring filter',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/homes-for-sale/?locations%5B%5D=new-york-ny-usa&sortBy=dateposted-desc',
      'responseHeaderMatches': {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'location': 'https://m.realestatelistings.nytimes.com/search?channel=sales&location=new-york-ny-usa&search=See+Available+Homes'
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test realestate mobile redirect',
      'testId': 3,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/homes-for-rent/?locations%5B%5D=new-york-ny-usa&sortBy=dateposted-desc',
      'responseHeaderMatches': {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'location': 'https://m.realestatelistings.nytimes.com/search?channel=rentals&location=new-york-ny-usa&search=See+Available+Homes'
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test realestate mobile redirect',
      'testId': 4,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/usa/ny/new-york/upper-east-side/homes-for-sale',
      'responseHeaderMatches': {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'location': 'https://m.realestatelistings.nytimes.com/search?channel=sales&search=See+Available+Homes&location=upper-east-side-new-york-ny-usa'
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test realestate mobile redirect',
      'testId': 5,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/usa/ny/new-york/upper-east-side/homes-for-rent',
      'responseHeaderMatches': {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'location': 'https://m.realestatelistings.nytimes.com/search?channel=rentals&search=See+Available+Homes&location=upper-east-side-new-york-ny-usa'
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test realestate mobile redirect',
      'testId': 6,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/usa/ny/brooklyn/clinton-hill/homes-for-rent/333-washington-avenue/46-3257305',
      'responseHeaderMatches': {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'location': 'https://m.realestatelistings.nytimes.com/listing/46-3257305'
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test realestate mobile redirect',
      'testId': 7,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/usa/ny/brooklyn/clinton-hill/homes-for-sale/333-washington-avenue/46-3257305',
      'responseHeaderMatches': {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'location': 'https://m.realestatelistings.nytimes.com/listing/46-3257305'
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test realestate mobile redirect',
      'testId': 8,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/find-a-home',
      'responseHeaderMatches': {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'location': 'https://m.realestatelistings.nytimes.com/'
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test realestate mobile redirect',
      'testId': 9,
    },
    {
      'id': 'FunctionalTestScenarioDefinitionForHtmlPage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true
      },
      'requestHeaders': {
        'User-agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25',
      },
      'requestScheme': 'https://',
      'requestUri': '/real-estate/my-real-estate',
      'responseHeaderMatches': {
        'x-nyt-route': 'real-estate',
        'x-nyt-backend': 'realestate_fe',
        'location': 'https://m.realestatelistings.nytimes.com/savedlistings'
      },
      'responseStatusCode': 301,
      'scenarioDescription': 'Test realestate mobile redirect',
      'testId': 10,
    },
  ];

  return scenarios;
}
