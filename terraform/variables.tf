variable "env" {
  type = "string"
}

variable "app" {
  type = "string"
  default = "www"
}

variable "service_name" {
  type = "string"
}

variable "sumologic_endpoint" {
  type = "map"

  default = {
    dev = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV090sPFU_YnnEP_F61BBPpciroz627Cc5zoPONnZQtGWWIiqPAs6g3LsPXOc3JfFUPl44yl-tlLnkH-Pn7xp1X9QarWeCQeQjSPeA0wqbLn-A=="
    stg = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV090sPFU_YnnEP_F61BBPpciroz627Cc5zoPONnZQtGWWIiqPAs6g3LsPXOc3JfFUPl44yl-tlLnkH-Pn7xp1X9QarWeCQeQjSPeA0wqbLn-A=="
    prd = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV3DIdcy2GqnQ5DMhk6CZkjlLK9C5V5fjRSlaVm4RJg3dU1REHf-_owjetrn1mzlLqDx1KlNQ6qwtrgHf1KwvOaVcZBHpQSdqG-tFYf0OFYEUQ=="
  }
}

variable "bigquery_secret_key" {
  type = "string"
}
