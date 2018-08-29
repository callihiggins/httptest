# These values are universal for all Fastly services
# No need to change
terraform {
  backend "s3" {
    bucket         = "dv-fastly"
    dynamodb_table = "fastly-terraform-lock"
    region         = "us-east-1"
    encrypt        = true

    # set in drone-terraform
    #key=
    #role_arn=
  }
}
