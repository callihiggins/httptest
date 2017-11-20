# www-fastly

[![Build Status](https://drone.dv.nyt.net/api/badges/nytm/www-fastly/status.svg)](https://drone.dv.nyt.net/nytm/www-fastly)

This repo contains all artifacts that are relevant to our Fastly integration.

## Contributing

Please see: [CONTRIBUTING.md](https://github.com/nytm/www-fastly/blob/master/CONTRIBUTING.md) for our contributing docs. You must follow these.

## Filing a pull request

Please use the following template for PRs: [PULL_REQUEST_TEMPLATE.md](https://github.com/nytm/www-fastly/blob/master/PULL_REQUEST_TEMPLATE.md)

## Sandboxes

If you need help with a sandbox for testing your feature, ask in #fastly.

## Office hours

We host office hours daily at 14:30. Since we've moved floors (we're on 6 now) ask in #fastly if you would like to take advantage of these working sessions.

Thanks for contributing!


## Testing

The functional tests for this service are part of the repo. They should be updated along with configuration changes and filed in the same PR.

### Running tests

Tests can be run locally using the [drone-fastly-test](https://github.com/nytm/drone-fastly-test) image from the root of the repo with

```bash
docker run -t -i -e PLUGIN_SERVERNAME="www.stg.nytimes.com" -v `pwd`/tests:/tests drone-fastly-test:latest
```

This will run the test suite that exists in [/tests/www.nytimes.com.js](https://github.com/nytm/www-fastly/blob/master/tests/www.nytimes.com.js) using the `stg` environment. The host passed in (www.stg.nytimes.com) is parsed to determine the environment as well as the test file to load.

To run a specific suite within the host specification, add the `-e PLUGIN_SINGLETEST=""` parameter like so:

```bash
docker run -t -i -e PLUGIN_SERVERNAME="www.stg.nytimes.com" -e PLUGIN_SINGLETEST="content-homepage" -v `pwd`/tests:/tests drone-fastly-test:latest
```

This will only run the test suite file located in [/tests/www.nytimes.com/content-homepage.js](https://github.com/nytm/www-fastly/blob/master/tests/www.nytimes.com/content-homepage.js). Again, the directory to load the suite from, as well as the environment to pivot in the test cases, is determined based on the hostname (www.stg.nytimes.com) passed in to run the test suite against.

The same image is going to be used to run the tests in the build pipeline.

Read the [build](https://github.com/nytm/drone-fastly-test#build) instructions for creating and running the latest image locally.
