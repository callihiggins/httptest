var suite = require("/lib/suite.js");
var scenarios = getScenarioEvents();
suite.run(suite, scenarios);

/**
 * @return array
 */
function getScenarioEvents() {
  var scenarios = [
    {
      id: 'FunctionalTestScenarioDefinitionForSVCAdd',
      isDeployedInEnv: {
        prd: true,
        stg: true,
        dev: true
      },
      requestScheme: 'https://',
      requestUri: '/svc/add/v1/collection.json?sort=newest&name=science&language=en&dom=https%3A/www.nytimes.com&collection_path=section/science&coll_type=sectioncollection&topic_query=%28sectioncollection%3A%22science%22%20OR%20%28section_name%3A%22Science%22%20AND%20%28source%3A%22The%20New%20York%20Times%22%20OR%20source%3A%22International%20Herald%20Tribune%22%29%29%29%20AND%20-asset_id%3A100000005374196&type=article%2Cblogpost%2Cmultimedia&page=0',
      responseHeaderMatches: {
        'x-nyt-route': 'add-svc',
        'access-control-allow-origin': '*',
      },
      responseStatusCode: [200],
      scenarioDescription: 'Test /svc/add is served from add',
      testId: 1
    },
  ];

  return scenarios;
}
