# fastly-www

[![Build Status](https://drone.dv.nyt.net/api/badges/nytm/fastly-www/status.svg)](https://drone.dv.nyt.net/nytm/fastly-www)

This repo contains all artifacts that are relevant to our Fastly integration.

## Contributing

Please see: [CONTRIBUTING.md](https://github.com/nytm/fastly-www/blob/master/CONTRIBUTING.md) for our contributing docs. You must follow these.

## Filing a pull request

Please use the following template for PRs: [PULL_REQUEST_TEMPLATE.md](https://github.com/nytm/fastly-www/blob/master/PULL_REQUEST_TEMPLATE.md)

## Sandboxes

The sandbox policy and documentation can be found [here](https://docs.dv.nyt.net/fastly/guides/www_sandboxes/)

## Office hours

We host office hours every Tuesday and Thursday at 14:30 on the 5th Floor, West. Ask in [#fastly](https://nytimes.slack.com/messages/C1WFYD7FF/) Slack channel if you would like to take advantage of these working sessions.

Thanks for contributing!


## Testing

The functional tests for this service are part of the repo. They should be updated along with configuration changes and filed in the same PR.

### Writing tests
The guide of writing the tests can be found [here](https://github.com/nytm/drone-fastly-tests/blob/master/writing-tests.md).

### Running tests

The tests are run in the build pipeline in Drone using the [drone-fastly-tests](https://github.com/nytm/drone-fastly-tests) image.

Tests can be run locally using the same image from the root of the repo with

This will run all the route-*.yml

```bash
docker run --rm \
    -v $(pwd)/tests/www.nytimes.com/:/tests/tests.yaml \
    -e "TEST_HOST=www.dev.nytimes.com" \
    -e "TEST_ENV=dev" \
    nytimes/httptest
```

This will run the test suite that exists in [/tests/www.nytimes.com.js](https://github.com/nytm/fastly-www/blob/master/tests/www.nytimes.com.js) using the `stg` environment. The host passed in (www.stg.nytimes.com) is parsed to determine the environment as well as the test file to load.

To run a specific suite within the host specification, change the `route-story.yml` parameter like so:

```bash
docker run --rm \
    -v $(pwd)/tests/www.nytimes.com/route-story.yml:/tests/tests.yaml \
    -e "TEST_HOST=www.dev.nytimes.com" \
    -e "TEST_ENV=dev" \
    nytimes/httptest
```

More insight about test [docs](https://github.com/nytimes/httptest#run-tests-locally)

This will only run the test suite file located in [/tests/www.nytimes.com/](https://github.com/nytm/fastly-www/tree/master/tests/www.nytimes.com). Again, the directory to load the suite from, as well as the environment to pivot in the test cases, is determined based on the hostname (www.stg.nytimes.com) passed in to run the test suite against.

The same image is going to be used to run the tests in the build pipeline.

Read the [build](https://github.com/nytm/drone-fastly-test#build) instructions for creating and running the latest image locally.
