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
    },
    {
      'id': 'FunctionalTestScenarioViStaticBackupOtherRoute',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'vi-static-backup-test': 'true',
      },
      'requestScheme': 'https://',
      'requestUri': '/trending/',
      'responseHeaderMatches': {
        'x-nyt-backend': 'projectvi_trending_fe',
        'x-nyt-route': 'trending'
      },
      'responseStatusCode': [200],
      'scenarioDescription': 'Test static backup enabled but non-story/homepage route',
      'testId': 2,
    },
    {
      'id': 'FunctionalTestScenarioViStaticBackup301',
      'isDeployedInEnv': {
        'prd': true,
        'stg': true,
        'dev': true,
      },
      'requestHeaders': {
        'vi-static-backup-test': 'true',
      },
      'requestScheme': 'https://',
      'requestUri': '/crosswords/primer',
      'responseHeaderMatches': {
        'x-nyt-route': 'games-web'
      },
      'responseStatusCode': [301],
      'scenarioDescription': 'Test static backup enabled and non-200 backend fetch status does not get converted to 503',
      'testId': 3,
    }
  ];

  return scenarios;
}
