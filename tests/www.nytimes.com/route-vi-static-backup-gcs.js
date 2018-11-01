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
      'id': 'FunctionalTestScenarioViStaticBackupHomepage',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'vi-static-backup-test': 'true',
      },
      'requestScheme': 'https://',
      'requestUri': '/',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-homepage',
        'x-nyt-backend': 'projectvi_static_backup_gcs',
      },
      'responseHeadersPresent': ["x-goog-hash","x-goog-storage-class","x-guploader-uploadid"],
      'responseStatusCode': [200],
      'scenarioDescription': 'Test static backup of the homepage ',
      'testId': 1,
    },
    {
      'id': 'FunctionalTestScenarioViStaticBackupStory',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'vi-static-backup-test': 'true',
      },
      'requestScheme': 'https://',
      'requestUri': '/2017/10/16/upshot/this-is-a-test-article.html',
      'responseHeaderMatches': {
        'x-nyt-route': 'vi-story',
        'x-nyt-backend': 'projectvi_static_backup_gcs',
      },
      'responseHeadersPresent': ["x-guploader-uploadid"],
      'responseStatusCode': [503],
      'scenarioDescription': 'Test static backup of a story that we know will not exist in the backup',
      'testId': 1,
    }
  ];

  return scenarios;
}
