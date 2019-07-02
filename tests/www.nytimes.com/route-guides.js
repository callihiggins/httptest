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
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/guides/culture/guide-to-the-metropolitan-museum-of-art',
      responseHeaderMatches: {
        'x-nyt-route': 'guides',
      },
      responseStatusCode: 200,
      scenarioDescription:
        'Test well guide',
      testId: 1
    },
    {
      id: 'FunctionalTestScenarioFilterAllQueryParamsForGuidesNotInDev',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: false
      },
      requestScheme: 'https://',
      requestUri: '/guides/culture/guide-to-the-metropolitan-museum-of-art?category=foobar&price=1234-1230',
      responseHeaderMatches: {
        "x-nyt-route": "guides",
        "x-nyt-backend": "beta_guides",
        "x-nyt-final-url": "/guides/culture/guide-to-the-metropolitan-museum-of-art"
      },
      responseStatusCode: 200,
      scenarioDescription: 'Guides strip all query params from request',
      testId: 2
    },
    {
      id: 'FunctionalTestScenarioAllowCategoryQueryParamForGiftGuides',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/guides/gifts/holiday-gift-guide?category=Food+%26+Drink&something=bar',
      responseHeaderMatches: {
        "x-nyt-route": "guides",
        "x-nyt-backend": "beta_guides",
        "x-nyt-final-url": "/guides/gifts/holiday-gift-guide?category=Food+%26+Drink"
      },
      responseStatusCode: 200,
      scenarioDescription: 'Gift Guides allows category query parameter',
      testId: 3
    },
    {
      id: 'FunctionalTestScenarioAllowPriceQueryParamForGiftGuides',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/guides/gifts/holiday-gift-guide?price=0-5000&foo=whatever',
      responseHeaderMatches: {
        "x-nyt-route": "guides",
        "x-nyt-backend": "beta_guides",
        "x-nyt-final-url": "/guides/gifts/holiday-gift-guide?price=0-5000"
      },
      responseStatusCode: 200,
      scenarioDescription: 'Gift Guides allows price query parameter',
      testId: 4
    },
    {
      id: 'FunctionalTestScenarioFilterQueryParamsStagingForGuides',
      isDeployedInEnv: {
        prd: false,
        stg: true,
        dev: false
      },
      requestScheme: 'https://',
      requestUri: '/guides/culture/guide-to-the-metropolitan-museum-of-art?SCOUT_API_HOST=api.guides.prd.nyt.net&category=foobar&price=1234-1230',
      responseHeaderMatches: {
        "x-nyt-route": "guides",
        "x-nyt-backend": "beta_guides",
        "x-nyt-final-url": "/guides/culture/guide-to-the-metropolitan-museum-of-art?SCOUT_API_HOST=api.guides.prd.nyt.net"
      },
      responseStatusCode: 200,
      scenarioDescription: 'Guides filter query string for SCOUT_API_HOST only in stg env',
      testId: 5
    },

  ];

  return scenarios;
}
