## Contributing

#### Contributing is simple:

1. Clone the repo and create a branch off of master `git checkout master; git pull; git checkout -b <branch_name>`
1. Using a slightly descriptive name for the branch is beneficial.
1. See [dv-fastly-guide][dv-fastly-guide] for documentation and coding standards. Currently this is a WIP.
1. Add as many commits as you like
1. Be sure to add tests to the suite in `/tests` for your changes. Docs exist or are forthcoming in [dv-fastly-guide][dv-fastly-guide].
1. Push the branch to origin `git push origin <branch_name>`
    1. this will deploy to dev using Drone
    1. If it's broken, fix it and push again.
1. Open a PR in the GitHub Web interface.
    1. Reviewers will automatically be selected from `CODEOWNERS`
    1. Fill out all applicable parts of the template that is automatically populated in the PR description
    1. Review your diffs again just to be sure
1. Be patient, or ping the reviewer on Slack if it's urgent. We strive to review within 1 business day.
1. Respond to comments by pushing more commits or simply explaining
1. Once the reviewer has approved the PR: 
    1. It is possible other code has been merged to master that has not yet deployed to production and there could be an ongoing staging test for a scheduled launch.
    1. A `CODEOWNER` will merge your branch when safe
1. Delete the branch
1. Your change will be deployed to production in the next tagged release.

#### Guidelines:

* Master is protected:
  * no pushes directly to master
  * require approvals for merges
* Currently two approvals by CODEOWNERS are required
* This is basically [GitHub Flow][ghf].
* Follow [Tim Pope's advice][tpa] on commit messages.
* Push early and often, so your colleagues can see what you're working on.
* Rebase and force push as often as you like. It's your branch.
* Avoid long running branches




[dv]:  https://github.com/orgs/nytm/teams/delivery-engineering
[ghf]: https://guides.github.com/introduction/flow/index.html
[tpa]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[dv-fastly-guide]: https://github.com/nytm/dv-fastly-guide
