# pin the Fastly provider to 0.1.3. We should not get surprised by automatic upgrades
provider "fastly" {
  version = "= 0.3.0"
}
