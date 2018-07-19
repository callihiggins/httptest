# Contributing

## Contributing is simple:

### 1. Make Changes

1. Clone the repo and create a branch off of master:
    * `git checkout master; git pull; git checkout -b <branch_name>`
    * Using a slightly descriptive name for the branch is beneficial
1. See [dv-fastly-guide][dv-fastly-guide] for documentation and coding standards; currently this is a WIP
1. Add as many commits as you like
1. Be sure to add tests to the suite in `/tests` for your changes
    * Docs are in [drone-fastly-tests][drone-fastly-tests]
1. Push the branch to origin:
    * `git push origin <branch_name>`
    * This will run CI and tests using Drone
    * You can find Drone's build status in GitHub's “commits” view of your branch ([for example](https://github.com/nytm/fastly-www/commits/article)) — look for the green √ or red X
    * If it's broken, fix it and push again
1. Rebase from origin/master `git rebase -i origin/master`
    * Be kind and squash all but the first commit if you have many
    * Rewrite to a nice descriptive commit
    * You can continue to do this after opening the PR if you need to make many changes based on reviews or ongoing work
1. If it helps, you can test your changes interactively by [deploying your branch to a Fastly sandbox service](https://github.com/nytm/dv-fastly-guide/blob/master/Topics/www_sandboxes.md)

### 2. Integrate Changes

1. Open a PR in the GitHub Web interface
    * Reviewers will automatically be selected from `CODEOWNERS`
    * Fill out all applicable parts of the template that is automatically populated in the PR description
    * Review your diffs again just to be sure
1. Be patient, or ping the reviewer on Slack if it's urgent
    * We strive to review within 1 business day
1. Respond to comments by pushing more commits or simply explaining

### 3. Deploy Changes

1. Once the reviewer has approved the PR:
    * It is possible other code has been merged to master that has not yet deployed to production and there could be an ongoing staging test for a scheduled launch
    * A `CODEOWNER` will merge your branch when safe
1. Delete the branch
1. When merged, your change will be deployed to staging and queued up for the next daily production deployment at 11:30AM or 3:30PM
1. Coordinate if the deployment is required outside of those windows

## Guidelines:

* Master is protected:
  * No pushes directly to master
  * Require approvals for merges
    * Currently two approvals by CODEOWNERS are required
* This is basically [GitHub Flow][ghf].
* Follow [Tim Pope's advice][tpa] on commit messages.
* Push early and often, so your colleagues can see what you're working on.
* Rebase and force push as often as you like. It's your branch.
* Avoid long running branches.


[dv]:  https://github.com/orgs/nytm/teams/delivery-engineering
[ghf]: https://guides.github.com/introduction/flow/index.html
[tpa]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[dv-fastly-guide]: https://github.com/nytm/dv-fastly-guide
[drone-fastly-tests]: https://github.com/nytm/drone-fastly-tests
