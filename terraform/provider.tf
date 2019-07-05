# pin the Fastly provider to 0.6.1. We should not get surprised by automatic upgrades
provider "fastly" {
  version = "= 0.6.1"
}
