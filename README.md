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
docker run -e PLUGIN_SERVERNAME="www.nytimes.com" -v `pwd`/tests:/tests drone-fastly-test:latest
```

The same image is going to be used to run the tests in the build pipeline.

Read the [build](https://github.com/nytm/drone-fastly-test#build) instructions for creating and running the latest image locally.