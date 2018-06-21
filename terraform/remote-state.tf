terraform {
  backend "gcs" {
    bucket  = "nyt-bsre-prd-tfstate"
    project = "nyt-bsre-prd"
  }
}
